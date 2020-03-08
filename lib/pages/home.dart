import 'package:anato/widgets/cards.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double n = 150;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/LogoS.png"),
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          title: Text(
            "CATEGORIAS",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
        bottomNavigationBar: footer(context),
        body: ListView(
          children: <Widget>[
            cartaP(context, "assets/BungeeJumping.jpg", "Turismo de Aventura",
                n, "/aventura"),
            cartaP(context, "assets/mute.png", "Turismo Gastronómico", n,
                "/gastronomia"),
            cartaP(context, "assets/avistamiento.png",
                "Turismo de Avistamiento", n, "/avistamiento"),
            cartaP(context, "assets/fireworks-1885571_1920.png", "Eventos", n,
                "/eventos"),
          ],
        ));
  }
}
