import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'business_objects.dart';

class PregledKoristenjaParkinga extends StatefulWidget {
  createState() {
    return PregledKoristenjaParkingaState();
  }
}

// GET SVG
final String assetName = 'images/maskota.svg';
final Widget svgIcon =
    new SvgPicture.asset(assetName, semanticsLabel: 'Maskota', height: 350);

final String assetNameNew = 'images/oblak-prazan.svg';
final Widget chatImage = new SvgPicture.asset(
  assetNameNew,
  semanticsLabel: 'chat',
  width: 190,
);

final f = new DateFormat("d dd.MM.yyyy.");

class PregledKoristenjaParkingaState extends State<PregledKoristenjaParkinga> {
  String _message = "     Pokupili smo\n         ti otpad:";

  List data;

  Future<String> getData() async {
    var response = await http.post(
        Uri.encodeFull("http://komunalci.eu/crikvenica-api/api/UslugeList"),
        headers: {"Accept": "aplication/json"},
        body: {"KorIme": g_korisnik.sifra, "Lozinka": g_korisnik.sifra});

    this.setState(() {
      data = jsonDecode(response.body);
    });
    print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

//GET MESSAGE
  Widget getMessage() {
    var message = Positioned(
      left: 108,
      top: 55,
      child: Text(
        getText(),
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Bobbers",
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
    return message;
  }

  String getText() {
    return _message;
  }

  Widget getListView() {
    var listView = new ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
            margin: EdgeInsets.only(left: 90),
            child: Column(children: <Widget>[
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik ' + data[index]["Volume"],
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'Vrijeme usluge: \n' + data[index]["Executed"],
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              )
            ]));
      },
    );
    /*ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 90,
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 110, right: 5),
          child: new Divider(
            height: 15.0,
            color: Colors.green,
          ),
        ),
      ],
    );*/
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
              alignment: Alignment(-1.2, 0.2),
              child: Image.asset(
                'images/maskota-test.png',
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
