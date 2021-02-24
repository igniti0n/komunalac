import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ParkingViber extends StatefulWidget {
  createState() {
    return ParkingViberState();
  }
}

// GET SVG
final String assetName = 'images/maskota-placa-odjeca.svg';
final Widget svgIcon =
    new SvgPicture.asset(assetName, semanticsLabel: 'Maskota', height: 350);

final String assetNameNew = 'images/oblak-prazan.svg';
final Widget chatImage = new SvgPicture.asset(
  assetNameNew,
  semanticsLabel: 'chat',
  width: 190,
);

final f = new DateFormat("d dd.MM.yyyy.");

class ParkingViberState extends State<ParkingViber> {
  String _message = "Plati parking \n brzo i lako!";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(-1.07, 0),
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
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.green),
                  borderRadius: BorderRadius.only(
                    topLeft: (Radius.circular(5.0)),
                    topRight: (Radius.circular(5.0)),
                    bottomLeft: (Radius.circular(5.0)),
                    bottomRight: (Radius.circular(5.0)),
                  ),
                ),
                margin: EdgeInsets.only(left: 145, top: 150, right: 5),
                child: WebView(
                  initialUrl: "https://komunalci.eu/crikvenica-api/viber.html",
                )),
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
