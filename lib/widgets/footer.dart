import 'package:flutter/material.dart';

Widget footer(BuildContext context) {
  return BottomAppBar(
    elevation: 0,
    color: Colors.white,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height:50,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/LogoDepartamento.png"),
              alignment: Alignment.center,
            ),
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/LogoSantander.png"),
              alignment: Alignment.center,
            ),
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/LogoKory.png"),
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    ),
  );
}
