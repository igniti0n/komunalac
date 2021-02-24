import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'business_objects.dart';

class RasporedPogreba extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RasporedPogreba();
  }
}

class _RasporedPogreba extends State<RasporedPogreba> {
  void _showDialog(String imagePath, String naziv, String datum) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            naziv + "\n" + datum,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16,),
          ),
          content: Image(image: NetworkImage(imagePath)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _list = new List<Widget>();

  @override
  void initState() {
    http.get('http://komunalci.eu/crikvenica-api/api/UkopiPopis',
        headers: {"Accept": "aplication/json"}).then((onValue) {
      final jsonData = json.decode(onValue.body);
      for (var i in jsonData) {
        Pogreb po = Pogreb.fromJson(i);

        _list.add(GestureDetector(
            onTap: () {
              _showDialog(po.imgUrl, po.naziv, po.datum);
            },
            child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Image(image: NetworkImage(po.imgUrl)))));
      }

      setState(() {
        _list = _list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: (Radius.circular(5.0)),
                  topRight: (Radius.circular(5.0)),
                  bottomLeft: (Radius.circular(5.0)),
                  bottomRight: (Radius.circular(5.0)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Raspored pogreba',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              margin: EdgeInsets.only(top: 60),
              child: ListView(
                children: <Widget>[
                  Column(children: _list),
                ],
              ),
            ),
            Container(
              alignment: Alignment(-0.9, 1.0),
              margin: EdgeInsets.only(left: 0, bottom: 0),
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
