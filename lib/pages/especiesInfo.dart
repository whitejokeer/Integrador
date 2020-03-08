import 'package:anato/model/pajaro.dart';
import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
/* import 'package:anato/controllers/globals.dart' as global; */
import 'package:url_launcher/url_launcher.dart';

class EspeciesInfo extends StatefulWidget {
  final Especies especie;
  EspeciesInfo({Key key, this.especie}) : super(key: key);
  @override
  _EspeciesInfoState createState() => _EspeciesInfoState();
}

class _EspeciesInfoState extends State<EspeciesInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: barApp4(context, widget.especie.nombre),
        bottomNavigationBar: footer(context),
        body: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "${widget.especie.imagenIzquierda}"),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "${widget.especie.imagenPrincipal}"),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "${widget.especie.imagenDerecha}"),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Descripcion:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                IconButton(icon: Icon(Icons.volume_up), onPressed: () => launch("${widget.especie.sonido}"))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Text(
                widget.especie.descripcion,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
