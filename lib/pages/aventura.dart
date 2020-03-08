import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/cards.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';

class AventuraScreen extends StatefulWidget {
  @override
  _AventuraScreenState createState() => _AventuraScreenState();
}

class _AventuraScreenState extends State<AventuraScreen> {
  @override
  Widget build(BuildContext context) {
    double n = ((MediaQuery.of(context).size.height) / 6) - 10;
    return Scaffold(
        appBar: barApp3(context, 'Turismo de Aventura'),
        bottomNavigationBar: footer(context),
        body: ListView(
          children: <Widget>[
            cartaParques(context, 'assets/9167.png', "PARQUES", n),
            cartaDeportes(context, 'assets/Parapente.png', "PARAPENTE", n),
            cartaDeportes(context, "assets/bungee.png", "BUNGEE JUMPING", n),
            cartaDeportes(context, "assets/torrentismo.png", "TORRENTISMO", n),
            cartaDeportes(context, "assets/espeleismo.png", "ESPELEÍSMO", n),
            cartaDeportes(
                context, "assets/cabalgata.png", "CABALGATA ECOLOGICA", n),
            cartaDeportes(
                context, "assets/caminata.png", "CAMINATA ECOLOGICA", n),
            cartaDeportes(
                context, "assets/escalada.png", "ESCALADA BOULDER", n),
            cartaDeportes(context, "assets/rafting.png", "RAFTING", n),
            cartaDeportes(
                context, "assets/ciclomontana.png", "CICLOMONTAÑISMO", n),
          ],
        ));
  }
}
