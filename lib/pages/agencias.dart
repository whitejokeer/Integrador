import 'package:anato/model/agenciasModel.dart';
import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AgenciaScreen extends StatefulWidget {
  final Agencia agencia;
  final String fondo;
  AgenciaScreen({Key key, this.agencia, this.fondo}) : super(key: key);
  @override
  _AgenciaScreenState createState() => _AgenciaScreenState();
}

class _AgenciaScreenState extends State<AgenciaScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: barApp(context, widget.agencia.nombre, widget.fondo),
      bottomNavigationBar: footer(context),
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: MediaQuery.of(context).size.width - 150,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${widget.agencia.logo}"),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Text(
              "DESCRIPCION:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Text(
              widget.agencia.descripcion,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Text(
              "CONTACTANOS:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          widget.agencia.correo != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: MaterialButton(
                    onPressed: () => launch('mailto:${widget.agencia.correo}?subject=SiempreSantander'),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset("assets/mail.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text(widget.agencia.correo),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(),
          widget.agencia.telefono != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                  child: MaterialButton(
                    onPressed: () =>
                        launch('whatsapp://send?phone=57${widget.agencia.telefono}'),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset("assets/whatsapp.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text('+57 ${widget.agencia.telefono}'),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(),
          widget.agencia.web != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                  child: MaterialButton(
                    onPressed: () => launch('http:${widget.agencia.web.toString().replaceAll('https://', '').replaceAll("http://", 'replace')}'),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset("assets/internet.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text("Pagina Oficial",
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(),
          widget.agencia.maps != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                  child: MaterialButton(
                    onPressed: () => launch('http:${widget.agencia.maps}'),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset("assets/pin.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text('Como llegar?'),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(),
        ],
      ),
    ));
  }
}
