import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'business_objects.dart';

class NarudzbaVrta extends StatefulWidget {
  createState() {
    return NarudzbaVrtaState();
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

//GET MESSAGE
Widget getMessage() {
  var message = Positioned(
    left: 117,
    top: 55,
    child: Text('Kontaktiraj nas!',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
  );
  return message;
}

String getIme() {
  if (g_korisnik != null) {
    return g_korisnik.ime;
  }
  return "";
}

String getEmail() {
  if (g_korisnik != null &&
      g_korisnik.email != null &&
      g_korisnik.email.length > 2) {
    return g_korisnik.email;
  }
  return "";
}

String getTel() {
  if (g_korisnik != null &&
      g_korisnik.mobitel != null &&
      g_korisnik.mobitel.length > 2) {
    return g_korisnik.mobitel;
  }
  return "";
}

class NarudzbaVrtaState extends State<NarudzbaVrta> {
  final imeContr = TextEditingController(text: getIme());
  final emailContr = TextEditingController(text: getEmail());
  final mobContr = TextEditingController(text: getTel());
  final opisContr = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    imeContr.dispose();
    super.dispose();
  }

  bool _value1 = false;
  bool _value2 = false;
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  Widget getListView() {
    return Form(
        child: Container(
      padding: EdgeInsets.only(left: 145, right: 15, top: 0, bottom: 10),
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Nudimo usluge orezivanja uresnih grmova i živica, sanitarni i oblikovni rez /sječa stabala, košnja travnjaka, krčenje zapuštenih parcela, utovar, odvoz i zbrinjavanje orezanog materijala, te ostali vrtlarski poslovi.',
            ),
          ),
          ListTile(
            title: Text(
              'Po obilasku terena slijedi izrada ponude, dostava ponude, te nakon prihvaćanja iste dogovaramo termin za izvršenje usluge ovisno o raspoloživim terminima.',
            ),
          ),
          TextFormField(
            controller: imeContr,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 1.0),
              ),
              hintText: 'Ime i prezime:',
              hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              contentPadding:
                  EdgeInsets.only(bottom: 22, top: 1, left: 5, right: 5),
            ),
          ),
          TextFormField(
            controller: emailContr,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 1.0),
              ),
              hintText: 'Email:',
              hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              contentPadding:
                  EdgeInsets.only(bottom: 22, top: 1, left: 5, right: 5),
            ),
          ),
          TextFormField(
            controller: mobContr,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 1.0),
              ),
              hintText: 'Mobitel:',
              hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              contentPadding:
                  EdgeInsets.only(bottom: 22, top: 1, left: 5, right: 5),
            ),
          ),
          TextFormField(
            controller: opisContr,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 1.0),
              ),
              hintText: 'Opis radova:',
              hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              contentPadding:
                  EdgeInsets.only(bottom: 22, top: 1, left: 5, right: 5),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: RaisedButton(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Pošalji'),
                onPressed: () {
                  var alertString = "";
                  if (emailContr.text.length < 3) {
                    alertString = "Nije popunjeno polje email!";
                  } else if (mobContr.text.length < 3) {
                    alertString = "Nije popunjeno polje mobitel!";
                  } else if (imeContr.text.length < 3) {
                    alertString = "Nije popunjeno polje Ime i prezime !";
                  } else if (opisContr.text.length < 3) {
                    alertString = "Nije popunjeno polje sa opisom radova!";
                  } else {
                    alertString = "Hvala na Vašem zahtjevu.";
                    var url =
                        "http://komunalci.eu/crikvenica-api/api/NarudzbaVrta";

                    Map data = {
                      "Opis": opisContr.text,
                      "userid": "-1",
                      "mob": mobContr.text,
                      "email": emailContr.text,
                      "ime": imeContr.text
                    };
                    var body = json.encode(data);
                    print(body);

                    http
                        .post(url,
                            headers: {"Content-Type": "application/json"},
                            body: body) //;
                        //http.post(, headers: {"Accept": "aplication/json"}, body: )
                        .then((onValue) {
                      print(onValue.body);
                      print(onValue.statusCode);
                      Navigator.pop(context);
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    });
                  }

                  if (alertString.length < 2) return;
                  var alertDialog = AlertDialog(
                    title: Text(
                      alertString,
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

                  return;

                  // alertTest(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Home()),
                  // );
                }),
          ),
          /*RaisedButton(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              color: Colors.green,
              textColor: Colors.white,
              child: Text(
                'Pošalji i podsjeti me dan prije',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }),*/
        ],
      ),
    ));
  }

  Future alertTest(BuildContext context) async {
    var alertString = "";
    if (emailContr.text.length < 3) {
      alertString = "Nije popunjeno polje email!";
    } else if (mobContr.text.length < 3) {
      alertString = "Nije popunjeno polje mobitel!";
    } else if (imeContr.text.length < 3) {
      alertString = "Nije popunjeno polje Ime i prezime !";
    } else if (opisContr.text.length < 3) {
      alertString = "Nije popunjeno polje sa opisom radova!";
    }

    /*if ()
   
*/

    else {
      alertString = "Hvala na Vašem zahtjevu.";

      await http.post("http://komunalci.eu/crikvenica-api/api/NarudzbaVrta",
          headers: {
            "Accept": "aplication/json",
            "Content-Type": "aplication/json"
          },
          body: {
            "Opis": opisContr.text,
            "userid": g_korisnik.sifra,
            "mob": mobContr.text,
            "email": emailContr.text
          });
    }

    var alertDialog = AlertDialog(
      title: Text(
        alertString,
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
