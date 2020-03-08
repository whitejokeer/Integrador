import 'package:anato/pages/aventura.dart';
import 'package:anato/pages/avistamiento.dart';
import 'package:anato/pages/home.dart';
import 'package:anato/pages/videPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:anato/pages/gastronomia.dart';
import 'package:anato/pages/eventos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: routes,
    );
  }
}

final routes = {
  '/': (BuildContext context) => new VideoScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/aventura': (BuildContext context) => new AventuraScreen(),
  '/gastronomia':(BuildContext context) => new GastronomiaMenu(),
  '/avistamiento':(BuildContext context) => new EspecieScreen(),
  '/eventos':(BuildContext context) => new EventosScreen(),
};
