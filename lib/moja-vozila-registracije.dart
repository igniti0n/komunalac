import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Item
{
  final int id;
  final String body;

  Item({@required this.id, @required this.body});

  Item copyWith({int id, String body}){

    return Item(id: id ?? this.id, body: body ?? this.body);
  }
}


class ListState {
  final List<Item> items;
  ListState({@required this.items});

  ListState.initialState() : items = List.unmodifiable(<Item>[]);
}

class AddItemAction {
  static int _id=0;
  final String item;

  AddItemAction(this.item){
    _id++;
  }

  int get id => _id;
}

class RemoveItemAction{
  final Item item;

  RemoveItemAction(this.item);

}

class RemoveItemsAction{

}



ListState reducer(ListState state, action) {
  
    return ListState(
        items:itemReducer(state.items, action));
}

List<Item> itemReducer(List<Item> state, action) {

  if (action is AddItemAction)
  {
    return []..addAll(state)..add(Item(id: action.id,body: action.item ));
  }

  if( action is RemoveItemAction)
  {
    return List.unmodifiable(List.from(state)..remove(action.item));

  }

  if (action is RemoveItemsAction)
  {

    return List.unmodifiable([]);
  }


  return state;

}


class _ViewModel {
  final List<Item> items;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;


  _ViewModel({
    this.items,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveItems
  });

  factory _ViewModel.create(Store<ListState> store){
    _onAddItem(String body){
      store.dispatch(AddItemAction(body));
    }

    _onRemoveItem(Item item) {
        store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
        store.dispatch(RemoveItemsAction());
    }


    return _ViewModel(
      items:store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems
    ) ;
    


  }
}

class AddItemWidget extends StatefulWidget {
  final _ViewModel model;

  AddItemWidget(this.model);


  @override
  _AddItemState createState() => _AddItemState();

}

class _AddItemState extends State<AddItemWidget>{

  final TextEditingController controller=TextEditingController(); 

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: "Unesite registraciju..."),
      onSubmitted: (String s){
        widget.model.onAddItem(s);
        controller.text="";        
      },
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final _ViewModel model;

  ItemListWidget(this.model);


  @override
  Widget build(BuildContext context) {

    return ListView(
      children: model.items.map((Item item) => ListTile(
        title: Text(item.body),
        leading: IconButton (
          icon: Icon(Icons.delete),
          onPressed: () => model.onRemoveItem(item),
        )
      ))
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
              child: Text("Obriši sve", style: TextStyle(color: Colors.white),),
              onPressed: () => model.onRemoveItems(),
              color: Colors.green,
     );
  }
}


class VozilaRegistracije extends StatefulWidget {
  
  createState() {
    return VozilaRegistracijeState();
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

class VozilaRegistracijeState extends State<VozilaRegistracije> {
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
    var listView = StoreConnector<ListState, _ViewModel> (
                converter: (Store<ListState> store) => _ViewModel.create(store),
                builder: (BuildContext context , _ViewModel viewModel) => Column (
                  children: <Widget>[
                    AddItemWidget(viewModel),
                    Expanded(child: ItemListWidget(viewModel)),
                    RemoveItemsButton(viewModel)
                  ]
                ,)
          );
    return listView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
               alignment: Alignment(-1.0, 0.2),    
              //  child: svgIcon,
            child:  Image.asset(
              'images/maskota-parking.png',
              height: 340.0,     
            ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, left: 75),
               child:  Image.asset(
              'images/oblak-prazan.png',
              width: 190,    
            ),
            ),
            getMessage(),
            Container(
              padding: EdgeInsets.only(top: 155, left: 150),
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
          ],
        ),
      ),
    );
  }
}
