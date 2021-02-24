import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class VrstaOtpada extends StatefulWidget {
  createState() {
    return VrstaOtpadaState();
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

class VrstaOtpadaState extends State<VrstaOtpada> {
  String _message = "Pregled vrsta\nglomaznog otpada\ni otpada na\nreciklažnom\ndvorištu";

//GET MESSAGE
  Widget getMessage() {
    var message = Positioned(
      left: 110,
      top: 32,
      child: Text(
        getText(),
        style: TextStyle(
          fontSize: 17.0,
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

  int _radioValue1=-1;

  Widget getListView() {
    var listView = ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 155, right: 5),
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
            children: <Widget>[
              ExpansionTile(
                    title: Text(
                      'Glomazni otpad',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Garaža Eko-Murvice d.o.o.\nAdresa: Vinodolska 22b\nTelefon: 051/781-177",
                          textAlign: TextAlign.center,
                        ),
                      ),
                        ListTile(
                        title: Text(
                          "Popis vrsta predmeta i tvari koji se smatraju krupnim (glomaznim) komunalnim otpadom",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                        
                      ),
                      ExpansionTile(
                        title: Text(
                          'Kupaonska oprema',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "kada (plastična, fiberstaklena, metalna i sl.), tuš - kada, kada za djecu, kupaonski ormar i police, zavjesa ili pregrada za tuš ili kadu, nosač zavjese (karniša), umivaonik, toalet, i bide (školjka i daska), slavina za vodu, nosač tuša i crijevo za tuš, stalak za ručnike i sl., ogledalo.",
                              textAlign: TextAlign.center,
                            ),
                          )])
,
                      ExpansionTile(
                        title: Text(
                          'Stvari za djecu',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "krevet za dijete, stolica i hodalica za dijete, veće igračke, dječja kolica, autosjedalica za dijete",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Podne obloge',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "tepih, laminat, linoleum, parket, krzno i sl.",
                              textAlign: TextAlign.center,
                            ),
                          )])
,
                      ExpansionTile(
                        title: Text(
                          'Namještaj',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "ormar, komoda, ladičar, vitrina, noćni ormarić i sl., polica (npr. Ugradbena, samostojeća, zidna i sl.), stol (npr. Radni, za računalo, kuhinjski, za blagovaonicu, toaletni i sl.), stolac, klupa, stalak (stolni, zidni za npr. televizor), fotelja, naslonjač, krevet, tabure, madrac, nadmadrac, podnica kreveta, okvir za sliku većih dimenzija, prozorske zaštitne rešetke i grilje, sobne pregrade.",
                              textAlign: TextAlign.center,
                            ),
                          )])
,
                      ExpansionTile(
                        title: Text(
                          'Kuhinjska oprema',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "kuhinjski elementi (ugradbeni, samostojeći i dr.), sudoper, radna površina, šank",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Vrtna oprema',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "ograda i vrata, vrtni namještaj, vrtni alat, strojevi za vrt (kolica, kosilica i sl.), sjenica za vrt (rastavljena na dijelove dimenzija pogodnih za prijevoz), drvo (izrezano na dimenzije pogodne za prijevoz), posuda (npr. Za cvijeće) i postolje/nosač većih dimenzija, vrtni ukrasi većih dimenzija, vrtna klupa, crijevo za odu, oprema za razvođenje vode te posude za zalijevanje bilja, ljuljačka, suncobran i stalak za suncobran, sklopivi bazen, roštilj.",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Ostali glomazni otpad',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              " rolete, žaluzine, tende i sl., ljestve i samostojeće stepenice, zavjese i nosači zavjesa, vrata (npr. Sobna, ulazna i dr.), staklo (okno), prozor, prozorski okviri, invalidska kolica, dekorativni predmeti većih dimenzija, oprema za kućne ljubimce većih dimenzija (akvarij, žičani kavez i sl.), sprave za vježbanje i veća oprema za sport i rekreaciju (bicikl, daska za jedrenje, kajak, kanu, pedaline i sl.),  radijator, kante i posude većih dimenzija, tapete, daska za glačanje, okvir za sušenje rublja",
                              textAlign: TextAlign.center,
                            ),
                          )])

                        ],),
          
              ExpansionTile(
                    title: Text(
                      'Reciklažno dvorište',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    children: <Widget>[
                        ListTile(
                        title: Text(
                          "Popis predmeta i tvari koje prihvaćamo u mobilnom reciklažnom dvorištu",
                          textAlign: TextAlign.center,
                          
                        ),
                        
                      ),
                      ExpansionTile(
                        title: Text(
                          'Problematični otpad',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "otapala, kiseline, lužine, fotografske kemikalije, pesticidi, fluorescentne cijevi i ostali otpad koji sadrži živu, odbačena oprema koja sadrži klorofluorougljike, ulja i masti koji nisu navedeni pod 20 01 25*, boje, tinte, ljepila i smole, koje sadrže opasne tvari, deterdženti koji sadrže opasne tvari, citotoksici i citostatici, baterije i akumulatori obuhvaćeni pod 16 06 01*, 16 06 02* ili 16 06 03* i nesortirane baterije i akumulatori koji sadrže te baterije, odbačena električna i elektronička oprema koja nije navedena pod 20 01 21* i 20 01 23*, koja sadrži opasne komponente, drvo koje sadrži opasne tvari, plinovi u posudama pod tlakom (uključujući halone) koji sadrže opasne tvari, ambalaža koja sadrži ostatke opasnih tvari ili je onečišćena opasnim tvarima, metalna ambalaža koja sadrži opasne krute porozne materijale (npr. azbest), uključujući prazne spremnike pod tlakom, ",
                              textAlign: TextAlign.center,
                            ),
                          )])
,
                      ExpansionTile(
                        title: Text(
                          'Otpadni papir',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "papirna i kartonska ambalaža, papir i karton",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Otpadni metal',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "metalna ambalaža,metali",
                              textAlign: TextAlign.center,
                            ),
                          )])
,
                      ExpansionTile(
                        title: Text(
                          'Otpadno staklo',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "staklena ambalaža, staklo",
                              textAlign: TextAlign.center,
                            ),
                          )])
,
                      ExpansionTile(
                        title: Text(
                          'Otpadna plastika',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "plastična ambalaža,plastika",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Otpadni tekstil',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "odjeća, tekstil",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Krupni (glomazni) otpad',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "glomazni otpad",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Jestiva ulja i masti',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "jestiva ulja i masti",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Boje',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "boje, tinte, ljepila i smole, koje nisu navedene pod 20 01 27*",
                              textAlign: TextAlign.center,
                            ),
                          )])
,
                      ExpansionTile(
                        title: Text(
                          'Deterdženti',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "deterdženti koji nisu navedeni pod 20 01 29*",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Lijekovi',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "lijekovi koji nisu navedeni pod 20 01 31*",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Baterije i akumulatori',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "baterije i akumulatori, koji nisu navedeni pod 20 01 33*",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Električna i elektronička oprema',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "odbačena električna i elektronička oprema, koja nije navedena pod 20 01 21*, 20 01 23* i 20 01 35*",
                              textAlign: TextAlign.center,
                            ),
                          )])
,
                      ExpansionTile(
                        title: Text(
                          'Građevni otpad iz kućanstva **',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "beton, cigle, crijep/pločice i keramika, kabelski vodiči koji nisu navedeni pod 17 04 10*, izolacijski materijali koji sadrže azbest, ostali izolacijski materijali, koji se sastoje ili sadrže opasne tvari, izolacijski materijali koji nisu navedeni pod 17 06 01* i 17 06 03*, građevinski materijali koji sadrže azbest, građevinski materijali na bazi gipsa onečišćeni opasnim tvarima, građevinski materijali na bazi gipsa koji nisu navedeni pod 17 08 01",
                              textAlign: TextAlign.center,
                            ),
                          )])

,
                      ExpansionTile(
                        title: Text(
                          'Ostalo',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "otpadni tiskarski toneri koji sadrže opasne tvari, otpadni tiskarski toneri koji nisu navedeni pod 08 03 17*, otpadne gume, oštri predmeti (osim 18 01 03*)",
                              textAlign: TextAlign.center,
                            ),
                          )])

                        ],),
                     

                  ])
      )],
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
