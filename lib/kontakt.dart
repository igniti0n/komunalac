import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Kontakt extends StatefulWidget {
  createState() {
    return KontaktState();
  }
}

class KontaktState extends State<Kontakt> {
  _launchMail() async {
    var url = 'mailto:ekomurvica@ekomurvica.hr';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallGosp() async {
    const url = "tel:+38551781177";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerGroblje() async {
    const url = "tel:+385912410609";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerDirektor() async {
    const url = "tel:+38551455500";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerJelcic() async {
    const url = "tel:+385912420607";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerPavlovic() async {
    const url = "tel:+385912420647";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerBaza() async {
    const url = "tel:+385912420644";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerSportski() async {
    const url = "tel:+385912166663";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerTrznica() async {
    const url = "tel:+385912420640";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerZelene() async {
    const url = "tel:+385912420605";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerOtpad() async {
    const url = "tel:+385912420624";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchcallerPark() async {
    const url = "tel:+385912420611";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(22.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              padding: EdgeInsets.only(bottom: 20),
              children: <Widget>[
                // Container(
                //   child: Image.asset(
                //     'images/cistoca-logo.gif',
                //   ),
                // ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Kontakt informacije',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(
                        'Uredovno radno vrijeme za prijem stranaka',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Adresa:\nTrg Stjepana Radića 1/II, 51260 Crikvenica\n\nRadno vrijeme:\nsvakim radnim danom\n(od ponedjeljka do petka) \nod 07:00 do 15:00'),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(
                        'Radno vrijeme blagajne',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Adresa:\nUlica braće Brozičević bb, 51260 Crikvenica\n\nZimsko radno vrijeme\n(od 16. rujna do 15. lipnja):\n-ponedjeljak, srijeda, četvrtak i petak od 7:30 do 14:00 sati (stanka od 10:00 do 10:30)\n\nLjetno radno vrijeme\n(od 16. lipnja do 15.rujna):\n- od ponedjeljka do petka od 07:30 do 13:00 sati\n- subota od 8:00 do 12:00 sati'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Dežurna služba gospodarenje otpadom',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Radno vrijeme:\t00-24 sata\nAdresa: \tVinodolska bb\n\Telefon:\t051/781-177'),
                      onTap: _launchcallGosp,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Dežurna služba groblje',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Radno vrijeme:\t00-24 sata\nTelefon:\t091/241-0609\n\t\t091/242-0635'),
                      onTap: _launchcallerGroblje,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Direktor',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Lovorko Gržac, ing.\ntel: 051/455-500'),
                      onTap: _launchcallerDirektor,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Pomoćnik direktora za operativne poslove',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Mario Jelčić, ing.\nmob:: 091/242-0607'),
                      onTap: _launchcallerJelcic,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Pomoćnik direktora za opće poslove',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                          Text('Jug Pavlović, dipl.oec.\nmob: 091/242-0647'),
                      onTap: _launchcallerPavlovic,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Odjel financija',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Kontakt osoba: \nJug Pavlović, dipl.oec.\nmob: 091/242-0647'),
                      onTap: _launchcallerPavlovic,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Održavanje baze korisnika',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Kontakt osoba:\nDijana Rajačić, \nVoditeljica odjela održavanje baze korisnika i kontrolu usluge korisnicima\nmob:091/242-0644\nemail:\ndijana.rajacic@ekomurvica.hr'),
                      onTap: _launchcallerBaza,
                    ),
                    /* ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Sportski centar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('E-mail:sdvorana@ekomurvica.hr\n\nKontakt osobe:\nSenko Smoljan, Voditelj odjela tržnica, groblja, sportski centar\nmob:091/242-0604\nemail:senko.smoljan@ekomurvica.hr\nDalibor Latin, Voditelj sportskog centra\nmob:091/216-6663\nemail:dalibor.latin@ekomurvica.hr'),
                      onTap: _launchcallerSportski(),
                    ),*/
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Sportski centar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'E-mail:\nsdvorana@ekomurvica.hr\n\nKontakt osobe:\nSenko Smoljan, \nVoditelj odjela tržnica, groblja, sportski centar\nmob:091/242-0604\ne-mail:\nsenko.smoljan@ekomurvica.hr\n\nDalibor Latin, \nVoditelj sportskog centra\nmob:091/216-6663\nemail:\ndalibor.latin@ekomurvica.hr'),
                      onTap: _launchcallerSportski,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Tržnica',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'E-mail, trznica@ekomurvica.hr\nTelefon:091/242-0610\n\nKontakt osobe:\nSenko Smoljan, \nVoditelj odjela tržnica, groblja, sportski centar\nmob:091/242-0604\ne-mail:\nsenko.smoljan@ekomurvica.hr\n\nZlatan Handanagić, \nKoordinator tržnice i groblja\nmob:091/242-0640\ne-mail:\nzlatan.handanagic@ekomurvica.hr'),
                      onTap: _launchcallerTrznica,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Groblja',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'E-mail:	groblja@ekomurvica.hr\n\nKontakt osobe:\nSenko Smoljan, \nVoditelj odjela tržnica, groblja, sportski centar\nmob:091/242-0604\ne-mail:\nsenko.smoljan@ekomurvica.hr\n\nSabina Erdemović, \nReferentica za izdavanje rješenja i grobljansku evidenciju\nmob:091/241-0602\ne-mail:\nsabina.erdemovic@ekomurvica.hr\n\nZlatan Handanagić, \nKoordinator tržnice i groblja\nmob:091/242-0640\ne-mail:\nzlatan.handanagic@ekomurvica.hr\n\nGroblje Crikvenica:\nLjubomir Lastrić\nmob:091/241-0611\n\nGroblje Jadranovo:\nDarko Jovanović\nmob:091/242-0635\n\nGroblje Dramalj:\nDragan Domijan\nmob:091/241-0623\n\nGroblje Selce:\nDominko Jezidžić\nmob:091/241-0609 '),
                      onTap: _launchcallerTrznica,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Održavanje zelenih i javnih površina',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'E-mail:parkovi@ekomurvica.hr\n\nKontakt osobe:\nLjiljana Vegrin, \nVoditeljica odjela Održavanje zelenih i javnih površina\nmob:091/241-0604\ne-mail:\nljiljana.vegrin@ekomurvica.hr\n\nTea Gagro, \nPomoćnica voditeljice odjela\nmob:091/242-0605\ne-mail:	tea.gagro@ekomurvica.hr'),
                      onTap: _launchcallerZelene,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Gospodarenje otpadom',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'E-mail:	gospodarenjeotpadom@ekomurvica.hr\n\nKontakt osobe:		\nRanko Brnčić, \nVoditelj odjela gospodarenje otpadom\nmob:	091/241-0603\ne-mail:	ranko.brncic@ekomurvica.hr\n\nDario Butković,\nPoslovođa odjela gospodarenje otpadom\nmob:	091/241-0624\ne-mail:\ndario.butkovic@ekomurvica.hr'),
                      onTap: _launchcallerOtpad,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        'Parkiralište',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'E-mail:	parkiraliste@ekomurvica.hr\n\nKontakt osobe:		\nDražen Maričić, \nVoditelj odjela promet u mirovanju, vozni park i plaža\nmob:	091/242-0636\ne-mail:	\ndrazen.maricic@ekomurvica.hr\n\nGoran Kostrenčić, \nPoslovođa parkirališta\nmob:	091/242-0611'),
                      onTap: _launchcallerPark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
