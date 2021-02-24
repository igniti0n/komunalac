import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DogadanjaSportski extends StatefulWidget {
  createState() {
    return DogadanjaSportskiState();
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

final f = new DateFormat("d dd.MM.yyyy.");

class DogadanjaSportskiState extends State<DogadanjaSportski> {
  String _message = "Događanja su:";

  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://komunalci.eu/crikvenica-api/Home/DogadjajiListApp"),
        headers: {"Accept": "application/json"});

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
        ),
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
            margin: EdgeInsets.only(left: 160, right: 5),
            child: Column(children: <Widget>[
              ListTile(
                title: Text(
                  data[index]["EventName"],
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Od: ' + data[index]["StartDate"]["DateTime"],
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 60),
                child: new Divider(
                  height: 15.0,
                  color: Colors.green,
                ),
              )
            ]));

        //);
      },
    );

    /*ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 160, right: 5),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Dogadaj 1',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Od: 21.03.2019 12:00\nDo 22.03.2019 12:00',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 60),
                child: new Divider(
                  height: 15.0,
                  color: Colors.green,
                ),
              ),
              ListTile(
                title: Text(
                  'Dogadaj 1',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Od: 21.03.2019 12:00\nDo 22.03.2019 12:00',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 60),
                child: new Divider(
                  height: 15.0,
                  color: Colors.green,
                ),
              ),
              ListTile(
                title: Text(
                  'Dogadaj 1',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Od: 21.03.2019 12:00\nDo 22.03.2019 12:00',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 60),
                child: new Divider(
                  height: 15.0,
                  color: Colors.green,
                ),
              ),
             ListTile(
                title: Text(
                  'Dogadaj 1',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Od: 21.03.2019 12:00\nDo 22.03.2019 12:00',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 60),
                child: new Divider(
                  height: 15.0,
                  color: Colors.green,
                ),
              ),
              ListTile(
                title: Text(
                  'Dogadaj 1',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Od: 21.03.2019 12:00\nDo 22.03.2019 12:00',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
    
        ),
         Container(
                margin: EdgeInsets.only(left: 200, right: 60),
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
