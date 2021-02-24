import 'package:flutter/material.dart';

import 'izbornik.dart';
import 'kontakt.dart';
import 'koristnicki-racun-screen.dart';
import 'onama.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');
  int _currentIndex = 0;
  final List<Widget> _pageOptions = [
    // Launch(),

    Izbornik(),
    KoristnickiRacun(),
    Cistoca(),
    Kontakt()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          key: globalKey,
          currentIndex: _currentIndex,
          onTap: (int vrijednost) {
            print(vrijednost);
            setState(() => _currentIndex = vrijednost);
          },
          items: [
            BottomNavigationBarItem(
              // index 0
              icon: Icon(Icons.home),
              title: Text('Početna'),
            ),
            BottomNavigationBarItem(
              // index 1
              icon: Icon(Icons.home),
              title: Text('Moj kor. račun'),
            ),
            BottomNavigationBarItem(
              // index 2
              icon: Icon(Icons.info),
              title: Text('O nama'),
            ),
            BottomNavigationBarItem(
              // index 3
              icon: Icon(Icons.people),
              title: Text('Kontakt'),
            ),
          ],
          type: BottomNavigationBarType.fixed),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
