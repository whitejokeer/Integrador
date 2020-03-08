import 'package:anato/model/evento.dart';

class ItemEvento {
  DateTime fecha;
  List<Evento> eventos;

  ItemEvento.map(Map<String, dynamic> parsedJson, List<Evento> evento)
      : fecha = DateTime.parse(parsedJson['FechaEvento']),
        eventos = evento;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fecha': fecha,
      'evento': eventos,
    };
  }
}
