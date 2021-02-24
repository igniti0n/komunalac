import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'business_objects.dart';

class Narudzba extends StatefulWidget {
  createState() {
    return NarudzbaState();
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

//GET MESSAGE
Widget getMessage() {
  var message = Positioned(
    left: 117,
    top: 55,
    child: Text('Na koji dan?',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
  );
  return message;
}

enum ConfirmAction { DA, NE }
enum KakoJaviti { EMAIL, SMS }

String getEmail() {
  if (g_korisnik != null &&
      g_korisnik.email != null &&
      g_korisnik.email.length > 2) return g_korisnik.email;
  return "";
}

String getMob() {
  if (g_korisnik != null &&
      g_korisnik.mobitel != null &&
      g_korisnik.mobitel.length > 2) return g_korisnik.mobitel;
  return "";
}

class NarudzbaState extends State<Narudzba> {
  DateTime selectedDateTo = DateTime.now();
  DateTime selectedDateFrom = DateTime.now();

  final ctrl = new TextEditingController();

  Future<Null> _selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateFrom,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateFrom)
      setState(() {
        selectedDateFrom = picked;
      });
  }

  Future<Null> _selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateTo)
      setState(() {
        selectedDateTo = picked;
      });
  }

  List<String> itemsList = new List<String>();
  //var _datum;
  var _adresa;

  @override
  void initState() {
    http.get("http://komunalci.eu/crikvenica-api/api/AdresePopis",
        headers: {"Accept": "aplication/json"}).then((onValue) {
      for (var i in json.decode(onValue.body)) {
        Ulica ul = Ulica.fromJson(i);
        itemsList.add(ul.adresaJLS + "-" + ul.adresaUlica);
      }
      setState(() {
        itemsList = itemsList;
      });
    });
  }

  static var now = new DateTime.now();
  static var x1 = new DateTime.now().add(new Duration(days: 2));
  static var x1D = x1.day;
  static var x1M = x1.month;
  static var x1G = x1.year;
  static var x2 = new DateTime.now().add(new Duration(days: 3));
  static var x2D = x2.day;
  static var x2M = x2.month;
  static var x2G = x2.year;
  static var x3 = new DateTime.now().add(new Duration(days: 4));
  static var x3D = x3.day;
  static var x3M = x3.month;
  static var x3G = x3.year;
  static var x4 = new DateTime.now().add(new Duration(days: 5));
  static var x4D = x4.day;
  static var x4M = x4.month;
  static var x4G = x4.year;
  static var x5 = new DateTime.now().add(new Duration(days: 6));
  static var x5D = x5.day;
  static var x5M = x5.month;
  static var x5G = x5.year;
  static var x6 = new DateTime.now().add(new Duration(days: 7));
  static var x6D = x6.day;
  static var x6M = x6.month;
  static var x6G = x6.year;

  static var x7 = new DateTime.now().add(new Duration(days: 8));
  static var x7D = x7.day;
  static var x7M = x7.month;
  static var x7G = x7.year;

  var dani = <String>[
    "$x1D" + '.' + "$x1M" + '.' + "$x1G" + '.',
    "$x2D" + '.' + "$x2M" + '.' + "$x2G" + '.',
    "$x3D" + '.' + "$x3M" + '.' + "$x3G" + '.',
    "$x4D" + '.' + "$x4M" + '.' + "$x4G" + '.',
    "$x5D" + '.' + "$x5M" + '.' + "$x5G" + '.',
    "$x6D" + '.' + "$x6M" + '.' + "$x6G" + '.',
    "$x7D" + '.' + "$x7M" + '.' + "$x7G" + '.'
  ];

  Widget getListView() {
    bool vidljivo = !(g_korisnik == null ? false : true);

    return Form(
        child: Container(
      padding: EdgeInsets.only(left: 175, right: 10, top: 0, bottom: 50),
      child: ListView(
        children: <Widget>[
          RaisedButton(
            color: Colors.green,
            onPressed: () {
              _selectDateFrom(context);
            },
            child: Text(
              'Odaberi datum',
              style: TextStyle(color: Colors.white),
            ),
          ),
          /*  Container(
          //  padding: EdgeInsets.only(bottom: 0, top: 5, left: 8, right: 20),
           /* decoration: new BoxDecoration(
              border: new Border.all(color: Colors.green),
              borderRadius: BorderRadius.only(
                topLeft: (Radius.circular(5.0)),
                topRight: (Radius.circular(5.0)),
                bottomLeft: (Radius.circular(5.0)),
                bottomRight: (Radius.circular(5.0)),
              ),
            ),*/
            child: Column(
              children: <Widget>[
                
              /*  Text('Željeni datum'),
                DropdownButton<String>(
                  isExpanded: true,
                  items: dani.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {setState(() {
                    _datum=val;
                  });},
                )*/
              ],
            ),
          ),*/
          Visibility(
              maintainSize: vidljivo,
              maintainAnimation: true,
              maintainState: true,
              visible: vidljivo,
              child: Container(
                padding: EdgeInsets.only(bottom: 0, top: 5, left: 8, right: 20),
                margin: EdgeInsets.only(bottom: 10, top: 10),
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.green),
                  borderRadius: BorderRadius.only(
                    topLeft: (Radius.circular(5.0)),
                    topRight: (Radius.circular(5.0)),
                    bottomLeft: (Radius.circular(5.0)),
                    bottomRight: (Radius.circular(5.0)),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text('Adresa'),
                    DropdownButton<String>(
                      isExpanded: true,
                      items: itemsList.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _adresa = val;
                        });
                      },
                    )
                  ],
                ),
              )),
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

                  /*		  DateFormat format = new DateFormat("dd.MM.yyyy.");
                 
                  var datum=format.parse(_datum);
                  
                  print(datum);*/
                  var adr = _adresa;

                  showDialog<ConfirmAction>(
                    context: context,
                    barrierDismissible:
                        false, // user must tap button for close dialog!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Želiš povratnu informaciju?'),
                        content: const Text(
                            'Odaberi da li želiš da ti povratno javimo status rješavanja.'),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text('NE'),
                            onPressed: () async {
                              if (g_korisnik != null)
                                adr = g_korisnik.adresaJLS +
                                    " " +
                                    g_korisnik.adresaUlica +
                                    " " +
                                    g_korisnik.adresaKBR;
                              await http.post(
                                  "http://komunalci.eu/crikvenica-api/api/NarucivanjeOdvoza",
                                  headers: {
                                    "Accept": "aplication/json"
                                  },
                                  body: {
                                    "Dan": selectedDateFrom
                                        .toIso8601String() /*datum.toIso8601String()*/,
                                    "Adresa": adr,
                                    "userid":
                                        g_korisnik.sifra + " " + g_korisnik.ime,
                                    "NotifyStatus": "false"
                                  });
                              Navigator.pop(context, ConfirmAction.NE);
                              Navigator.pop(
                                  context, "Zahvaljujem na informaciji!");
                              alertTest(context);
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
                                      title: const Text(
                                          'Odaberi kako da ti javimo povratnu informaciju'),
                                      children: <Widget>[
                                        SimpleDialogOption(
                                          onPressed: () {
                                            String teamName = '';

                                            final emailController =
                                                new TextEditingController(
                                                    text: getEmail());
                                            // final mobController=new TextEditingController (text:getMob());
                                            showDialog<String>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // dialog is dismissible with a tap on the barrier
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Unesite email za obavijest'),
                                                  content: new Row(
                                                    children: <Widget>[
                                                      new Expanded(
                                                          child: new TextField(
                                                        controller:
                                                            emailController,
                                                        autofocus: true,
                                                        decoration: new InputDecoration(
                                                            labelText:
                                                                'Email za obavijest',
                                                            hintText:
                                                                'gdje ćemo javiti status?'),
                                                        onChanged: (value) {
                                                          teamName = value;
                                                        },
                                                      ))
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('OK'),
                                                      onPressed: () async {
                                                        if (g_korisnik != null)
                                                          adr = g_korisnik.adresaJLS +
                                                              " " +
                                                              g_korisnik
                                                                  .adresaUlica +
                                                              " " +
                                                              g_korisnik
                                                                  .adresaKBR;
                                                        if (teamName == '')
                                                          teamName = getEmail();

                                                        Map data = {
                                                          "Dan": selectedDateFrom
                                                              .toIso8601String() /*datum.toIso8601String()*/,
                                                          "Adresa": adr,
                                                          "userid": g_korisnik
                                                                  .sifra +
                                                              " " +
                                                              g_korisnik.ime,
                                                          "NotifyStatus":
                                                              "true",
                                                          "Email": teamName
                                                        };

                                                        var body =
                                                            json.encode(data);
                                                        print(body);
                                                        await http.post(
                                                            "http://komunalci.eu/crikvenica-api/api/NarucivanjeOdvoza",
                                                            headers: {
                                                              "Accept":
                                                                  "aplication/json"
                                                            },
                                                            body: body);
                                                        Navigator.of(context)
                                                            .pop(teamName);
                                                        Navigator.pop(context,
                                                            KakoJaviti.EMAIL);
                                                        Navigator.pop(context,
                                                            ConfirmAction.DA);
                                                        Navigator.pop(context,
                                                            "Zahvaljujem na informaciji!");
                                                        alertTest(context);
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

                                            final emailController =
                                                new TextEditingController(
                                                    text: getMob());
                                            // final mobController=new TextEditingController (text:getMob());
                                            showDialog<String>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // dialog is dismissible with a tap on the barrier
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Unesite broj mobitela'),
                                                  content: new Row(
                                                    children: <Widget>[
                                                      new Expanded(
                                                          child: new TextField(
                                                        controller:
                                                            emailController,
                                                        autofocus: true,
                                                        decoration: new InputDecoration(
                                                            labelText:
                                                                'Broj mobitela za obavijest',
                                                            hintText:
                                                                'gdje ćemo javiti status?'),
                                                        onChanged: (value) {
                                                          teamName = value;
                                                        },
                                                      ))
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('OK'),
                                                      onPressed: () async {
                                                        if (g_korisnik != null)
                                                          adr = g_korisnik.adresaJLS +
                                                              " " +
                                                              g_korisnik
                                                                  .adresaUlica +
                                                              " " +
                                                              g_korisnik
                                                                  .adresaKBR;

                                                        if (teamName == '')
                                                          teamName = getMob();
                                                        await http.post(
                                                            "http://komunalci.eu/crikvenica-api/api/NarucivanjeOdvoza",
                                                            headers: {
                                                              "Accept":
                                                                  "aplication/json"
                                                            },
                                                            body: {
                                                              "Dan": selectedDateFrom
                                                                  .toIso8601String() /*datum.toIso8601String()*/,
                                                              "Adresa": adr,
                                                              "userid": g_korisnik
                                                                      .sifra +
                                                                  " " +
                                                                  g_korisnik
                                                                      .ime,
                                                              "NotifyStatus":
                                                                  "true",
                                                              "Tel": teamName
                                                            });
                                                        Navigator.of(context)
                                                            .pop(teamName);
                                                        Navigator.pop(context,
                                                            KakoJaviti.EMAIL);
                                                        Navigator.pop(context,
                                                            ConfirmAction.DA);
                                                        Navigator.pop(context,
                                                            "Zahvaljujem na informaciji!");
                                                        alertTest(context);
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
                }

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Home()),
                // );
                ),
          ),
          /*RaisedButton(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              color: Colors.green,
              textColor: Colors.white,
              child: Text(
                'Pošalji i podsjeti me dan prije',
                textAlign: TextAlign.center,
              ),
              onPressed:  () async {

                    await http.post("http://komunalci.eu/crikvenica-api/api/NarucivanjeOdvoza", headers: {"Accept": "aplication/json"}, body: { "Dan": "2019-09-14T20:42:26.4241375+02:00", "Adresa": "A", "userid": g_korisnik.sifra , "NotifyStatus": "true"});
                      Navigator.pop(context, "Zahvaljujem na informaciji!");
                      alertTest(context);
                    }
              /*onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }*/
              ),*/
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
