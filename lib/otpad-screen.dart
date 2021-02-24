import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'business_objects.dart';
import 'login.dart';
import 'narudzba-odvoza-otpada.dart';
import 'postavljena-pitanja.dart';
import 'pregled-kalendar.dart';
import 'uredenje-vrta-screen.dart';
import 'vrste-otpada.dart';

class OdpadScreen extends StatefulWidget {
  createState() {
    return OdpadScreenState();
  }
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

final f = new DateFormat("d dd.MM.yyyy.");

class OdpadScreenState extends State<OdpadScreen> {
  String _message = "\nKoju\ninformaciju\ntrebaš?";

  List<Color> _colors = [Colors.white, Colors.yellow];
  List<FontWeight> _weights = [FontWeight.bold, FontWeight.w900];

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

//GET MESSAGE
  Widget getMessage() {
    var message = Positioned(
      left: 135,
      top: 25,
      child: Text(
        getText(),
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Bobbers",
            color: _colors[_currentIndex],
            fontWeight: _weights[_currentIndex]),
      ),
    );
    return message;
  }

  String getText() {
    return _message;
  }

  String kojiDanTjedna(String datum) {
    DateFormat format = new DateFormat("dd.MM.yyyy");
    var date = format.parse(datum);
    var danUTjednu = date.weekday;
    if (danUTjednu == 1) return "Ponedjeljak";

    if (danUTjednu == 2) return "Utorak";
    if (danUTjednu == 3) return "Srijeda";
    if (danUTjednu == 4) return "Četvrtak";
    if (danUTjednu == 5) return "Petak";
    if (danUTjednu == 6) return "Subota";
    if (danUTjednu == 7) return "Nedjelja";
  }

  Widget getListView(BuildContext context) {
    var sad = DateTime.now();
    if (g_korisnik != null && g_korisnik.sifra != null && zadnjiLogin == null)
      zadnjiLogin = new DateTime.now().add(new Duration(days: -7));

    if (g_korisnik != null && g_korisnik.sifra != null) {
      final difference = sad.difference(zadnjiLogin).inDays;
      if (difference > 1) {
        http.post(
            "http://komunalci.eu/crikvenica-api/api/DrugaPrijavaKorisnika",
            headers: {
              "Accept": "aplication/json"
            },
            body: {
              "KorIme": g_korisnik.sifra,
              "Lozinka": g_korisnik.sifra
            }).then((onValue) async {
          g_korisnik = Korisnik.fromJson(json.decode(onValue.body));

          final prefs = await SharedPreferences.getInstance();

          prefs.setInt('ulogiran', 1);
          prefs.setString('ime', g_korisnik.ime);
          prefs.setString('prezime', g_korisnik.prezime);
          prefs.setString('oIB', g_korisnik.oIB);
          prefs.setString('sifra', g_korisnik.sifra);
          prefs.setString('mobitel', g_korisnik.mobitel);
          prefs.setString('email', g_korisnik.email);
          prefs.setString('adresaUlica', g_korisnik.adresaUlica);
          prefs.setString('adresaKBR', g_korisnik.adresaKBR);
          prefs.setInt('adresaId', g_korisnik.adresaId);
          prefs.setString('adresaJLS', g_korisnik.adresaJLS);
          prefs.setString('litraE', g_korisnik.litraE);
          prefs.setString('barkodi', g_korisnik.barkodi);

          zadnjiLogin = DateTime.now();
        });
      }
    }

    var listView = ListView(
      children: <Widget>[
        Center(
          child: Container(
              padding: EdgeInsets.only(left: 180, right: 10, top: 0, bottom: 0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 150,
                      child: RaisedButton(
                        onPressed: () {
                          var msg = "";
                          if (g_korisnik != null) {
                            var dan = kojiDanTjedna(g_korisnik.litraE);

                            //litrae MKO
                            //oib plastika
                            //barkodi=rec
                            msg = "Sljedeći put\ndolazimo:\n" +
                                dan +
                                "\n" +
                                g_korisnik.litraE +
                                ".";
                          }

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PregledKalendar(tipKal: "MKO", kada: msg)));

                          /* if (g_korisnik != null) {
                            /*http.get("http://komunalci.eu/crikvenica-api/api/OtpadDatumiReg?AdresaID=" + g_korisnik.adresaId.toString(), headers: {"Accept": "aplication/json"})
                                .then((onValue) {
                              g_otpad = Otpad.fromJson(json.decode(onValue.body));*/
                              _onChanged();
                              Timer(Duration(seconds: 1), () {
                                _onChanged();
                              });
                              setState(() {
                               
                                 //litrae MKO
                                 //oib plastika
                                 //barkodi=rec   
                                var dan = kojiDanTjedna(g_korisnik.litraE);
                             
                                 //litrae MKO
                                 //oib plastika
                                 //barkodi=rec   
                                _message = "Sljedeći put\ndolazimo:\n"+dan+"\n"+g_korisnik.litraE;
                              });
                        //    });
                          }
                          else{
                            g_tipNeReg='MKO';
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MobrecNeReg()),
                            );
                          }*/
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kad mi slijedeći put odvozite miješani komunalni otpad (zelena kanta) ?",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 150,
                      child: RaisedButton(
                        onPressed: () {
                          var msg = "";
                          if (g_korisnik != null) {
                            var dan = kojiDanTjedna(g_korisnik.oIB);

                            //litrae MKO
                            //oib plastika
                            //barkodi=rec
                            msg = "Sljedeći put\ndolazimo:\n" +
                                dan +
                                "\n" +
                                g_korisnik.oIB +
                                ".";
                          }

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PregledKalendar(
                                      tipKal: "PLASTIKA", kada: msg)));

                          /* if (g_korisnik != null) {
                            /*http.get("http://komunalci.eu/crikvenica-api/api/OtpadDatumiReg?AdresaID=" + g_korisnik.adresaId.toString(), headers: {"Accept": "aplication/json"})
                                .then((onValue) {
                              g_otpad = Otpad.fromJson(json.decode(onValue.body));*/
                              _onChanged();
                              Timer(Duration(seconds: 1), () {
                                _onChanged();
                              });
                              setState(() {
                               
                              var dan = kojiDanTjedna(g_korisnik.oIB);
                             
                                 //litrae MKO
                                 //oib plastika
                                 //barkodi=rec   
                                _message = "Sljedeći put\ndolazimo:\n"+dan+"\n"+g_korisnik.oIB;
                              });
                        //    });
                          }
                          else{
                            g_tipNeReg='PLASTIKA';
                            final result=Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MobrecNeReg()),
                            );
                            if(result!=null)   Scaffold.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text("$result")));
                          }*/
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kad mi slijedeći put odvozite papir, plastiku, metal i staklo (šarene vrećice) ?",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 50,
                      child: RaisedButton(
                        onPressed: () {
                          var msg = "";
                          if (g_korisnik != null) {
                            var dan = kojiDanTjedna(g_korisnik.barkodi);

                            //litrae MKO
                            //oib plastika
                            //barkodi=rec
                            msg = "Sljedeći put\ndolazimo:\n" +
                                dan +
                                "\n" +
                                g_korisnik.barkodi +
                                ".";
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PregledKalendar(tipKal: "REC", kada: msg)));
                          /* if (g_korisnik != null) {
                            /*http.get("http://komunalci.eu/crikvenica-api/api/OtpadDatumiReg?AdresaID=" + g_korisnik.adresaId.toString(), headers: {"Accept": "aplication/json"})
                                .then((onValue) {
                              g_otpad = Otpad.fromJson(json.decode(onValue.body));*/
                              _onChanged();
                              Timer(Duration(seconds: 1), () {
                                _onChanged();
                              });
                              setState(() {
                               
                               var dan = kojiDanTjedna(g_korisnik.barkodi);
                             
                                 //litrae MKO
                                 //oib plastika
                                 //barkodi=rec   
                                _message = "Sljedeći put\ndolazimo:\n"+dan+"\n"+g_korisnik.barkodi;
                              });
                        //    });
                          }
                          else{
                             g_tipNeReg="REC";
                            Navigator.push(
                              context,
                             
                              MaterialPageRoute(builder: (context) => MobrecNeReg()),
                            );
                          }*/
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kad je slijedeći put u mojoj blizini mobilno rec. dvorište?",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 300,
                      child: new RaisedButton(
                        onPressed: () {
                          // nereg
                          if (g_korisnik == null) {
                            g_OpenAfterLogin = "NARUCI_ODVOZ";
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                            //reg
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Narudzba()),
                            );
                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Želim naručiti odvoz glomaznog otpada",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 300,
                      child: new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Pitanja()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Često postavljena pitanja",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 150,
                      child: new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Vrt()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Što ću sa zelenim otpadom nakon uređenja vrta?",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 300,
                      child: new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VrstaOtpada()),
                          );
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        textColor: Colors.green,
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Koje vrste otpada prihvaćate?",
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
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Builder(
            // Create an inner BuildContext so that the onPressed methods
            // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(-1.3, 0),
              child: Image.asset(
                'images/maskota-smetlar.png',
                height: 340.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, left: 75),
              child: Image.asset(
                'images/oblak-prazan.png',
                width: 190,
              ),
              // cloudDarkImage(),
            ),
            getMessage(),
            Container(
              padding: EdgeInsets.only(top: 155),
              child: getListView(context),
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
      );
    }));
  }
}
