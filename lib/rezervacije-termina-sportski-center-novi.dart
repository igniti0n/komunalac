import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'business_objects.dart';

class RezervacijaTermina extends StatefulWidget {
  createState() {
    return RezervacijaTerminaState();
  }
}

// GET SVG
final String assetName = 'images/maskota-nogomet-odjeca.svg';
final Widget svgIcon =
    new SvgPicture.asset(assetName, semanticsLabel: 'Maskota', height: 350);

final String assetNameNew = 'images/oblak-prazan.svg';
final Widget chatImage = new SvgPicture.asset(
  assetNameNew,
  semanticsLabel: 'chat',
  width: 190,
);

//GET MESSAGE
Widget getMessage() {
  var message = Positioned(
    left: 117,
    top: 55,
    child: Text('Na koji dan?',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
  );
  return message;
}

class RezervacijaTerminaState extends State<RezervacijaTermina> {
  DateTime selectedDateTo = DateTime.now();
  DateTime selectedDateFrom = DateTime.now();

  final ctrl = new TextEditingController();

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

  String getKojiDio() {
    var resp = "";
    if (_value1)
      resp = "SVE";
    else {
      if (_value2) resp = "Unutra";
      if (_value3) resp = "Vanjski dio";
      if (_value2 && _value3) resp = "SVE";
    }
    return resp;
  }

  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);
  Widget getListView() {
    return Form(
        child: Container(
      padding: EdgeInsets.only(left: 175, right: 10, top: 0, bottom: 50),
      child: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    'Odabir dijela dvorane:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                new CheckboxListTile(
                  value: _value1,
                  onChanged: _value1Changed,
                  title: new Text(
                    'Sve',
                    style: TextStyle(fontSize: 16),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                ),
                new CheckboxListTile(
                  value: _value2,
                  onChanged: _value2Changed,
                  title: new Text(
                    'Unutra',
                    style: TextStyle(fontSize: 16),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                ),
                new CheckboxListTile(
                  value: _value3,
                  onChanged: _value3Changed,
                  title: new Text(
                    'Vanjski dio',
                    style: TextStyle(fontSize: 16),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          RaisedButton(
            color: Colors.green,
            onPressed: () {
              _selectDateFrom(context);
            },
            child: Text(
              'Željeni datum',
              style: TextStyle(color: Colors.white),
            ),
          ),
          /*RaisedButton(
                  color: Colors.green,
                  onPressed: () {},
                  child: Text(
                    'Do',
                    style: TextStyle(color: Colors.white),
                  ),
                ),*/

          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            margin: EdgeInsets.only(bottom: 10),
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.black),
            ),
            child: TextField(
              controller: ctrl,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Napomena'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: RaisedButton(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Pošalji'),
                onPressed: () {
                  var url =
                      "http://komunalci.eu/crikvenica-api/api/NarudzbaSportska";

                  Map data = {
                    "Opis": this.ctrl.text,
                    "userid": g_korisnik.sifra + "-" + g_korisnik.ime,
                    "Datum": selectedDateFrom.toIso8601String(),
                    "dio": getKojiDio()
                  };

                  var body = json.encode(data);
                  print(body);

                  http
                      .post(url,
                          headers: {"Content-Type": "application/json"},
                          body: body) //;
                      //http.post(, headers: {"Accept": "aplication/json"}, body: )
                      .then((onValue) {
                    print(onValue.body);
                    print(onValue.statusCode);
                    alertTest(context);
                  });
                  //alertTest(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Home()),
                  // );
                }),
          ),
          /* RaisedButton(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              color: Colors.green,
              textColor: Colors.white,
              child: Text(
                'Pošalji i podsjeti me dan prije',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }),*/
        ],
      ),
    ));
  }

  void alertTest(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        'Hvala na informaciji',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green,
        ),
      ),
      // content: Text('test test'),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(-1.0, 0),
              child: Image.asset(
                'images/maskota-nogomet-odjeca.png',
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
          ],
        ),
      ),
    );
  }
}
