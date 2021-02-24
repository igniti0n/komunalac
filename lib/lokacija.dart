import 'package:flutter/material.dart';

class Lokacija extends StatefulWidget {
  createState() {
    return LokacijaState();
  }
}

class LokacijaState extends State<Lokacija> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokacija odlaganja'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/cistoca-logo.gif',
            ),
          ),
          Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10, left: 40, right: 40),
                    child: Center(
                      child: Text(
                        'Izaberite tip spremnika za prikaz lokacija i ' 'navigaciju.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ListTile(
            leading: Icon(Icons.location_searching),
            title: Text(
              'Miješani komunalni otpad',
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_searching),
            title: Text(
              'Staklena ambalaža',
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_searching),
            title: Text(
              'Plastika',
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_searching),
            title: Text(
              'Papir i karton',
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_searching),
            title: Text(
              'Metalna ambalaža',
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_searching),
            title: Text(
              'Mobilni spremnik',
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_searching),
            title: Text(
              'Reciklažno dvorište',
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
