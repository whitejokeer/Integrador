import 'package:anato/model/platos.dart';
import 'package:anato/pages/restauranteInfo.dart';
import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
/* import 'package:anato/controllers/globals.dart' as global; */
import 'package:carousel_slider/carousel_slider.dart';

class PlatosInfo extends StatefulWidget {
  final Platos platos;
  PlatosInfo({Key key, this.platos}) : super(key: key);
  @override
  _PlatosInfoState createState() => _PlatosInfoState();
}

class _PlatosInfoState extends State<PlatosInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: barApp4(context, widget.platos.nombre),
        bottomNavigationBar: footer(context),
        body: ListView(
          children: <Widget>[
            CarouselSlider(
              items: widget.platos.fotos.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          height: MediaQuery.of(context).size.width - 150,
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("$i"),
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                "INGREDIENTES:",
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
                widget.platos.ingredientes,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                "PREPARACION:",
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
                widget.platos.preparacion,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                "Restaurantes:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 2,
                  mainAxisSpacing: 10,
                ),
                itemCount: widget.platos.restaurantes.length,
                itemBuilder: (BuildContext context, int index2) {
                  return widget.platos.restaurantes.length != 0
                      ? MaterialButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestauranteScreen(
                              restaurante: widget.platos.restaurantes[index2],
                            ),
                          ),
                        ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "${widget.platos.restaurantes[index2].logo}"),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                      : Center();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
