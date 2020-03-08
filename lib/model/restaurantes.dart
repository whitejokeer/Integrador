class Restaurante {
String nombre, logo, descripcion, correo, telefono, web, maps;

  Restaurante.map(Map<String, dynamic> parsedJson)
      : nombre = parsedJson['NombreAgencia'],
        logo = parsedJson['LogoAgencias'],
        descripcion = parsedJson['Descripcion'],
        correo = parsedJson['CorreoOficial'],
        telefono = parsedJson['Telefono'],
        web = parsedJson['UrlWebOficial'],
        maps = parsedJson['UrlMaps'];
}
