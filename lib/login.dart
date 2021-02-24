import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'business_objects.dart';
import 'narudzba-odvoza-otpada.dart';
import 'registracija.dart';
import 'koristnicki-racun-screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  createState() {
    return LoginState();
  }
}

// GET SVG
final String assetName = 'images/maskota.svg';
final Widget svgIcon =
    new SvgPicture.asset(assetName, semanticsLabel: 'Maskota', height: 340);

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
    child: Text('Molim \nprijavite se ...',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
  );
  return message;
}


class LoginState extends State<Login>{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlKorisnik = new TextEditingController();
  final TextEditingController _ctrlZaporka = new TextEditingController();

  
  Widget getListView() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(left: 150, right: 15, top: 0, bottom: 50),
        child: ListView(
      children: <Widget>[
                  TextFormField(
                    controller: _ctrlKorisnik,
                  decoration: InputDecoration(
                  labelText: 'Korisnik'
              ),
              validator: (value) =>
                  value.isEmpty ? 'Unesite ime' : null,
              // onSaved: (value) => _ime = value,
            ),
                TextFormField(
                    controller: _ctrlZaporka,
                    decoration: InputDecoration(
                    labelText: 'Zaporka'
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Unesite prezime' : null,
                  // onSaved: (value) => _prezime = value,
                ),
                RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Prijava'),
                  onPressed: () {
                      http.post("http://komunalci.eu/crikvenica-api/api/PrijavaKorisnika",
                      headers: {"Accept": "aplication/json"},body: {"KorIme": _ctrlKorisnik.text, "Lozinka": _ctrlZaporka.text} ).then((onValue) async {
                        g_korisnik=Korisnik.fromJson(json.decode(onValue.body));

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

                        zadnjiLogin=DateTime.now();
                        if ( g_OpenAfterLogin=='NARUCI_ODVOZ')
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Narudzba()),
                        );
                        else
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KoristnickiRacun()),
                        );
                      });
                    } 
                ),
                RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Registriraj me'),
                  onPressed: () {
                      http.post("http://komunalci.eu/crikvenica-api/api/PrijavaKorisnika",headers: {"Accept": "aplication/json"},body: {"KorIme": _ctrlKorisnik.text, "Lozinka": _ctrlZaporka.text} ).then((onValue){
                        g_korisnik=Korisnik.fromJson(json.decode(onValue.body));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Registracija()),
                        );
                      });
                    } 
                ),                
            ],
          ),
        ));
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
           /* Container(
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
            ),*/
          ],
        ),
      ),
    );
  }
}
