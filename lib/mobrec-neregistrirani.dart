import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'

    show CalendarCarousel;

import 'business_objects.dart';
import 'login.dart';

// import 'package:flutter/scheduler.dart' show timeDilation;

class MobrecNeReg extends StatefulWidget {
  createState() {
    return MobrecNeRegState();
  }
}



Widget widget() {
  return Container(
    margin: EdgeInsets.only(top: 40, right: 0, left: 0),
    child: CalendarCarousel(),
  );
}

// GET SVG
final String assetName = 'images/maskota-smetlar.svg';
final Widget svgIcon =
    new SvgPicture.asset(assetName, semanticsLabel: 'Maskota', height: 350);

final String assetNameNew = 'images/oblak-prazan.svg';
final Widget chatImage = new SvgPicture.asset(
  assetNameNew,
  semanticsLabel: 'chat',
  width: 190,
);


class MobrecNeRegState extends State<MobrecNeReg> {
  String _message = "Odaberi ulicu \nili se prijavi za \nautomatski ispis";

  List<Color> _colors = [
    Colors.white,
    Colors.yellow
  ];
  List<FontWeight> _weights = [
    FontWeight.normal,
    FontWeight.bold
  ];

  int _currentIndex = 0;

  _onChanged() {
    //update with a new color when the user taps button
    int _colorCount = _colors.length;

    setState(() {
      if (_currentIndex == _colorCount - 1) {
        _currentIndex = 0;
      } else {
        _currentIndex += 1;
      }
    });
  }



  String getText() {
    return _message;
  }
//GET MESSAGE
Widget getMessage() {
  var message = Positioned(
    left: 105,
    top: 55,
    child: Text(
        getText(),
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: "Bobbers",
          color: _colors[_currentIndex],
          fontWeight: _weights[_currentIndex]
        ))
  );
  return message;
}


  List<DropdownMenuItem> items = new List<DropdownMenuItem>();
  var _value;

  @override
  void initState() {
    http.get("http://komunalci.eu/crikvenica-api/api/AdresePopis",
        headers: {"Accept": "aplication/json"}).then((onValue) {
      for (var i in json.decode(onValue.body)) {
        Ulica ul = Ulica.fromJson(i);
        items.add(DropdownMenuItem(
            value: ul.adresaID,
            child: Text(ul.adresaJLS+"-"+ul.adresaUlica)));
      }
      setState(() {
        items = items;
      });
    });
  }

  Widget getListView() {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50),
          child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0)),
            padding: EdgeInsets.all(20),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            color: Colors.white,
            child: Text(
              'Prijavi se',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
          ),
        
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          width: 200,
          child:  DropdownButton(
          items: items,
          onChanged: (value) {
            setState(() {

              _value = value;
              
            });
            print(value);
            http.post("http://komunalci.eu/crikvenica-api/api/AdresePopis",
                      headers: {"Accept": "aplication/json"},body: {"AddressId": "$value"} ).
                      then((onValue){

                     print('miki');
                        var _resp=AdresaResp.fromJson(json.decode(onValue.body));
                        var _text="";
                        if (g_tipNeReg=='REC')
                          _text=_resp.recDate;
                        else if (g_tipNeReg=='MKO')
                          _text=_resp.mkoDate;
                        else 
                        _text=_resp.plastikaDate;
                         _onChanged();
                              Timer(Duration(seconds: 1), () {
                                _onChanged();
                              });
                              setState(() {
                             
                                _message = "     Sljedeći\n       dolazak:\n       "+_text;
                              }); 
                      });
                      print('adasdd');
          },
          value: _value,
          hint: Text('Ulica'),
          
        ))
        ,
       // widget(),
        // kalendar
        
      ],
    );
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
              alignment: Alignment(-1.3, 0),
              child:  Image.asset(
              'images/maskota-smetlar.png',
              height: 340.0,     
            ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, left: 75),
               child:  Image.asset(
              'images/oblak-prazan.png',
              width: 190,    
            ),
              // cloudDarkImage(),
            ),
            getMessage(),
            Container(
              padding: EdgeInsets.only(left: 150, top: 155),
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
