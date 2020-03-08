import 'package:anato/model/parque.dart';
import 'package:dio/dio.dart';
import 'package:anato/controllers/globals.dart' as global;

class RestParqueRequest {
  Future<Parque> infoParque(String nombre) async {
    try {
      Dio dio = new Dio();
      Parque item;
      List<String> fotos = [];

      dio.options.baseUrl = "${global.url}"; //url del servidor
      dio.options.connectTimeout = 5000; // 5 segundos
      dio.options.receiveTimeout = 5000; // 3 segundos

      Response agencias = await dio
          .get("/parques?NombreParque=$nombre"); // configuracion del endpoint

      var parqueMap = agencias.data;

      parqueMap[0]['ImagenMultiple'].forEach((foto) {
        fotos.add(foto['Foto']);
      });

      item = Parque.map(parqueMap[0], fotos);

      return item;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
