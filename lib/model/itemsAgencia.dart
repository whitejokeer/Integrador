import 'package:anato/model/agenciasModel.dart';

class ItemFinal{
  String nombreProvincias;
  List<Agencia> agencias;
  ItemFinal.map(String nombre, List<Agencia> agenciasL)
  : nombreProvincias = nombre,
  agencias = agenciasL;

}