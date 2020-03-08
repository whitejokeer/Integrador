class Parque {
  List<String> imagenes;
  String descripcion, horario, tarifas, correo, telefono, web, maps;
  //Nombre del parque como NombreParque.
  Parque.map(Map<String, dynamic> parsedJson, List<String> imagenesL)
      : imagenes = imagenesL,
        descripcion = parsedJson['Descripcion'],
        horario = parsedJson['Horario'],
        tarifas = parsedJson['Tarifas'],
        correo = parsedJson['CorreoOficial'],
        telefono = parsedJson['Telefono'],
        web = parsedJson['UrlWebOficial'],
        maps = parsedJson['UrlMaps'];
}
