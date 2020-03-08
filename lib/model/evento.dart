import 'package:anato/model/actividades.dart';

class Evento {
  String nombreEvento, provincia;
  List<Actividades> actividades;
  int actividadesn;

  Evento.map(Map<String, dynamic> parsedJson, List<Actividades> actividaddesL, int actividadesN)
      : nombreEvento = parsedJson['NombreEvento'],
        provincia = parsedJson['provincia']['NombreProvincias'],
        actividades = actividaddesL,
        actividadesn = actividadesN;
}
