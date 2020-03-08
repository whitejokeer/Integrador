import 'package:anato/pages/deporteScreen.dart';
import 'package:anato/pages/parques.dart';
import 'package:flutter/material.dart';
import 'package:anato/pages/parquesInfo.dart';

Widget cartaP(BuildContext context, String fondo, String titulo, double tamano,
    String direccion) {
  return Container(
    height: tamano,
    width: double.maxFinite,
    child: MaterialButton(
      onPressed: () => Navigator.pushNamed(context, direccion),
      child: Card(
        elevation: 5,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(fondo),
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Text(
                titulo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget cartaDeportes(
    BuildContext context, String fondo, String titulo, double tamano) {
  return Container(
    height: tamano,
    width: double.maxFinite,
    child: MaterialButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeporteScreen(
            deporte: titulo,
            fondo: fondo,
          ),
        ),
      ),
      child: Card(
        elevation: 5,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(fondo),
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Text(
                titulo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget cartaParques(
    BuildContext context, String fondo, String titulo, double tamano) {
  return Container(
    height: tamano,
    width: double.maxFinite,
    child: MaterialButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParquesMenu(
          ),
        ),
      ),
      child: Card(
        elevation: 5,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(fondo),
              fit: BoxFit.fill,
              alignment: Alignment.center,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Text(
                titulo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget cartaParques2(
    BuildContext context, String fondo, String titulo, double tamano, String abreviado) {
  return Container(
    height: tamano,
    width: double.maxFinite,
    child: MaterialButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParquesInfo(
            nombre: abreviado
          ),
        ),
      ),
      child: Card(
        elevation: 5,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(fondo),
              fit: BoxFit.fill,
              alignment: Alignment.center,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
