import 'package:anato/controllers/avistamientoControll.dart';
import 'package:anato/database/db.dart';
import 'package:anato/model/municipios.dart';
import 'package:anato/model/pajaro.dart';
import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
/* import 'package:anato/controllers/globals.dart' as global; */
import 'package:flutter/rendering.dart';
import 'package:anato/pages/especiesInfo.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<Municipios>> fetchMunicipiosFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Municipios>> municipios = dbHelper.fectchMunicipios();
  return municipios;
}

class EspecieScreen extends StatefulWidget {
  @override
  _EspecieScreenState createState() => _EspecieScreenState();
}

class _EspecieScreenState extends State<EspecieScreen> {
  List<Municipios> _municipios = [];
  Municipios municipio;
  String controlador;
  List<Especies> finalesp = [];
  RestAvistamientoRequest rest = RestAvistamientoRequest();

  getData() async {
    var uni = await fetchMunicipiosFromDatabase();
    setState(() {
      _municipios = uni;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  modal() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: 400,
          width: 300,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(12.0),
                    topRight: const Radius.circular(12.0),
                  ),
                ),
                child: Text(
                  "Provincias",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 350,
                width: 300,
                child: ListView.builder(
                  itemCount: _municipios.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return MaterialButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () async {
                        finalesp =
                            await rest.avistamientoParque(_municipios[index]);
                        print(finalesp);
                        setState(() {
                          municipio = _municipios[index];
                          controlador = _municipios[index].id;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage("${_municipios[index].mapa}"),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(_municipios[index].nombre),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /* backgroundColor: Colors.white.withOpacity(0.98), */
        appBar: barApp3(context, "Turismo Avistamiento"),
        bottomNavigationBar: footer(context),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MaterialButton(
                      onPressed: () => modal(),
                      child: Text(
                        controlador == null ? "Provincias" : municipio.nombre,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => modal(),
                    child: Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: controlador == null
                              ? AssetImage("assets/principal.png")
                              : NetworkImage("${municipio.mapa}"),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  controlador == null
                      ? Text(
                          "Instrucciones",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Center(
                          child: Text(
                          "Especies",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  SizedBox(
                    height: 10,
                  ),
                  controlador == null
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Seleccione la provincia a consultar oprimiendo el mapa anterior",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Center(),
                ],
              ),
            ),
            //Inicio Lista Platos
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      child: Card(
                        margin: EdgeInsets.all(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                    "${finalesp[index].imagenPrincipal}"),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text(
                                finalesp[index].nombre,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: finalesp[index].sonido != null
                                  ? finalesp[index].sonido != ""
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.volume_up,
                                            color: Colors.black,
                                          ),
                                          onPressed: () => launch(
                                              "${finalesp[index].sonido}"))
                                      : IconButton(
                                          icon: Icon(
                                            Icons.volume_up,
                                          ),
                                          onPressed: () {},
                                        )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.volume_up,
                                      ),
                                      onPressed: () {},
                                    )),
                        ),
                      ),
                    ),
                  ),
                );
              }, childCount: finalesp.length),
            ),
          ],
        ),
      ),
    );
  }
}
