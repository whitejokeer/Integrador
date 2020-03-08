import 'package:flutter/material.dart';
import 'package:anato/controllers/globals.dart' as global;

Widget barApp(BuildContext context, String titulo, String fondo) {
  return AppBar(
    elevation: 10,
    backgroundColor: Colors.transparent,
    flexibleSpace: Image(
      image: AssetImage(fondo),
      fit: BoxFit.cover,
    ),
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(left: 0.0),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios, /* 
              color: Colors.black, */
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    title: Text(
      titulo,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    ),
  );
}

Widget barApp2(BuildContext context, String titulo, String fondo) {
  return AppBar(
    elevation: 10,
    backgroundColor: Colors.transparent,
    flexibleSpace: Image(
      image: NetworkImage('${global.url}$fondo'),
      fit: BoxFit.cover,
    ),
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(left: 0.0),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios, /* 
              color: Colors.black, */
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    title: Text(
      titulo,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    ),
  );
}

Widget barApp3(BuildContext context, String titulo) {
  return AppBar(
    elevation: 10,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(left: 0.0),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    title: Text(
      titulo,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    ),
  );
}

Widget barApp4(BuildContext context, String titulo) {
  return AppBar(
    elevation: 10,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(left: 0.0),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    title: Text(
      titulo,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
