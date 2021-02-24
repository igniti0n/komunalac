import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'ostalo-screen.dart';
import 'otpad-screen.dart';
import 'parking-screen.dart';
import 'prigovor-screen.dart';

// import 'package:flutter/scheduler.dart' show timeDilation;

class Izbornik extends StatefulWidget {
  createState() {
    return IzbornikState();
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

Widget getMessage() {
  var message = Positioned(
    left: 117,
    top: 55,
    child: Text('Oko čega ti \nmogu pomoći?',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
  );
  return message;
}

class IzbornikState extends State<Izbornik> {
  Widget getListView() {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 7, right: 5),
          child: ButtonTheme(
            minWidth: 50,
            child: new RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OdpadScreen()),
                );
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              textColor: Colors.green,
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 10.0, right: 8.0, bottom: 10.0, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Otpad",
                    style: TextStyle(fontSize: 22),
                  ),
                  Icon(Icons.restore_from_trash),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 7, right: 5),
          child: ButtonTheme(
            minWidth: 150,
            child: new RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ParkingScreen()),
                  );
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                textColor: Colors.green,
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 10.0, right: 8.0, bottom: 10.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "Parking",
                      style: TextStyle(fontSize: 22),
                    ),
                    Icon(Icons.local_parking)
                  ],
                )),
          ),
        ),
        /* Container(
          margin: EdgeInsets.only(bottom: 7, right: 5),
          child: ButtonTheme(
            minWidth: 150,
            child: new RaisedButton(
                 onPressed: () {
                          // nije registriran
                          if (g_korisnik == null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                            // registriran
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KoristnickiRacun()),
                            );
                          }
                        },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                textColor: Colors.green,
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 10.0, right: 8.0, bottom: 10.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "Moj kor.račun",
                      style: TextStyle(fontSize: 22),
                    ),
                    Icon(Icons.account_box)
                  ],
                )),
          ),
        ),*/
        Container(
          margin: EdgeInsets.only(bottom: 7, right: 5),
          child: ButtonTheme(
            minWidth: 150,
            child: new RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => PrigovorScreen()) staro,
                    MaterialPageRoute(builder: (context) => PrigovorScreen()),
                  );
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                textColor: Colors.green,
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 10.0, right: 8.0, bottom: 10.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "Imam prigovor",
                      style: TextStyle(fontSize: 22),
                    ),
                    Icon(Icons.report)
                  ],
                )),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 5),
          child: ButtonTheme(
            minWidth: 150,
            child: new RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OstaloScreen()),
                  );
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                textColor: Colors.green,
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 10.0, right: 8.0, bottom: 10.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "Ostalo",
                      style: TextStyle(fontSize: 22),
                    ),
                    Icon(Icons.star)
                  ],
                )),
          ),
        ),
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
              alignment: Alignment(-1.0, 0.2),
              //  child: svgIcon,
              child: Image.asset(
                'images/maskota-test.png',
                height: 340.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, left: 75),
              // child: chatImage,
              child: Image.asset(
                'images/oblak-prazan.png',
                width: 190,
              ),
            ),
            getMessage(),
            Container(
              padding: EdgeInsets.only(left: 150, top: 155),
              child: getListView(),
            ),
          ],
        ),
      ),
    );
  }
}
