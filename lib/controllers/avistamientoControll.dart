import 'package:anato/model/municipios.dart';
import 'package:anato/model/pajaro.dart';
import 'package:dio/dio.dart';
import 'package:anato/controllers/globals.dart' as global;

class RestAvistamientoRequest {
  Future<List<Especies>> avistamientoParque(Municipios municipios) async {
    try {
      Dio dio = new Dio();
      List<Especies> item = [];

      dio.options.baseUrl = "${global.url}"; //url del servidor
      dio.options.connectTimeout = 5000; // 5 segundos
      dio.options.receiveTimeout = 5000; // 3 segundos

      Response especie = await dio
          .get("/especies?municipios.id=${municipios.id}"); // configuracion del endpoint

      var especiesMap = especie.data;
      print(especiesMap);

      especiesMap.forEach((dt) {
        item.add(Especies.map(dt));
      });

      return item;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
