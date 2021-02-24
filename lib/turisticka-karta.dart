import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:redux/redux.dart';

class Item {
  final int id;
  final String body;
  final DateTime dateFrom;
  final DateTime dateTo;

  Item(
      {@required this.id,
      @required this.body,
      @required this.dateTo,
      @required this.dateFrom});

  Item copyWith({int id, String body, DateTime dateFrom, DateTime dateTo}) {
    return Item(
        id: id ?? this.id,
        body: body ?? this.body,
        dateTo: dateTo ?? this.dateTo,
        dateFrom: dateFrom ?? this.dateFrom);
  }
}

class ListState {
  final List<Item> items;
  ListState({@required this.items});

  ListState.initialState() : items = List.unmodifiable(<Item>[]);
}

class AddItemAction {
  static int _id = 0;
  final String item;
  final DateTime dateFrom;
  final DateTime dateTo;

  AddItemAction(this.item, this.dateTo, this.dateFrom) {
    _id++;
  }

  int get id => _id;
}

class RemoveItemAction {
  final Item item;

  RemoveItemAction(this.item);
}

class RemoveItemsAction {}

ListState reducer(ListState state, action) {
  return ListState(items: itemReducer(state.items, action));
}

List<Item> itemReducer(List<Item> state, action) {
  if (action is AddItemAction) {
    return []
      ..addAll(state)
      ..add(Item(
          id: action.id,
          body: action.item,
          dateTo: action.dateTo,
          dateFrom: action.dateFrom));
  }

  if (action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  if (action is RemoveItemsAction) {
    return List.unmodifiable([]);
  }

  return state;
}

class _ViewModel {
  final List<Item> items;
  final Function(String, DateTime, DateTime) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;

  _ViewModel(
      {this.items, this.onAddItem, this.onRemoveItem, this.onRemoveItems});

  factory _ViewModel.create(Store<ListState> store) {
    _onAddItem(String body, DateTime dateFrom, DateTime dateTo) {
      store.dispatch(AddItemAction(body, dateFrom, dateTo));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
      store.dispatch(RemoveItemsAction());
    }

    return _ViewModel(
        items: store.state.items,
        onAddItem: _onAddItem,
        onRemoveItem: _onRemoveItem,
        onRemoveItems: _onRemoveItems);
  }
}

class AddItemWidget extends StatefulWidget {
  final _ViewModel model;

  AddItemWidget(this.model);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();

  DateTime selectedDateTo = DateTime.now();

  Future<Null> _selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateTo)
      setState(() {
        selectedDateTo = picked;
      });
  }

  DateTime selectedDateFrom = DateTime.now();

  Future<Null> _selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateFrom,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateFrom)
      setState(() {
        selectedDateFrom = picked;
      });
  }

  String selection;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.green),
        borderRadius: BorderRadius.only(
          topLeft: (Radius.circular(5.0)),
          topRight: (Radius.circular(5.0)),
          bottomLeft: (Radius.circular(5.0)),
          bottomRight: (Radius.circular(5.0)),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 50),
            child: DropdownButton<String>(
              value: selection,
              isExpanded: true,
              items: <String>[
                'ZG 6014 GH',
                'PO 161 LJ',
                'ST 1234 A',
                'KA 513 IO'
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String _selection) {
                setState(() {
                  selection = _selection;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                onPressed: () => _selectDateTo(context),
                child: Text(
                  "${selectedDateTo.toLocal().day}.${selectedDateTo.toLocal().month}.${selectedDateTo.toLocal().year}.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                color: Colors.green,
                onPressed: () => _selectDateFrom(context),
                child: Text(
                  "${selectedDateFrom.toLocal().day}.${selectedDateFrom.toLocal().month}.${selectedDateFrom.toLocal().year}.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: SizedBox(
              child: RaisedButton(
                onPressed: () {
                  widget.model
                      .onAddItem(selection, selectedDateFrom, selectedDateTo);
                },
                color: Colors.white,
                child: Text(
                  'Dodaj kartu',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                  ),
                ),
              ),
              width: 300.0,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final _ViewModel model;

  ItemListWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: model.items
          .map((Item item) => ListTile(
              title: Text(item.body +
                  " ${item.dateFrom.toLocal().day}.${item.dateFrom.toLocal().month}.${item.dateFrom.toLocal().year}." +
                  " ${item.dateTo.toLocal().day}.${item.dateTo.toLocal().month}.${item.dateTo.toLocal().year}."),
              leading: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => model.onRemoveItem(item),
              )))
          .toList(),
    );
  }
}

class RemoveItemsButton extends StatelessWidget {
  final _ViewModel model;

  RemoveItemsButton(this.model);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text("Obriši sve"), onPressed: () => model.onRemoveItems());
  }
}

class Karta extends StatefulWidget {
  createState() {
    return KartaState();
  }
}

// GET SVG
final String assetName = 'images/maskota-parking.svg';
final Widget svgIcon =
    new SvgPicture.asset(assetName, semanticsLabel: 'Maskota', height: 350);

final String assetNameNew = 'images/oblak-prazan.svg';
final Widget chatImage = new SvgPicture.asset(
  assetNameNew,
  semanticsLabel: 'chat',
  width: 190,
);

final f = new DateFormat("d dd.MM.yyyy.");

class KartaState extends State<Karta> {
  String _message = "Imaš pravo \nna Još 0 od 0 \ndodijeljenih";

//GET MESSAGE
  Widget getMessage() {
    var message = Positioned(
      left: 125,
      top: 45,
      child: Text(
        getText(),
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: "Bobbers",
          color: Colors.white,
        ),
      ),
    );
    return message;
  }

  String getText() {
    return _message;
  }

  Widget getListView() {
    return StoreConnector<ListState, _ViewModel>(
        converter: (Store<ListState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Container(
            margin: EdgeInsets.only(left: 165, right: 8),
            child: Column(
              children: <Widget>[
                AddItemWidget(viewModel),
                Expanded(child: ItemListWidget(viewModel)),
                RemoveItemsButton(viewModel)
              ],
            )));
  }

  final store =
      Store<ListState>(reducer, initialState: ListState.initialState());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ListState>(
        store: store,
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: 50),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment(-1.0, 0.2),
                  child: Image.asset(
                    'images/maskota-parking.png',
                    height: 340.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 0, left: 75),
                  child: Image.asset(
                    'images/oblak-prazan.png',
                    width: 190,
                  ),
                ),
                getMessage(),
                Container(
                  padding: EdgeInsets.only(top: 155),
                  child: getListView(),
                ),
                Container(
                  alignment: Alignment(-0.9, 1.0),
                  margin: EdgeInsets.only(left: 0, bottom: 10),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Colors.green,
                    ),
                    mini: false,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment(0.9, 1.0),
                  child: new SizedBox(
                    child: RaisedButton(
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      color: Color.fromRGBO(50, 150, 50, 1),
                      child: Text(
                        'Registracija',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    width: 240.0,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
