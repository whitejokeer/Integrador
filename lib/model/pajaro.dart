class Especies {
  String nombre,
      descripcion,
      sonido,
      imagenPrincipal,
      imagenIzquierda,
      imagenDerecha;

  Especies.map(Map<String, dynamic> parsedJson)
      : nombre = parsedJson['NombreEspecie'],
        imagenPrincipal = parsedJson['FotoPrincipal'],
        imagenIzquierda = parsedJson['FotoIzquierda'],
        imagenDerecha = parsedJson['FotoDerecha'],
        sonido = parsedJson['UrlSonido'],
        descripcion = parsedJson['Descripcion'];
}
