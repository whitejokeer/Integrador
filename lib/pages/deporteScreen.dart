import 'package:anato/controllers/actividadesControll.dart';
import 'package:anato/database/db.dart';
import 'package:anato/model/itemsAgencia.dart';
import 'package:anato/model/municipios.dart';
import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:anato/pages/agencias.dart';
/* import 'package:anato/controllers/globals.dart' as global; */

Future<List<Municipios>> fetchMunicipiosFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Municipios>> municipios = dbHelper.fectchMunicipios();
  return municipios;
}

class DeporteScreen extends StatefulWidget {
  final String deporte, fondo;
  DeporteScreen({Key key, this.deporte, this.fondo}) : super(key: key);
  @override
  _DeporteScreenState createState() => _DeporteScreenState();
}

class _DeporteScreenState extends State<DeporteScreen> {
  String contrilador;
  List<Municipios> _municipios = [];
  Municipios municipio, aux;
  String controlador;
  List<ItemFinal> finales = [];
  RestPrincipalRequest rest = RestPrincipalRequest();

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
                      onPressed: () async {
                        finales = await rest.agencias(
                            widget.deporte, _municipios[index]);
                        setState(() {
                          municipio = _municipios[index];
                          controlador = _municipios[index].id;
                        });
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              "${_municipios[index].mapa}"),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(_municipios[index].nombre),
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
        appBar: barApp(context, widget.deporte, widget.fondo),
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
                      : Center(),
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
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            finales[index].nombreProvincias,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          new Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4 / 2,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: finales[index].agencias.length,
                                itemBuilder: (BuildContext context, int index2) {
                                  return finales[index].agencias.length != 0
                                      ? Center(
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: MaterialButton(
                                              padding: EdgeInsets.all(0.0),
                                              onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AgenciaScreen(
                                                    agencia: finales[index]
                                                        .agencias[index2],
                                                    fondo: widget.fondo,
                                                  ),
                                                ),
                                              ),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                child: Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: controlador == null
                                                            ? AssetImage(
                                                                "assets/principal.png")
                                                            : NetworkImage(
                                                                "${finales[index].agencias[index2].logo}"),
                                                        alignment:
                                                            Alignment.center,
                                                      ),
                                                    ),
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
                          ),
                          new Text(""),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: finales.length),
            )
          ],
        ),
      ),
    );
  }
}
