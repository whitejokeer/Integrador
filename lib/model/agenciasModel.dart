class Agencia {
  String nombre, logo, descripcion, correo, telefono, web, maps;

  Agencia.map(Map<String, dynamic> parsedJson)
      : nombre = parsedJson['NombrAgencia'],
        logo = parsedJson['LogoAgencia'],
        descripcion = parsedJson['Descripcion'],
        correo = parsedJson['CorreoOficial'],
        telefono = parsedJson['telefono'],
        web = parsedJson['UrlWebOficial'],
        maps = parsedJson['UrlMaps'];
}
