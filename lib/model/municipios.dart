class Municipios {
  final String id, nombre, mapa, provinciasL;

  //Construccion rapida a partir del json de respuesta
  Municipios.map(Map<String, dynamic> parsedJson, String provincias)
      : id = parsedJson['_id'],
        nombre = parsedJson['NombreMunicipio'],
        mapa = parsedJson['ImagenMapa'],
        provinciasL = provincias;

  //Transforma la informacion en un mapa para ser guardado en la base de datos
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'nombre': nombre, 'mapa': mapa, 'provincias': provinciasL};
  }

  //Permite el paso de la informacion retornada en la base de datos a la clase
  Municipios.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        nombre = parsedJson['nombre'],
        mapa = parsedJson['mapa'],
        provinciasL = parsedJson['provincias'];
}
