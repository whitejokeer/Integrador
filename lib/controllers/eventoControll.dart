import 'package:anato/model/municipios.dart';
import 'package:dio/dio.dart';
import 'package:anato/controllers/globals.dart' as global;
import 'package:anato/model/itemEvento.dart';
import 'package:anato/model/actividades.dart';
import 'package:anato/model/evento.dart';

class RestEventoRequest {
  Future<List<ItemEvento>> avistamientoParque(Municipios municipios) async {
    try {
      Dio dio = new Dio();
      List<ItemEvento> item = [];

      dio.options.baseUrl = "${global.url}"; //url del servidor
      dio.options.connectTimeout = 5000; // 5 segundos
      dio.options.receiveTimeout = 5000; // 3 segundos

      Response evento = await dio.get(
          "/eventos?provincia.municipio=${municipios.id}"); // configuracion del endpoint

      var eventoMap = evento.data;
      print(eventoMap);

      eventoMap.forEach((dt) {
        List<Actividades> act = [];
        int contador = 0;
        dt['Actividades'].forEach((actividad) {
          act.add(Actividades.map(actividad));
          contador = contador + 1;
        });
        List<Evento> eventoL = [];
        Evento evento = Evento.map(dt, act, contador);
        eventoL.add(evento);
        item.add(ItemEvento.map(dt, eventoL));
      });

      return item;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
