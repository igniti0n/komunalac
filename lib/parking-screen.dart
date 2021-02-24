import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingScreen extends StatefulWidget {
  createState() {
    return ParkingScreenState();
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

Widget getMessage() {
  var message = Positioned(
    left: 115,
    top: 55,
    child: Text(
      "    Plati parking\nViber aplikacijom",
      style: TextStyle(
          fontSize: 18.0,
          fontFamily: "Bobbers",
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),
  );
  return message;
}
//GET MESSAGE
/*Widget getMessage() {
  var message = Positioned(
    left: 115,
    top: 65,
    child: TyperAnimatedTextKit(
      duration: Duration(milliseconds: 4000),
      isRepeatingAnimation: false,
      onTap: () {
        print("Tap Event");
      },
      text: [
        " ",
        " ",
        " ",
        "Što te zanima ?",
      ],
      textStyle: TextStyle(
        fontSize: 18.0,
        fontFamily: "Bobbers",
        color: Colors.white,
      ),
      // textAlign: TextAlign.start,
      // alignment: AlignmentDirectional.topStart // or Alignment.topLeft
    ),

    // Text('Što te zanima?',
    //     style: TextStyle(
    //         color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
  );
  return message;
}*/

_launchURL() async {
  const url =
      'viber://pa?chatURI=ekomurvica'; //foxsy&text=PARKING:RI123AA';// 'https://msng.link/vi/385993225988';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void alertTest(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text(
      'Instalirajte Viber da biste mogli koristiti ovu funkciju!',
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

class ParkingScreenState extends State<ParkingScreen> {
  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        Center(
          child: Container(
              padding:
                  EdgeInsets.only(left: 160, right: 20, top: 0, bottom: 50),
              child: Column(
                children: <Widget>[
                  /* Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Parking()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Text("Ima li slobodnih mjesta ?",
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),*/
                  /*  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Lokacija()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Text("Gdje mogu parkirati ?",
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),*/
                  /* Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Karta()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Želim kupiti parkirnu kartu",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),*/

                  GestureDetector(
                    onTap: () async {
                      const url = 'viber://pa?chatURI=ekomurvica';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        alertTest(context);
                      }
                    }, // handle your image tap here
                    child: Image.asset(
                      'images/viber.png',
                      fit: BoxFit.cover, // this is the solution for border
                      width: 110.0,
                      height: 110.0,
                    ),
                  )
                  /* Container(
                     
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: _launchURL/* () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => ParkingViber()),
                           );
                        }*/,
                        /*shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Plati mobitelom",
                          textAlign: TextAlign.center,
                        ),*/
                        child: const AssetImage("assets/background_button.png"),
                      ),
                    ),
                  )/*,
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VozilaRegistracije()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Moja vozila u sustavu parkinga.",
                          textAlign: TextAlign.center,
                        ),*/
                      ),
                    ),
                  ),*/
                ],
              )),
        ),
      ],
    );
    return listView;
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
