import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'business_objects.dart';
import 'izbornik.dart';
import 'login.dart';
import 'pregled-koristenja-parkinga.dart';
import 'pregled-racuna.dart';
import 'registracija.dart';

class KoristnickiRacun extends StatefulWidget {
  createState() {
    return KoristnickiRacunState();
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

GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

class KoristnickiRacunState extends State<KoristnickiRacun> {
  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        Center(
          child: Container(
              padding:
                  EdgeInsets.only(left: 160, right: 20, top: 0, bottom: 50),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registracija()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Text("Želim izmjeniti svoje podatke",
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: () {
                          var now = new DateTime.now();

                          if (now.hour > 0 && now.hour < 5)
                            alertTest(context);
                          else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PregledRacuna()),
                            );
                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Pregled mojih računa", // pregled korištenja
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: () {
                          var now = new DateTime.now();

                          if (now.hour > 0 && now.hour < 5)
                            alertTest(context);
                          else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PregledKoristenjaParkinga()),
                            );
                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Moja kartica odvoza otpada",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: () {
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setInt('ulogiran', 0);

                            g_korisnik = null;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Izbornik()),
                            );
                          });
                          /*  Navigator.push(
                             context,
                             MaterialPageRoute(
                                builder: (context) => PregledKoristenjaParkinga()),
                          );*/
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Odjava",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
    return listView;
  }

  void alertTest(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        'Probajte kasnije',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green,
        ),
      ),
      content: Text(
          'Poštovani korisniče,\nZbog ažuriranja podataka i sistema pregled računa nije vidljiv od 01:00 do 05:00 sati svaki dan.\nHvala na razmijevanju.'),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    if (g_korisnik == null) {
      return Login();
      // registriran
    } else
      return Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment(-1.0, 0.2),
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
              Container(
                child: Positioned(
                  left: 135,
                  top: 55,
                  child: Text('Što želiš \nprovjeriti?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 155),
                child: getListView(),
              ),
              // Container(
              //   alignment: Alignment(-0.9, 1.0),
              //   margin: EdgeInsets.only(left: 0, bottom: 10),
              //   child: FloatingActionButton(
              //      backgroundColor: Colors.white,
              //     child: Icon(
              //       Icons.arrow_back,
              //       size: 40,
              //       color: Colors.green,
              //     ),
              //     mini: false,
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      );
  }
}
