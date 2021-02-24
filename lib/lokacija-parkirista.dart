import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'business_objects.dart';

class Lokacija extends StatefulWidget {
  createState() {
    return LokacijaState();
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

class LokacijaState extends State<Lokacija> {
  String _message = "Otvorena i \nzatvorena \nparkilarišta..";

//GET MESSAGE
  Widget getMessage() {
    var message = Positioned(
      left: 130,
      top: 42,
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

  /*GoogleMapController mapController;
  Set<Marker> markers = new Set<Marker>();
  final LatLng _center = const LatLng(45.176366, 14.694013);
  final LatLng _up = const LatLng(45.176139, 14.691417);
  final LatLng _down = const LatLng(45.173908, 14.691245);

  _getThingsOnStartup() async {
    http.get("http://komunalci.eu/crikvenica-api/api/ParkingPopis",
        headers: {"Accept": "aplication/json"}).then((onValue) {
      for (var i in json.decode(onValue.body)) {
        ParkingBO po = ParkingBO.fromJson(i);
        markers.add(new Marker(
            infoWindow: InfoWindow(
                title: po.naziv +
                    " " +
                    po.mjestaFree.toString() +
                    "/" +
                    po.mjestaTotal.toString(),
                snippet: '*'),
            position: new LatLng(po.latitude, po.longitude),
            markerId: MarkerId(markers.length.toString()),
            visible: true));
      }

      setState(() {
        markers = markers;
      });
    });
  }
*/
  @override
  void initState() {
    /*  _getThingsOnStartup().then((value) {
      print('Async done');
    });*/
    super.initState();
  }

/*
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
*/
  Widget getListView() {
    var listView = Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.green),
        borderRadius: BorderRadius.only(
          topLeft: (Radius.circular(10.0)),
          topRight: (Radius.circular(10.0)),
          bottomLeft: (Radius.circular(10.0)),
          bottomRight: (Radius.circular(10.0)),
        ),
      ),
      /*   child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0,
        ),
        markers: markers,
      ),*/
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
              padding: EdgeInsets.only(top: 155, left: 160),
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
