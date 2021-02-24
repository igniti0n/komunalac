import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'business_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Registracija extends StatefulWidget {
  createState() {
    return _RegistracijaState();
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
    left: 132,
    top: 55,
    child: Text('Slobodno \nizmjeni...',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
  );
  return message;
}

String getEmail(){
  if (g_korisnik!=null && g_korisnik.email!=null && g_korisnik.email.length>2)
  return g_korisnik.email;
  return "";
}


String getMob(){
  if (g_korisnik!=null && g_korisnik.mobitel!=null && g_korisnik.mobitel.length>2)
  return g_korisnik.mobitel;
  return "";
}

class _RegistracijaState extends State<Registracija> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();

 final emailController=new TextEditingController(text:getEmail());
 final mobController=new TextEditingController(text:getMob());


void alertTest(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        'Tvoji podaci su izmijenjeni',
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

  Widget getForm() {
    var form = Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(left: 125, right: 15, top: 0, bottom: 50),
        child: ListView(
          children: <Widget>[
            TextFormField(
            enabled: false,
            readOnly: true,
              initialValue: g_korisnik.ime,
              decoration: InputDecoration(
                labelText: 'Naziv korisnika',
                hintText: 'Ime korisnika usluge',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Unesite ime' : null,
              // onSaved: (value) => _ime = value,
            ),
            TextFormField(
               enabled: false,
            readOnly: true,
              initialValue: g_korisnik.adresaJLS,
              decoration: InputDecoration(
                labelText: 'Mjesto korisnika',
                hintText: 'Mjesto korisnika usluge',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Unesite adresu' : null,
              // onSaved: (value) => _prezime = value,
            ),
            TextFormField(
               enabled: false,
            readOnly: true,
              initialValue: g_korisnik.adresaUlica+' '+g_korisnik.adresaKBR,
              decoration: InputDecoration(
                labelText: 'Adresa',
                hintText: 'Adresa korisnika usluge',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Unesite adresu' : null,
              // onSaved: (value) => _prezime = value,
            ),
            // TextFormField(
            //   initialValue: g_korisnik.oIB,
            //   decoration: InputDecoration(
            //       labelText: 'OIB', hintText: 'OIB korisnika usluge',
            //       prefixIcon: Padding(
            //             padding: EdgeInsets.all(0.0),
            //             child: Icon(
            //               Icons.looks_one,
            //               color: Colors.green,
            //             ), 
            //           ),),
            //   validator: (value) =>
            //       value.isEmpty ? 'Oib nesmije biti prazan' : null,
            //   // onSaved: (value) =>
            // ),
            TextFormField(
               enabled: false,
            readOnly: true,
              initialValue: g_korisnik.sifra,
              decoration: InputDecoration(labelText: 'Šifra korisnika',prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.green,
                        ), 
                      ),),
              validator: (value) => value.isEmpty
                  ? 'Šifra korisnika ne smije biti prazna'
                  : null,
              // onSaved: (value) => _sifraKorisnika = value,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  InputDecoration(hintText: 'Email', labelText: 'Email',
                  prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.mail,
                          color: Colors.green,
                        ), 
                      ),
                  ),
              validator: (value) =>
                  value.isEmpty ? 'Email ne smije biti prazan' : null,
              // onSaved: (value) => _email = value,
            ),
            TextFormField(
              controller: mobController,
              decoration: InputDecoration(
                labelText: 'Broj mobitela',
                hintText: '+3859XXXXXXXX',
                prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.phone,
                          color: Colors.green,
                        ), 
                      ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Unesite broj telefona' : null,
              // onSaved: (value) => _brojMobitela = value,
            ),
            buildSubmitButton(),
          ],
        ),
      ),
    );
    return form;
  }

  Widget buildSubmitButton() {
    var buildButton = Container(
      padding: EdgeInsets.only(top: 5),
      child: RaisedButton(
        color: Colors.green,
        textColor: Colors.white,
        child: Text('Izmjena podataka'),
        onPressed: () {
           if (_formKey.currentState.validate()) {
           //  _controller.clear(); 
           var url ="http://komunalci.eu/crikvenica-api/api/Update";

                              Map data = {
                                "Sifra": g_korisnik.sifra ,"Email":emailController.text,"Tel":mobController.text
                              };
                              
                              var body = json.encode(data);
                              print (body);

                            http.post(url,
                                  headers: {"Content-Type": "application/json"},
                                  body: body
                              )//;
                              //http.post(, headers: {"Accept": "aplication/json"}, body: )
                              .then((onValue){
                                print(onValue.body);
                                print(onValue.statusCode);
                                g_korisnik.email=emailController.text;
                                g_korisnik.mobitel=mobController.text;
                                  SharedPreferences.getInstance().then((prefs) {
                                final value=prefs.getInt('ulogiran') ?? 0;
                                if (value>0){
                                    
                                     prefs.setString('mobitel', g_korisnik.mobitel);
                                      prefs.setString('email', g_korisnik.email);

                                }});
                             
                             
                             //  Navigator.pop(context, "Tvoji podaci su izmjenjeni");
                             alertTest(context);

                              });
          //    Scaffold
          // .of(context)
          // .showSnackBar(SnackBar(content: Text('Processing Data')));
           } 
        },
      ),
    );
    return buildButton;
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
              child:  Image.asset(
              'images/oblak-prazan.png',
              width: 190,    
            ),
            ),
            getMessage(),
            Container(
              padding: EdgeInsets.only(top: 155),
              child: getForm(),
            ),
            Container(
              alignment: Alignment(-0.9, 1.0),
              margin: EdgeInsets.only(left: 0, bottom: 0),
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
