
import 'package:anato/model/restaurantes.dart';
import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
/* import 'package:anato/controllers/globals.dart' as global; */
import 'package:url_launcher/url_launcher.dart';

class RestauranteScreen extends StatefulWidget {
  final Restaurante restaurante;
  RestauranteScreen({Key key, this.restaurante}) : super(key: key);
  @override
  _RestauranteScreenState createState() => _RestauranteScreenState();
}

class _RestauranteScreenState extends State<RestauranteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: barApp3(context, widget.restaurante.nombre),
      bottomNavigationBar: footer(context),
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                height: MediaQuery.of(context).size.width - 150,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${widget.restaurante.logo}"),
                    alignment: Alignment.center,
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
              widget.restaurante.descripcion,
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
          widget.restaurante.correo != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: MaterialButton(
                    onPressed: () => launch('mailto:${widget.restaurante.correo}?subject=SiempreSantander'),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset("assets/mail.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text(widget.restaurante.correo),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(),
          widget.restaurante.telefono != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                  child: MaterialButton(
                    onPressed: () =>
                        launch('whatsapp://send?phone=57${widget.restaurante.telefono}'),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset("assets/whatsapp.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text('+57 ${widget.restaurante.telefono}'),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(),
          widget.restaurante.web != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                  child: MaterialButton(
                    onPressed: () => launch('http:${widget.restaurante.web}'),
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
          widget.restaurante.maps != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                  child: MaterialButton(
                    onPressed: () => launch('http:${widget.restaurante.maps}'),
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
