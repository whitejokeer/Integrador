import 'package:anato/model/restaurantes.dart';

class Platos {
  String nombre, ingredientes, preparacion;
  List<Restaurante> restaurantes;
  List<String> fotos;

  Platos.map(Map<String, dynamic> parsedJson, List<String> imagenesL, List<Restaurante> restaurantesL)
      : nombre = parsedJson['NombrePlato'],
        ingredientes = parsedJson['Ingredientes'],
        preparacion = parsedJson['Preparacion'],
        restaurantes = restaurantesL,
        fotos = imagenesL;
}
