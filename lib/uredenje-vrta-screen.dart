import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Vrt extends StatefulWidget {
  createState() {
    return VrtState();
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

class VrtState extends State<Vrt> {
  String _message = "Što ću sa zelenim\notpadom nakon\nuređenja vrta?";

//GET MESSAGE
  Widget getMessage() {
    var message = Positioned(
      left: 110,
      top: 42,
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

  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 155, right: 5, top: 0, bottom: 0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      //                   <--- left side
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: <Widget>[
                    Image.asset(
              'images/recikliranje.png',
              height: 100.0,     
            ), Text(
                          'KOMPOSTIRANJE  JE NAJJEFTINIJI NAČIN ZA ZBRINJAVANJE ZELENOG OTPADA NAKON UREĐENJA VRTA.',
                          style: TextStyle(
                              //color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.device_unknown,
                          color: Colors.green,
                          size: 50,
                        ),
                        Text(
                          'ŠTO IZDVOJITI?',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      child: Text(
                          'Kompostirati se može sve biljne ostatke, kora od krumpira, kore od voća i povrća, ljuske jaja, listove salate, uvelo cvijeće, suhe grančice, koru drveta, slamu, piljevinu, otpalo voće, pokošenu travu.',
                          style: TextStyle(fontFamily: '')),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 50,
                        ),
                        Text(
                          'NIKAKO NE',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      child: Text(
                          'Ne kompostirati meso, ribu, ostatke kuhane hrane, mliječne proizvode, ulje, ostali reciklabilni otpad koji se odvojeno prikuplja (plastika, papir, konzerve, staklo, guma..), opasni otpad (baterije, lijekovi, ambalaže od boja i lakova…), mačji pijesak, pepeo, cigarete, lakirano i obojeno drvo. ',
                          style: TextStyle(fontFamily: '')),
                    ),
                    Text(
                          '\nKompostirati možete u bilo kakvom komposteru, plastičnom, drvenom ili žičanom. Komposter je potrebno zaštiti od vjetra, sunca i oborina.',
                          style: TextStyle(fontFamily: '')),
                  Text(
                          '\nPOSTUPAK',
                          style: TextStyle(fontFamily: '',fontWeight: FontWeight.bold)),
                    Text(
                          '\n1. stavite sloj grančica, suhog lišća, piljevine na dno kompostera',
                          style: TextStyle(fontFamily: '')),
                    Text(
                          '2. prekrijte tankim slojem zemlje',
                          style: TextStyle(fontFamily: '')),
                          Text(
                          '3. odlažite usitnjeni kuhinjski otpad za kompostiranje',
                          style: TextStyle(fontFamily: '')),
                          Text(
                          '4. povremeno pomiješajte                  ',
                          style: TextStyle(fontFamily: '')),
                  ],
                ),
              ),
            ],
          ),
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
        margin: EdgeInsets.only(top: 35),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(-1.1, 0),  
              child:  Image.asset(
              'images/maskota-razmislja.png',
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
              padding: EdgeInsets.only(top: 147),
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
