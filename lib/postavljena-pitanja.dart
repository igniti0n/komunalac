import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Pitanja extends StatefulWidget {
  createState() {
    return PitanjaState();
  }
}

// GET SVG
final String assetName = 'images/maskota-razmislja-2.svg';
final Widget svgIcon =
    new SvgPicture.asset(assetName, semanticsLabel: 'Maskota', height: 350);

final String assetNameNew = 'images/oblak-prazan.svg';
final Widget chatImage = new SvgPicture.asset(
  assetNameNew,
  semanticsLabel: 'chat',
  width: 190,
);

final f = new DateFormat("d dd.MM.yyyy.");

class PitanjaState extends State<Pitanja> {
  String _message = "Što te zanima?";

//GET MESSAGE
  Widget getMessage() {
    var message = Positioned(
      left: 110,
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

/*Widget CardList() {
  return Container(
    childre: Card(
      child: ExpansionTile(
        title: Text(
          "Periodo",
          style: new TextStyle(),
          textAlign: TextAlign.center,
        ),
        children: <Widget>[
          ListTile(
            title: Text(
              "Periodo 1",
              textAlign: TextAlign.center,
            ),
          ),
          
        ],
      ),
    ),
  );
}*/

  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        Center(
          child: Container(
              padding: EdgeInsets.only(left: 160, right: 10, top: 0, bottom: 0),
              child: Column(
                children: <Widget>[
                  ExpansionTile(
                    title: Text(
                      'Koje je radno vrijeme za prijem stranaka u upravi?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      new Container(height: 1.5, color: Colors.black87),
                      ListTile(
                        title: Text(
                          "Svakim radnim danom od ponedjeljka do petka od 7:00 do 15:00 sati",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Služba za korisnike',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      new Container(height: 1.5, color: Colors.black87),
                      ListTile(
                        title: Text(
                          "Na besplatan broj telefona 0800 2999 možete dobiti sve informacije vezane uz djelatnosti Eko-Murvice d.o.o.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Koje je radno vrijeme blagajne?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      new Container(height: 1.5, color: Colors.black87),
                      ListTile(
                        title: Text(
                          "Zimsko radno vrijeme (od 16. rujna do 15. lipnja):\n\t\t-ponedjeljak, srijeda, četvrtak i petak od 7:30 do 14:00 sati (stanka od 10:00 do 10:30)\n\t\t-utorak od 11:30 do 18:00 sati (stanka od 15:00 do 15:30)\n\nLjetno radno vrijeme (od 16. lipnja do 15.rujna):\n- od ponedjeljka do petka od 07:30 do 13:00 sati\n- subota od 8:00 do 12:00 sati",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Kako mogu dostaviti reklamaciju?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      new Container(height: 1.5, color: Colors.black87),
                      ListTile(
                        title: Text(
                          "Reklamacije možete poslati na naš e-mail: info@ekomurvica.hr ili na adresu Trg Stjepana Radića 1/II, 51260 Crikvenica.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Kako platiti parking SMS-om?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      new Container(height: 1.5, color: Colors.black87),
                      ListTile(
                        title: Text(
                          "Plaćate parkiranje tako da pošaljete SMS poruku sa sadržajem  registracijske oznake vozila bez razmaka, interpunkcija i hrvatskih znakova, na broj 708551 za 0. zonu, na broj 708552 za 1. zonu, na broj 708553 za 2. zonu.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Kako mogu naručiti besplatan odvoz krupnog (glomaznog) komunalnog otpada?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      new Container(height: 1.5, color: Colors.black87),
                      ListTile(
                        title: Text(
                          "Ako ste korisnik javne usluge odvoza komunalnog otpada koji redovito plaća ovu uslugu, ostvarujete pravo na dva besplatna prijevoza krupnog (glomaznog) komunalnog otpada iz svog domaćinstva na zahtjev, odnosno po pozivu na broj telefona 051/781-177.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Postupak kod smrtnog slučaja',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      new Container(height: 1.5, color: Colors.black87),
                      ListTile(
                        title: Text(
                          "Ako nastupi smrtni slučaj naši dežurni djelatnici dostupni su 24 sata na dan na brojeve telefona 091/241-0609 i 091/242-0635 za informacije i dogovor oko preuzimanja pokojnika i ostalih usluga.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Kome se mogu obratiti za uređenje okućnice ili vrta?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      new Container(height: 1.5, color: Colors.black87),
                      ListTile(
                        title: Text(
                          "Pozivom na besplatan broj 0800 2999.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Gdje mogu platiti DPK (dnevna parkirna karta)?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      new Container(height: 1.5, color: Colors.black87),
                      ListTile(
                        title: Text(
                          "DPK možete platiti na našoj blagajni, putem pošte, FINA-e, banke, net-bankinga ili m-bankinga.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  /*,
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonTheme(
                      minWidth: 150,
                      child: new RaisedButton(
                        onPressed: () {
                          setState(() {
                           _message="Odgovor  1"; 
                          });
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
                              Icons.device_unknown,
                              size: 50,
                            ),
                            Text(
                              "Mogu li sam \ndovesti otpad na \nzbrinjavanje?",
                            ),
                          ],
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
                          setState(() {
                           _message="Odgovor  2"; 
                          });
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
                              Icons.device_unknown,
                              size: 50,
                            ),
                            Text(
                              "Pitanje broj dva \nkoje ima korisnik?",
                            ),
                          ],
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
                          setState(() {
                           _message="Odgovor  3"; 
                          });
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
                              Icons.device_unknown,
                              size: 50,
                            ),
                            Text(
                              "Pitanje broj tri \nkoje ima korisnik?",
                            ),
                          ],
                        ),
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(-1.1, 0),
              child: Image.asset(
                'images/maskota-razmislja.png',
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
