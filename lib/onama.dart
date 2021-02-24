import 'package:flutter/material.dart';

class Cistoca extends StatefulWidget {
  createState() {
    return CistocaState();
  }
}

class CistocaState extends State<Cistoca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          //  Container(
          //     padding: EdgeInsets.only(left: 22.0, right: 22.0),
          //     child: Image.asset(
          //       'images/cistoca-logo.gif',
          //     ),
          //   ),
          //   Container(
          //     padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
          //     child: Image.asset(
          //       'images/o-nama.jpg',

          //     ),
          //   ),

          Container(
            padding: EdgeInsets.all(22.0),
            child: Card(
                child: Padding(
              padding: EdgeInsets.all(22.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: new Image.asset(
                      'images/logo.png',
                    ),
                  ),
                  Text(
                      'Eko-Murvica d.o.o. pruža široki spektar profesionalnih usluga i radova iz područja komunalnih djelatnosti, kao što su sakupljanje i odvoz otpada, sudjelovanje u procesu oporabe i zbrinjavanja otpada, održavanje gradskih parkova i javnih površina, upravljanje javnim parkiralištima, grobljima, tržnicom i gradskom športskom dvoranom, osobito vodeći računa o zadovoljstvu korisnika, kvaliteti usluga, zaštiti okoliša, društvenoj odgovornosti, održivom razvoju i obvezama koje ima kao gradsko komunalno trgovačko društvo Grada Crikvenice.\n',
                      softWrap: true),
                  Text(
                      'Eko - Murvica d.o.o. nastala je podjelom nekadašnje GKTD Murvice d.o.o. i, kao sveopći pravni sljednik, preuzela je sve djelatnosti osim održavanja sanitarne i oborinske odvodnje. Odvajanje se moralo napraviti zbog odredbi Zakona o vodama koje zahtijevaju da tvrtka koja se bavi odvodnjom (tzv. vodne usluge") ne obavlja niti jednu drugu komunalnu ili komercijalnu djelatnost. EKO - MURVICA d.o.o., Trg Stjepana Radića 1/II tel: 051/455-500, fax: 051/241-060 e-pošta: ekomurvica@ekomurvica.hr IBAN: HR4724020061100701735 SWIFT adresa (BIC): ESBCHR22 OIB: 58401982639 PB: 4222300 PDV identifikacijski broj: HR58401982639. Upisan kod Trgovačkog suda u Rijeci pod brojem - MBS 040325655, temeljni kapital: 21.151.700,00 kn, uplaćen u cijelosti. Uprava: Lovorko Gržac ing., direktor \n'),
                  /*    Text(
                      'EKO - MURVICA d.o.o., Trg Stjepana Radića 1/II\n \ntel: 051/455-500, \nfax: 051/241-060 \ne-pošta: ekomurvica@ekomurvica.hr\n'
                      'IBAN: HR4724020061100701735\nSWIFT adresa (BIC): ESBCHR22\nOIB: 58401982639\nPB: 4222300\n'
                      'PDV identifikacijski broj:HR58401982639\n'),
                  Text(
                      'Upisan kod Trgovačkog suda u Rijeci pod brojem - MBS 040325655,\n'
                      'temeljni kapital: 21.151.700,00 kn, uplaćen u cijelosti.'),
                  Text(
                    '\nUprava: Lovorko Gržac ing., direktor',
                    textAlign: TextAlign.left,
                  ),*/
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
