import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/cards.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';

class ParquesMenu extends StatefulWidget {
  @override
  _ParquesMenuState createState() => _ParquesMenuState();
}

class _ParquesMenuState extends State<ParquesMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: barApp3(context, "Parques"),
        bottomNavigationBar: footer(context),
        body: ListView(
          physics: ScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            cartaParques2(context, "assets/Parque-del-Chicamocha-Agenda-in.png", "PARQUE NACIONAL DEL CHICAMOCHA", 150, "Parque Chicamocha"),
            SizedBox(
              height: 20.0,
            ),
            cartaParques2(context, "assets/cascada-de-juan.png", "PARQUE ECOLÓGICO CASCADAS DE JUAN CURI", 150, "Cascada Juan Curi"),
            SizedBox(
              height: 20.0,
            ),
            cartaParques2(context, "assets/serrania-yariguies.png", "PARQUE NACIONAL SERRANÍA DE LOS YARIGUÍES", 150, "Yariguíes"),
          ],
        ),
      ),
    );
  }
}
