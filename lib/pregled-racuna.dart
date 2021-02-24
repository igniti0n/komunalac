import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'business_objects.dart';
import 'otvori-racun.dart';

class PregledRacuna extends StatefulWidget {
  createState() {
    return PregledRacunaState();
  }
}

enum ConfirmAction { DA, NE }
enum KakoJaviti { EMAIL, SMS }

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

final f = new DateFormat("d dd.MM.yyyy.");

class PregledRacunaState extends State<PregledRacuna> {
  String _message = "        Pregled\n          tvojih\n         računa";

  List data;

  Future<String> getData() async {
    var response = await http.post(
        Uri.encodeFull("http://komunalci.eu/crikvenica-api/api/RacuniList"),
        headers: {"Accept": "aplication/json"},
        body: {"KorIme": g_korisnik.sifra, "Lozinka": g_korisnik.sifra});

    this.setState(() {
      data = jsonDecode(response.body);
    });
    print(data[1]["title"]);

    return "Success!";
  }

  /* Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }*/

  String assetPDFPath = "";
  String urlPDFPath = "";
  BuildContext ctx_root;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Icon getIcona(String ulaz) {
    if (ulaz == 'Podmireno')
      return new Icon(Icons.check);
    else
      return new Icon(Icons.error_outline);
  }

  OtvoriRacun(String idRac, String idObj) async {
    String url = 'https://komunalci.eu/crikvenica-api/Home/GetRacunPDF?id=' +
        g_korisnik.sifra +
        '&broj=' +
        idRac +
        '&obj=' +
        idObj; //foxsy&text=PARKING:RI123AA';// 'https://msng.link/vi/385993225988';
/*   getFileFromUrl(url).then((f) {
    //  setState(() {
        urlPDFPath = f.path;
        print(urlPDFPath);


             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(urlPDFPath)));
      });
    //});*/
  }

  OtvoriRacun2(String idRac, String idObj, BuildContext ctx) async {
    String url = 'https://komunalci.eu/crikvenica-api/Home/GetRacunPDF?id=' +
        g_korisnik.sifra +
        '&broj=' +
        idRac +
        '&obj=' +
        idObj; //foxsy&text=PARKING:RI123AA';// 'https://msng.link/vi/385993225988';
    /*getFileFromUrl(url).then((f) {
      setState(() {
        urlPDFPath = f.path;
        print(urlPDFPath);


             Navigator.push(
                              ctx,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      PdfViewPage(urlPDFPath)));
      });
    });*/
  }

  EmailRacun(String idRac, String idObj) async {
    String url = 'http://komunalci.eu/crikvenica-api/Home/GetRacunPDF?id=' +
        g_korisnik.sifra +
        '&broj=' +
        idRac +
        '&obj=' +
        idObj; //foxsy&text=PARKING:RI123AA';// 'https://msng.link/vi/385993225988';
    await http.get(url);
  }

  SkiniRacun(String idRac, String idObj) async {
    String url = 'https://komunalci.eu/crikvenica-api/Home/GetRacunPDF?id=' +
        g_korisnik.sifra +
        '&broj=' +
        idRac +
        '&obj=' +
        idObj; //foxsy&text=PARKING:RI123AA';// 'https://msng.link/vi/385993225988';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getEmail() {
    if (g_korisnik != null &&
        g_korisnik.email != null &&
        g_korisnik.email.length > 2) return g_korisnik.email;
    return "";
  }

//GET MESSAGE
  Widget getMessage() {
    var message = Positioned(
      left: 108,
      top: 45,
      child: Text(
        getText(),
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Bobbers",
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
    return message;
  }

  String getText() {
    return _message;
  }

  Widget getListView() {
    var listView = new ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
            margin: EdgeInsets.only(left: 90),
            child: Column(children: <Widget>[
              ListTile(
                leading: getIcona(data[index]["Type"]),
                title: Text(
                  'Period ' +
                      data[index]["Volume"] +
                      ' ' +
                      data[index]["UkupanIznos"] +
                      'kn',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'Ukupan Iznos: \n' +
                      data[index]["Executed"] +
                      " " +
                      data[index]["Type"],
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () {
                  //  OtvoriRacun(data[index]["Marking"],data[index]["Marking3"]);

                  showDialog<ConfirmAction>(
                      context: context,
                      barrierDismissible:
                          false, // user must tap button for close dialog!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Pregled, preuzimanje ili slanje računa'),
                          content: const Text(
                              'Odaberi da li želiš pregled računa u aplikaciji, preuzimanje ili slanje računa na mail'),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Pregled'),
                              onPressed: () {
                                String url =
                                    'https://komunalci.eu/crikvenica-api/Home/RacunPregled?id=' +
                                        g_korisnik.sifra +
                                        '&broj=' +
                                        data[index]["Marking"] +
                                        '&obj=' +
                                        data[index]["Marking3"];
//url="http://www.pdf995.com/samples/pdf.pdf";
                                url += '&miki=' +
                                    new DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
//url='https://komunalci.eu/crikvenica-api/Home/RacunPregled';
                                print(url);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => Racun(
                                          selectedUrl: url,
                                        )));

                                //Navigator.pop(context, ConfirmAction.DA);
                              },
                            ),
                            FlatButton(
                              child: const Text('Preuzimanje'),
                              onPressed: () {
                                SkiniRacun(data[index]["Marking"],
                                    data[index]["Marking3"]);
                                Navigator.pop(context, ConfirmAction.DA);
                              },
                            ),
                            FlatButton(
                                child: const Text('Slanje na email'),
                                onPressed: () {
                                  var teamName = "";
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
                                            'Unesite email za slanje računa'),
                                        content: new Row(
                                          children: <Widget>[
                                            new Expanded(
                                                child: new TextField(
                                              controller: emailController,
                                              autofocus: true,
                                              decoration: new InputDecoration(
                                                  labelText:
                                                      'Email za slanje računa',
                                                  hintText:
                                                      'gdje ćemo poslati račun?'),
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
                                              var idRac =
                                                  data[index]["Marking"];
                                              var idObj =
                                                  data[index]["Marking3"];

                                              String url =
                                                  'http://komunalci.eu/crikvenica-api/Home/GetRacunPDF?id=' +
                                                      g_korisnik.sifra +
                                                      '&broj=' +
                                                      idRac +
                                                      '&obj=' +
                                                      idObj +
                                                      '&email=' +
                                                      teamName;

                                              http.get(url).then((onValue) {
                                                print(onValue.body);
                                                print(onValue.statusCode);
                                                Navigator.of(context)
                                                    .pop(teamName);
                                                Navigator.pop(
                                                    context, ConfirmAction.DA);
                                                // Navigator.pop(context, ConfirmAction.DA);
                                                // Navigator.pop(context, "Zahvaljujem na informaciji!");
                                                Navigator.pop(context,
                                                    "Račun će biti poslan!");
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                          ],
                        );
                      });
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              )
            ]));
      },
    );
    /*ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 90,
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik 120L',
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'oznaka spremnika: 12345\nVrijeme usluge: 2017.02.14. 14:55',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 110, right: 5),
          child: new Divider(
            height: 15.0,
            color: Colors.green,
          ),
        ),
      ],
    );*/
    return listView;
  }

  @override
  Widget build(BuildContext context) {
    this.ctx_root = context;
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(-1.2, 0.2),
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

/*
class PdfViewPage extends StatefulWidget {
  String path;

  PdfViewPage(String putanja){
    this.path=putanja;
  }

//  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState(this.path);
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  String putanja="/data/user/0/com.einventura.ekomurvica/app_flutter/mypdfonline.pdf";
  PDFViewController _pdfViewController;

_PdfViewPageState(String koji_path){
  this.putanja=koji_path;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pregled računa"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath:this.putanja,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("<< Str. ${_currentPage}"),
                  onPressed: () {
                    _currentPage -= 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
          _currentPage+1 < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("Str. ${_currentPage + 2} >>"),
                  onPressed: () {
                    _currentPage += 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
        ],
      ),
    );
  }
}

*/
