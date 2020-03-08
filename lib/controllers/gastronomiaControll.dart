import 'package:anato/model/municipios.dart';
import 'package:anato/model/platos.dart';
import 'package:anato/model/restaurantes.dart';
import 'package:dio/dio.dart';
import 'package:anato/controllers/globals.dart' as global;

class RestGastroRequest {
  Future<List<Restaurante>> gastroRestautantes(Municipios municipio) async {
    try {
      Dio dio = new Dio();

      List<Restaurante> restaurant = [];

      dio.options.baseUrl = "${global.url}"; //url del servidor
      dio.options.connectTimeout = 5000; // 5 segundos
      dio.options.receiveTimeout = 5000; // 3 segundos

      Response restauranteGet = await dio.get(
          "/restaurantes?provincias.municipio=${municipio.id}"); // configuracion del endpoint

      var restauranteMap = restauranteGet.data;

      restauranteMap.forEach(
        (dataMap) async {
          final res = Restaurante.map(dataMap);
          restaurant.add(res);
        },
      );

      return restaurant;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Platos>> gastroPlatos(Municipios municipio) async {
    try {
      Dio dio = new Dio();

      List<Platos> platos = [];

      dio.options.baseUrl = "${global.url}"; //url del servidor
      dio.options.connectTimeout = 5000; // 5 segundos
      dio.options.receiveTimeout = 5000; // 3 segundos

      Response platosData = await dio.get(
          "/platos?municipios.id=${municipio.id}"); // configuracion del endpoint

      var platosMap = platosData.data;

      platosMap.forEach(
        (dataMap) async {
          List<Restaurante> restaurantePlatos = [];
          List<String> imagenes = [];
          dataMap['restaurantes'].forEach((res) async {
            print(res);
            restaurantePlatos.add(Restaurante.map(res));
          });
          dataMap['imagenes'].forEach((res) async {
            imagenes.add(res['Foto']);
          });
          platos.add(Platos.map(dataMap, imagenes, restaurantePlatos));
        },
      );
      print(platos);

      return platos;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
