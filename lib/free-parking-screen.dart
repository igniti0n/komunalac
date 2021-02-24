import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'business_objects.dart';

class MapUtils {

  static openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
 /* final LatLng _center = const LatLng(45.176366, 14.694013);
  final LatLng _up = const LatLng(45.176139, 14.691417);
  final LatLng _down = const LatLng(45.173908, 14.691245);
*/

class Parking extends StatefulWidget {
  createState() {
    return ParkingState();
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

class ParkingState extends State<Parking> {
  String _message = "Ima/Nema";

List<Widget> _list=new List<Widget>();


  @override
  void initState() {
    http.get("http://komunalci.eu/crikvenica-api/api/ParkingPopis", headers: {"Accept": "aplication/json"}).then((onValue){
    for ( var i in json.decode(onValue.body) ) {
      ParkingBO po =ParkingBO.fromJson(i);
      _list.add(Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 150,
                      child: new RaisedButton(
                        onPressed: () {
                          MapUtils.openMap(po.latitude,po.longitude);
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 40,
                            ),
                            // todo
                            Text(
                              po.naziv+" "+po.mjestaFree.toString()+"/"+po.mjestaTotal.toString()+" mjesta",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));

    }
    setState(() {
            _list=_list;
          });
    });
  }

  
  Widget getMessage() {
    var message = Positioned(
      left: 125,
      top: 62,
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
    var listView = ListView(
      children: <Widget>[
        Center(
          child: Container(
              padding: EdgeInsets.only(left: 100, right: 5, top: 0, bottom: 0),
              child: Column(
                children: _list
              )),
        ),
      ],
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
