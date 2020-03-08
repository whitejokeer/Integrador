import 'package:anato/database/db.dart';
import 'package:anato/model/agenciasModel.dart';
import 'package:anato/model/itemsAgencia.dart';
import 'package:anato/model/municipios.dart';
import 'package:dio/dio.dart';
import 'package:anato/controllers/globals.dart' as global;

class RestPrincipalRequest {
  Future<bool> infoNecesaria() async {
    try {
      Dio dio = new Dio();
      var dba = new DatabaseHelper();
      String provincias = "";

      dio.options.baseUrl = "${global.url}"; //url del servidor
      dio.options.connectTimeout = 5000; // 5 segundos
      dio.options.receiveTimeout = 5000; // 3 segundos

      Response municipios =
          await dio.get("/municipios"); // configuracion del endpoint

      dba.deleteMunicipios();

      var municipiosMap =
          municipios.data; // Accedemos al manejo del json retornado

      municipiosMap.forEach((dataMap) async {
        provincias = "";

        dataMap['provincias'].forEach((prov) async {
          provincias = "$provincias|${prov['NombreProvincias']}";
        });
        final municipios = Municipios.map(dataMap, provincias);
        await dba.saveMunicipios(municipios);
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ItemFinal>> agencias(String deporte, Municipios municipio) async {
    try {
      Dio dio = new Dio();

      List<ItemFinal> items = [];
      List<String> provincias = [];

      dio.options.baseUrl = "${global.url}"; //url del servidor
      dio.options.connectTimeout = 5000; // 5 segundos
      dio.options.receiveTimeout = 5000; // 3 segundos

      Response agencias = await dio.get(
          "/agencias?deportes.NombreDeporte=$deporte&provincia.municipio=${municipio.id}"); // configuracion del endpoint

      var municipiosMap = agencias.data;

      provincias = municipio.provinciasL.replaceFirst('|', "").split("|");

      provincias.forEach(
        (element) async {
          List<Agencia> agenciasL = [];

          municipiosMap.forEach(
            (dataMap) async {
              if (dataMap['provincia']['NombreProvincias'] == element) {
                final agencias = Agencia.map(dataMap);
                agenciasL.add(agencias);
              }
            },
          );
          final it = ItemFinal.map(element.toString(), agenciasL);
          items.add(it);
        },
      );
      return items;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
