import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'business_objects.dart';

class OrderReg extends StatefulWidget {
  createState() {
    return OrderRegState();
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

enum ConfirmAction { DA, NE }
enum KakoJaviti { EMAIL, SMS }


//GET MESSAGE
Widget getMessage() {
  var message = Positioned(
    left: 117,
    top: 55,
    child: Text('Daj malo više \ndetalja ...',
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



class OrderRegState extends State<OrderReg> {
  final _formKey = GlobalKey<FormState>();
  final ctrl = new TextEditingController();

  
  File  _image;
  File  _document;

  Widget getListView(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 130, right: 10, top: 0, bottom: 50),
          child: ListView(
            children: <Widget>[
              new Theme(
                data: new ThemeData(
                  primaryColor: Colors.green,
                  primaryColorDark: Colors.green,
                ),
                child: TextFormField(
                  controller: ctrl,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 1.0),
                    ),
                    hintText: 'Opis nepravilnosti:',
                    hintStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                    contentPadding:
                        EdgeInsets.only(bottom: 22, top: 1, left: 5, right: 5),
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Opis nepravlinosti' : null,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: RaisedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.photo_camera),
                      Text(
                        "Uslikaj",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  color: Colors.white,
                  onPressed: () async {
                    var image = await ImagePicker.pickImage(
                    source: ImageSource.camera,

                        maxHeight: 768, maxWidth: 1024
                    );
                    setState(() {
                      _image = image;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: RaisedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.pages),
                      Text(
                        "Priloži dokument",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  color: Colors.white,
                  onPressed: () async {
                      var document = await ImagePicker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 768, maxWidth: 1024
                      );

                      setState(() {
                      _document = document;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: RaisedButton(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text('Pošalji'),
                    onPressed: () async {

                 /*   Img.Image image_temp = Img.decodeImage(_image.readAsBytesSync());
                    Img.Image resized_img = Img.copyResize(image_temp, 800);*/


                    showDialog<ConfirmAction>(
                    context: context,
                    barrierDismissible: false, // user must tap button for close dialog!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Želiš povratnu informaciju?'),
                        content: const Text(
                            'Odaberi da li želiš da ti povratno javimo status rješavanja.'),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text('NE'),
                            onPressed: () {

                              var url ="http://komunalci.eu/crikvenica-api/api/PrijavaNepravilnosti";

                              Map data = {
                                "Tip": "1", "Opis": this.ctrl.text, "userid": g_korisnik.sifra ,"Slika":_image!=null? base64Encode(_image.readAsBytesSync()):null, "Dokument": _document!=null?base64Encode(_document.readAsBytesSync()):null, "NotifyStatus": "false"
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
                               Navigator.pop(context, ConfirmAction.NE);
                               Navigator.pop(context, "Zahvaljujem na informaciji!");

                              });
                             
                            },
                          ),
                          FlatButton(
                            child: const Text('DA'),
                            onPressed: () {
                             
                                showDialog<KakoJaviti>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: const Text('Odaberi kako da ti javimo povratnu informaciju'),
                                    children: <Widget>[
                                      SimpleDialogOption(
                                        onPressed: () {
                                       String teamName = '';

                                          final emailController=new TextEditingController(text:getEmail());
                                      // final mobController=new TextEditingController (text:getMob());
                                          showDialog<String>(
                                              context: context,
                                              barrierDismissible: false, // dialog is dismissible with a tap on the barrier
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Unesite email za obavijest'),
                                                  content: new Row(
                                                    children: <Widget>[
                                                      new Expanded(
                                                          child: new TextField(
                                                            controller: emailController,
                                                        autofocus: true,
                                                        decoration: new InputDecoration(
                                                            labelText: 'Email za obavijest', hintText: 'gdje ćemo javiti status?'),
                                                        onChanged: (value) {
                                                          teamName = value;
                                                        },
                                                      ))
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('OK'),
                                                      onPressed: () {

                                                         var url ="http://komunalci.eu/crikvenica-api/api/PrijavaNepravilnosti";

                                                          Map data = {
                                                            "Tip": "1", "Opis": this.ctrl.text, "userid": g_korisnik.sifra ,"Slika":_image!=null? base64Encode(_image.readAsBytesSync()):null, "Dokument": _document!=null?base64Encode(_document.readAsBytesSync()):null, "NotifyStatus": true, "Email":teamName
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
                                                              Navigator.of(context).pop(teamName);
                                                               Navigator.pop(context, KakoJaviti.EMAIL);
                                                         Navigator.pop(context, ConfirmAction.DA);
                                                     // Navigator.pop(context, "Zahvaljujem na informaciji!");
                                                          Navigator.pop(context, "Zahvaljujem na informaciji!");
                                                        
                                                          });
                                                        



                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                        },
                                        child: const Text('E-mailom'),
                                      ),
                                      SimpleDialogOption(
                                        onPressed: () {
                                          String teamName = '';

                                          final emailController=new TextEditingController(text:getMob());
                                      // final mobController=new TextEditingController (text:getMob());
                                          showDialog<String>(
                                              context: context,
                                              barrierDismissible: false, // dialog is dismissible with a tap on the barrier
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Unesite broj mobitela'),
                                                  content: new Row(
                                                    children: <Widget>[
                                                      new Expanded(
                                                          child: new TextField(
                                                            controller: emailController,
                                                        autofocus: true,
                                                        decoration: new InputDecoration(
                                                            labelText: 'Broj mobitela za obavijest', hintText: 'gdje ćemo javiti status?'),
                                                        onChanged: (value) {
                                                          teamName = value;
                                                        },
                                                      ))
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('OK'),
                                                      onPressed: () {

                                                         var url ="http://komunalci.eu/crikvenica-api/api/PrijavaNepravilnosti";

                                                          Map data = {
                                                            "Tip": "1", "Opis": this.ctrl.text, "userid": g_korisnik.sifra ,"Slika":_image!=null? base64Encode(_image.readAsBytesSync()):null, "Dokument": _document!=null?base64Encode(_document.readAsBytesSync()):null, "NotifyStatus": true, "Tel":teamName
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
                                                           Navigator.of(context).pop(teamName);
                                                               Navigator.pop(context, KakoJaviti.EMAIL);
                                                         Navigator.pop(context, ConfirmAction.DA);
                                                          Navigator.pop(context, "Zahvaljujem na informaciji!");
                                                        
                                                          });
                                                        



                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                     
                                        },
                                        child: const Text('Na mobitel'),
                                      ),
                                      
                                    ],
                                  );
                                });

                            },
                          )
                        ],
                      );
                    },
                  );


                    
                    }),
              ),
              /*RaisedButton(
                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Pošalji i javljaj mi status rješavanja',
                      textAlign: TextAlign.center),
                  onPressed: () async {

                    await http.post("http://komunalci.eu/crikvenica-api/api/PrijavaNepravilnosti", headers: {"Accept": "aplication/json"}, body: { "Tip": "1", "Opis": this.ctrl.text, "userid": g_korisnik.sifra ,"Slika": base64Encode(_image.readAsBytesSync()), "Dokument": base64Encode(_document.readAsBytesSync()), "NotifyStatus": "true"});
                      Navigator.pop(context, "Zahvaljujem na informaciji!");
                    }),*/
            ],
          ),
        ));
  }

  void alertTest(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        'Hvala na informaciji',
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
 
      body: Builder(
      // Create an inner BuildContext so that the onPressed methods
      // can refer to the Scaffold with Scaffold.of().
      builder: (BuildContext context) { return Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(-1.2, 0),  
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
      },
    ))
    ;
  }
}
