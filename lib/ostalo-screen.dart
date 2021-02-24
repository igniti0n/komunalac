import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dogadanja-sportski-center-novo.dart';
import 'frisko-s-palace-novo.dart';
import 'prijava-odlozenega-otpada.dart';
import 'raspored-pogreba.dart';
import 'rezervacije-kombi.dart';
import 'rezervacije-termina-sportski-center-novi.dart';
import 'uredenje-vrta-narudzba-novi.dart';

class OstaloScreen extends StatefulWidget {
  createState() {
    return OstaloScreenState();
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

String _message="Što te zanima?";

//GET MESSAGE
Widget getMessage() {
  var message = Positioned(
    left: 115,
    top: 65,
    child: Text(_message,
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
  );
  return message;
}

class OstaloScreenState extends State<OstaloScreen> {
  
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
                      minWidth: 300,
                      child: RaisedButton(
                        onPressed: () {
                
                             Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => NarudzbaVrta()),
                           );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Želim naručiti uređenje vrta",textAlign: TextAlign.center
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 300,
                      child: RaisedButton(
                        onPressed: () {
                           Navigator.push(
                            context,
                             MaterialPageRoute(
                                 builder: (context) => DogadanjaSportski()),
                           );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Događanja u sportskom centru",textAlign: TextAlign.center
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
                          Navigator.push(
                            context,
                             MaterialPageRoute(
                                builder: (context) => RezervacijaTermina()),
                           );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Rezervacija termina u sportskom centru",  textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                      minWidth: 300,
                      child: RaisedButton(
                        onPressed: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => RasporedPogreba()),
                           );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Obavijest o rasporedu pogreba", textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                   Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 300,
                      child: RaisedButton(
                        onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Frisko(
           
              selectedUrl: "https://komunalci.eu/crikvenica-api/plac.html?id="+new DateTime.now().millisecondsSinceEpoch.toString(),
            )));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Friško s place", textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                   /* Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 300,
                      child: RaisedButton(
                        onPressed: () {
                            var url='https://komunalci.eu/crikvenica-api/Home/RacunPregled';
print(url);
 Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Racun(
           
              selectedUrl: url,
            )));
          
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Racun", textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),*/
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 150,
                      child: RaisedButton(
                        onPressed: () async {
                          final result=await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderReg()),
                            );
                            if(result!=null)   Scaffold.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text("$result")));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Želim prijaviti nepropisno odložen otpad",
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
                          Navigator.push(
                            context,
                             MaterialPageRoute(
                                builder: (context) => RezervacijaKombi()),
                           );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                        child: Text(
                          "Iznajmi kombi",  textAlign: TextAlign.center,
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
               alignment: Alignment(-1.0, 0),  
             child:  Image.asset(
              'images/maskota-test.png',
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
