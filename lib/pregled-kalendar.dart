import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'business_objects.dart';

class PregledKalendar extends StatefulWidget {
  String tipKal = "";
  String kada = "";
  createState() {
    return PregledKalendarState(this.tipKal, this.kada);
  }

  PregledKalendar({@required this.tipKal, @required this.kada});
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

final f = new DateFormat("d dd.MM.yyyy.");

class PregledKalendarState extends State<PregledKalendar> {
  String _message = "Koju informaciju \n trebaš?";

  String _tipKal = "";
  String _kada = "";

  PregledKalendarState(String tip, String kada) {
    this._tipKal = tip;
    this._kada = kada;
  }

  static List<DateTime> presentDates;

  Future<String> getData(String kamo) async {
//MKO,PLASTIKA,REC
//MKO,PLASTIKA:Z/I
//REC:DRAMALJ,JADRANOVO,SELCE,CRIKVENICA_CENTAR;CRIKVENICA_ZAPAD,CRIKVENICA_ISTOK
    var url =
        'http://komunalci.eu/crikvenica-api/Home/GetDatumi?tip=' + _tipKal;

    if (g_korisnik != null && kamo.isEmpty) {
      url += '&userid=' + g_korisnik.sifra;
    } else {
      if (_tipKal == "REC") {
        url += '&jls=' + kamo;
      } else
        url += '&adr=' + kamo;
    }

    var response = await http.get(
        url); //'15.01.2020,04.03.2020,06.05.2020,09.09.2020,04.11.2020'; ///

    this.setState(() {
      var data = response.body.split(',');
      DateFormat format = new DateFormat("dd.MM.yyyy");
      presentDates = List<DateTime>();

      presentDates = data.map((name) => format.parse(name)).toList();

      var len = 0;
      _markedDateMap = new EventList<Event>(
        events: {},
      );

      if (presentDates != null) len = presentDates.length;
      for (int i = 0; i < len; i++) {
        _markedDateMap.add(
          presentDates[i],
          new Event(
            date: presentDates[i],
            title: 'Odvoz',
            icon: _presentIcon(
              presentDates[i].day.toString(),
            ),
          ),
        );
      }

      /*  while ()

      for (int i = 0; i < data.length-1; i++) {
      presentDates.add(
        format.parse(data[i])
     
      );
      }*/
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    getData("");
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

  double vrh = 25;

//GET MESSAGE
  Widget getMessage() {
    if (_tipKal == "REC") vrh = 12;

    double lijevo = 135;
    if (_tipKal == "REC") lijevo = 125;

    var message = Positioned(
      left: lijevo,
      top: vrh,
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

  String prikazText = "";

  String getText() {
    if (_kada.isNotEmpty) {
      prikazText = _kada;

      return prikazText;
    }

    return _message;
  }

  Widget getListView() {
    if (_tipKal == "REC") {
      return new Container(
          transform: Matrix4.translationValues(0.0, -60.0, 0.0),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5, right: 10),
                child: ButtonTheme(
                  minWidth: 50,
                  child: RaisedButton(
                    onPressed: () {
                      //
                      getData("CRIKVENICA_CENTAR");

                      _kada =
                          "CENTAR\nLokacija\npreuzimanja:\nStross.\nŠetalište\nHotel Zagreb\n";
                      // prikazText=_kada+"\nLokacija:\nHotel Zagreb";
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    textColor: Colors.green,
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 8, right: 8),
                    child: Text(
                      "CENTAR",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5, right: 10),
                child: ButtonTheme(
                  minWidth: 50,
                  child: RaisedButton(
                    onPressed: () {
                      getData("CRIKVENICA_ISTOK");
                      _kada =
                          "ISTOK\nLokacija\npreuzimanja:\nParkiralište\nkod zgrade\nHrusta 5C";

                      //
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    textColor: Colors.green,
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 8, right: 8),
                    child: Text(
                      "ISTOK",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5, right: 10),
                child: ButtonTheme(
                  minWidth: 50,
                  child: RaisedButton(
                    onPressed: () {
                      getData("CRIKVENICA_ZAPAD");

                      _kada =
                          "ZAPAD\nLokacija\npreuzimanja:\nT.Ujevića\nkod zgrade\nMO";
                      //
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    textColor: Colors.green,
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 8, right: 8),
                    child: Text(
                      "ZAPAD",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ]),
            Row(children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5, right: 10),
                child: ButtonTheme(
                  minWidth: 50,
                  child: RaisedButton(
                    onPressed: () {
                      getData("DRAMALJ");
                      _kada =
                          "DRAMALJ\nLokacija\npreuzimanja:\nDram. Selce 30\npokraj Trgovine\nKrk";
                      //  prikazText=_kada+"\nLokacija:\nDram. Selce 30";
                      //
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    textColor: Colors.green,
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 8, right: 8),
                    child: Text(
                      "DRAMALJ",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5, right: 10),
                child: ButtonTheme(
                  minWidth: 50,
                  child: RaisedButton(
                    onPressed: () {
                      getData("JADRANOVO");
                      _kada =
                          "JADRANOVO\n\nLokacija\npreuzimanja:\nkod škole\nuz placu";
                      //
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    textColor: Colors.green,
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 8, right: 8),
                    child: Text(
                      "JADRANOVO",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5, right: 10),
                child: ButtonTheme(
                  minWidth: 50,
                  child: RaisedButton(
                    onPressed: () {
                      getData("SELCE");
                      _kada =
                          "SELCE\n\nLokacija\npreuzimanja:\nkod trafostanice";
                      prikazText = _kada + "\nLokacija:\nkod trafostanice";
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    textColor: Colors.green,
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 8, right: 8),
                    child: Text(
                      "SELCE",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ])
          ]));
    } else
      return new Container(
          transform: Matrix4.translationValues(0.0, -60.0, 0.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 5, right: 10),
                  child: ButtonTheme(
                    minWidth: 50,
                    child: RaisedButton(
                      onPressed: () {
                        getData("I");
                        _kada = "    ISTOK\n\nPregled svih\n    termina";
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      textColor: Colors.green,
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 16, left: 8, right: 8),
                      child: Text(
                        "ISTOK",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: ButtonTheme(
                    minWidth: 50,
                    child: RaisedButton(
                      onPressed: () {
                        getData("Z");
                        _kada = "    ZAPAD\n\nPregled svih\n    termina";
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      textColor: Colors.green,
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 16, left: 8, right: 8),
                      child: Text(
                        "ZAPAD",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ]));
  }

  /*Widget getListView() {
    var listView = 
     new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new  Container(
             margin: EdgeInsets.only(left: 90),
            child:Column(
                children: <Widget>[

                   ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  'Spremnik '+ data[index]["Volume"],
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  'Vrijeme usluge: \n'+ data[index]["Executed"],
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 5),
                child: new Divider(
                  height: 15.0,
                  color: Colors.grey,
                ),
                
                  
             )]
          
          ));
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
  }*/

  DateTime _currentDate2 = DateTime.now();
  static Widget _presentIcon(String day) => Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(1000),
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );
  static Widget _absentIcon(String day) => Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(1000),
          ),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  CalendarCarousel _calendarCarouselNoHeader;

  Widget markerRepresent(Color color, String data) {
    return new Container(
        transform: Matrix4.translationValues(0.0, -120.0, 0.0),
        child: ListTile(
          leading: new CircleAvatar(
            backgroundColor: color,
            radius: cHeight * 0.022,
          ),
          title: new Text(
            data,
          ),
        ));
  }

  double cHeight;
  @override
  Widget build(BuildContext context) {
    //presentDates=List<DateTime>();

    cHeight = MediaQuery.of(context).size.height;
    var cWidth = MediaQuery.of(context).size.width * 0.7;

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.54,
      width: cWidth,
      firstDayOfWeek: 1,
      locale: "hr_HR",
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      todayButtonColor: Colors.white54, //[200],
      todayTextStyle: TextStyle(color: Colors.black),
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

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
                child: Container(
                    margin: EdgeInsets.only(left: 90),
                    child: Column(children: <Widget>[
                      _calendarCarouselNoHeader,
                      //       markerRepresent(Colors.green, "Dani odvoza"),
//                    markerRepresent(Colors.blue[200], "Danas"),
                      getListView()
                    ])) //getListView(),
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
