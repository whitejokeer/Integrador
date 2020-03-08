import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:anato/controllers/parquesControll.dart';
import 'package:anato/model/parque.dart';
/* import 'package:anato/controllers/globals.dart' as global; */
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class ParquesInfo extends StatefulWidget {
  final String nombre;
  ParquesInfo({Key key, this.nombre}) : super(key: key);
  @override
  _ParquesInfoState createState() => _ParquesInfoState();
}

class _ParquesInfoState extends State<ParquesInfo> {
  bool listo = false;
  Parque info;
  RestParqueRequest rest = RestParqueRequest();

  getData() async {
    await rest.infoParque(widget.nombre).then((value) {
      print("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(value);
      setState(() {
        info = value;
        listo = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: barApp4(context, widget.nombre),
      bottomNavigationBar: footer(context),
      body: listo
          ? ListView(
              children: <Widget>[
                info.imagenes != null
                    ? CarouselSlider(
                        items: info.imagenes.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.width - 150,
                                    width:
                                        MediaQuery.of(context).size.width - 50,
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
                      )
                    : Center(),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Text(
                    info.descripcion,
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    "HORARIO:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Text(
                    info.horario,
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                  ),
                ),
                info.tarifas != ""
                    ? Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Text(
                          "TARIFAS:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : Center(),
                info.tarifas != ""
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: Text(
                          info.tarifas,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                      )
                    : Center(),
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
                info.correo != ""
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                        child: MaterialButton(
                          onPressed: () => launch('message:${info.correo}'),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Image.asset("assets/mail.png"),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 0.0),
                                child: Text(info.correo),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(),
                info.telefono != ""
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                        child: MaterialButton(
                          onPressed: () => launch(
                              'whatsapp://send?phone=57${info.telefono}'),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Image.asset("assets/whatsapp.png"),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 0.0),
                                child: Text('+57 ${info.telefono}'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(),
                info.web != ""
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                        child: MaterialButton(
                          onPressed: () => launch('http:${info.web}'),
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
                info.maps != ""
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                        child: MaterialButton(
                          onPressed: () => launch('http:${info.maps}'),
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    ));
  }
}
