import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Racun extends StatelessWidget {
  String selectedUrl = "";

  // GET SVG
  static final String assetName = 'images/maskota-placa-odjeca.svg';
  final Widget svgIcon =
      new SvgPicture.asset(assetName, semanticsLabel: 'Maskota', height: 350);

  static final String assetNameNew = 'images/oblak-prazan.svg';
  final Widget chatImage = new SvgPicture.asset(
    assetNameNew,
    semanticsLabel: 'chat',
    width: 190,
  );

  String _message = "Friško s place";

//GET MESSAGE
  Widget getMessage() {
    var message = Positioned(
      left: 108,
      top: 55,
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

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Racun({@required this.selectedUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 50),
      child: Stack(
        children: <Widget>[
          Container(
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.green),
                borderRadius: BorderRadius.only(
                  topLeft: (Radius.circular(5.0)),
                  topRight: (Radius.circular(5.0)),
                  bottomLeft: (Radius.circular(5.0)),
                  bottomRight: (Radius.circular(5.0)),
                ),
              ),
              margin: EdgeInsets.only(left: 5, top: 5, right: 5),
              child: WebviewScaffold(
                url: selectedUrl,
                withJavascript: true,
                withZoom: true,
                appBar: AppBar(
                    backgroundColor: new Color.fromARGB(255, 0, 142, 90),
                    /*leading: Icon(
                  Icons.bookmark,
                  size: 20,
                  color: Colors.white,
                ),*/
                    title: Text("Pregled računa (zoom)"),
                    elevation: 1),
              )

              /*WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          
          

          
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
              )*/

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
    ));
  }
}
/*




class FriskoState extends State<Frisko> {

 WebViewController _webViewController;
      
 void reloadWebView() {
    _webViewController?.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment(-1.07, 0),
              child: Image.asset(
                'images/maskota-placa-odjeca.png',
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
               decoration: new BoxDecoration(
              border: new Border.all(color: Colors.green),
              borderRadius: BorderRadius.only(
                topLeft: (Radius.circular(5.0)),
                topRight: (Radius.circular(5.0)),
                bottomLeft: (Radius.circular(5.0)),
                bottomRight: (Radius.circular(5.0)),
              ),
            ),
              margin: EdgeInsets.only(left: 145, top: 150, right: 5),
           
               
              child: WebView(
                initialUrl: "https://komunalci.eu/crikvenica-api/plac.html",
                onWebViewCreated: (controller) {
        _webViewController = controller;
      },
              )
              
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
*/
