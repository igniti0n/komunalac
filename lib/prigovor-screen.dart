import 'package:EkoMurvica/business_objects.dart';
import 'package:EkoMurvica/login.dart';
import 'package:EkoMurvica/prijava-problema-ostalo.dart';
import 'package:EkoMurvica/prijava-problema-parking.dart';
import 'package:EkoMurvica/prijava-problema-racun.dart';
//import 'package:EkoMurvica/registracija.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PrigovorScreen extends StatefulWidget {
  createState() {
    return PrigovorScreenState();
  }
}

// GET SVG
final String assetName = 'images/maskota-ljut.svg';
final Widget svgIcon =
    new SvgPicture.asset(assetName, semanticsLabel: 'Maskota', height: 350);

final String assetNameNew = 'images/oblak-prazan.svg';
final Widget chatImage = new SvgPicture.asset(
  assetNameNew,
  semanticsLabel: 'chat',
  width: 190,
);

//GET MESSAGE
Widget getMessage() {
  var message = Positioned(
    left: 130,
    top: 55,
    child: Text('Na što imaš \nprigovor?',
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
  );
  return message;
}

class PrigovorScreenState extends State<PrigovorScreen> {
  
  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        Center(
          child: Container(
              padding:
                  EdgeInsets.only(left: 125, right: 5, top: 0, bottom: 50),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 200,
                      child: RaisedButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => PrigovorScreen()),
                          // );
                          if (g_korisnik == null) {
                             Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => Login()),
                           );
                          }
                          else
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrijavaProblemaRacun()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Račun za odvoz smeća",textAlign: TextAlign.center
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => PrigovorScreen()),
                          // );
                           if (g_korisnik == null) {
                             Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => Login()),
                           );
                          }
                          else
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrijavaProblemaOstalo()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Ostale usluge",textAlign: TextAlign.center
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => PrigovorScreen()),
                          // );
                            if (g_korisnik == null) {
                             Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => Login()),
                           );
                          }
                          else
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrijavaProblemaParking()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Dnevna parkirna karta",  textAlign: TextAlign.center,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(-1.2, 0.2),    
               child:  Image.asset(
              'images/maskota-ljut.png',
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
