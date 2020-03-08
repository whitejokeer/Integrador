import 'package:anato/controllers/gastronomiaControll.dart';
import 'package:anato/database/db.dart';
import 'package:anato/model/municipios.dart';
import 'package:anato/model/platos.dart';
import 'package:anato/model/restaurantes.dart';
import 'package:anato/pages/platosInfo.dart';
import 'package:anato/pages/restauranteInfo.dart';
import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
/* import 'package:anato/controllers/globals.dart' as global; */
import 'package:flutter/rendering.dart';

Future<List<Municipios>> fetchMunicipiosFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Municipios>> municipios = dbHelper.fectchMunicipios();
  return municipios;
}

class GastronomiaMenu extends StatefulWidget {
  @override
  _GastronomiaMenuState createState() => _GastronomiaMenuState();
}

class _GastronomiaMenuState extends State<GastronomiaMenu> {
  String contrilador;
  List<Municipios> _municipios = [];
  Municipios municipio;
  String controlador;
  List<Restaurante> finalres = [];
  List<Platos> finalplat = [];
  RestGastroRequest rest = RestGastroRequest();

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
                  "Provincia",
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
                        finalres =
                            await rest.gastroRestautantes(_municipios[index]);
                        finalplat = await rest.gastroPlatos(_municipios[index]);
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
                            backgroundImage: NetworkImage(
                                "${_municipios[index].mapa}"),
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
        appBar: barApp3(context, "Turismo Gastronómico"),
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
                        controlador == null ? "Provincia" : municipio.nombre,
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
                          "Platos Tipicos",
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
                      child: MaterialButton(
                        padding: EdgeInsets.all(0.0),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlatosInfo(
                              platos: finalplat[index],
                            ),
                          ),
                        ),
                        child: Card(
                          margin: EdgeInsets.all(0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                    "${finalplat[index].fotos[0]}"),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text(finalplat[index].nombre),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }, childCount: finalplat.length),
            ),
            SliverFixedExtentList(
              itemExtent: controlador != null ? 50 : 1,
              delegate: SliverChildListDelegate([
                Container(
                    child: Center(
                  child: controlador != null
                      ? Text(
                          "Restaurantes",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Center(),
                ))
              ]),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return MaterialButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestauranteScreen(
                              restaurante: finalres[index],
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
                                "${finalres[index].logo}"),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }, childCount: finalres.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 4 / 2),
            ),
          ],
        ),
      ),
    );
  }
}
