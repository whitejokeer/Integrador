import 'package:anato/controllers/eventoControll.dart';
import 'package:anato/database/db.dart';
import 'package:anato/model/municipios.dart';
import 'package:anato/model/itemEvento.dart';
import 'package:anato/widgets/appbar.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
/* import 'package:anato/controllers/globals.dart' as global; */
import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';


Future<List<Municipios>> fetchMunicipiosFromDatabase() async {
  var dbHelper = DatabaseHelper();
  Future<List<Municipios>> municipios = dbHelper.fectchMunicipios();
  return municipios;
}

class EventosScreen extends StatefulWidget {
  @override
  _EventosScreenState createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  List<Municipios> _municipios = [];
  Municipios municipio;
  String controlador;
  List<ItemEvento> finalesp = [];
  List<dynamic> _selectedEvents;
  RestEventoRequest rest = RestEventoRequest();
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _eventos;

  getData() async {
    var uni = await fetchMunicipiosFromDatabase();
    setState(() {
      _municipios = uni;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _selectedEvents = [];
    _eventos = {};
    getData();
  }

  Future getData2() async {
    _eventos = {};
    for (var i = 0; i < finalesp.length; i++) {
      var finalesp2 = finalesp[i].toMap();
      _eventos[finalesp2['fecha']] = finalesp2['evento'];
    }
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
                        finalesp =
                            await rest.avistamientoParque(_municipios[index]);
                        await getData2();
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
        appBar: barApp3(context, "Eventos"),
        bottomNavigationBar: footer(context),
        body: ListView(
          children: <Widget>[
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
                    "Eventos",
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
            SizedBox(
              height: 30,
            ),
            finalesp.isEmpty
                ? Center()
                : TableCalendar(
                    availableGestures: AvailableGestures.horizontalSwipe,
                    events: _eventos,
                    calendarController: _controller,
                    calendarStyle: CalendarStyle(
                      todayColor: Colors.orange,
                      selectedColor: Colors.grey[400],
                      selectedStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      todayStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    onDaySelected: (date, events) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                  ),
            ..._selectedEvents.map((evento) => Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          evento.provincia,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right:5.0),
                              child: MyBullet(),
                            ),
                            Text(
                              evento.nombreEvento,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: evento.actividadesn,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 50.0),
                                        child: Text(
                                          evento.actividades[index]
                                              .nombreActividad,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 30.0),
                                        child: Text(
                                          '${evento.actividades[index].hora.toString().replaceAll(':00.000', '')}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 50.0),
                                    child: Text(
                                      evento.actividades[index].ubicacion,
                                      style: TextStyle(
                                        color: Colors.grey,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 50.0,
            )
            //Inicio Lista Platoonds
          ],
        ),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 10.0,
      width: 10.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
