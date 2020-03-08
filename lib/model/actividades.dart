class Actividades {
  String nombreActividad, ubicacion, hora;
  Actividades.map(Map<String, dynamic> parsedJson)
      : nombreActividad = parsedJson['NombreActividad'],
        hora = parsedJson['HoraActividad'],
        ubicacion = parsedJson['Ubicacion'];
}
