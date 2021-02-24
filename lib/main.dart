import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:flutter_svg/svg.dart';
import 'business_objects.dart';
import 'homepage.dart';
import 'moja-vozila-registracije.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

final ThemeData _themeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  primaryColor: Colors.black,
  accentColor: Colors.black,
  fontFamily: 'Montserrat',
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);

class _MyAppState extends State<MyApp> {
  final store =
      Store<ListState>(reducer, initialState: ListState.initialState());
  final FirebaseMessaging _messaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _messaging.getToken().then((token) {
      print(token);
    });

    _messaging.subscribeToTopic("sve");

    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );

    SharedPreferences.getInstance().then((prefs) {
      final value = prefs.getInt('ulogiran') ?? 0;
      if (value > 0) {
        String ime = prefs.getString('ime');
        String prezime = prefs.getString('prezime');
        String oIB = prefs.getString('oIB');
        String sifra = prefs.getString('sifra');
        String mobitel = prefs.getString('mobitel');
        String email = prefs.getString('email');
        String adresaUlica = prefs.getString('adresaUlica');
        String adresaJLS = prefs.getString('adresaJLS');
        String adresaKBR = prefs.getString('adresaKBR');
        int adresaId = prefs.getInt('adresaId') ?? 0;
        String litraE = prefs.getString('litraE');
        String barkodi = prefs.getString('barkodi');

        g_korisnik = new Korisnik();
        g_korisnik.ime = ime;
        g_korisnik.prezime = prezime;
        g_korisnik.mobitel = mobitel;
        g_korisnik.oIB = oIB;
        g_korisnik.sifra = sifra;
        g_korisnik.adresaId = adresaId;
        g_korisnik.email = email;
        g_korisnik.adresaJLS = adresaJLS;
        g_korisnik.adresaUlica = adresaUlica;
        g_korisnik.adresaKBR = adresaKBR;
        g_korisnik.litraE = litraE;
        g_korisnik.barkodi = barkodi;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ListState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _themeData,
        title: 'EkoMurvica',
        home: Home(),
      ),
    );
  }
}
