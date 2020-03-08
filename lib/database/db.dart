import 'dart:async';
import 'dart:io' as io;

import 'package:anato/model/municipios.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();

    ///Change the name of the db field
    String path = join(documentsDirectory.path, "anato4.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  ///Change the TABLE name and content according to your needs
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Municipios(id TEXT, nombre TEXT, mapa TEXT, provincias TEXT)");
  }

  //Funciones para el manejo de la informacion de usuarios

  Future<int> saveMunicipios(Municipios municipio) async {
    var dbClient = await db;
    int res = await dbClient.insert("Municipios", municipio.toMap());
    return res;
  }

  Future<int> deleteMunicipios() async {
    var dbClient = await db;
    int res = await dbClient.delete("Municipios");
    return res;
  }

  Future<List<Municipios>> fectchMunicipios() async {
    // Get a reference to the _database
    var dbClient = await db;

    // Query the table for All The Usuarios.
    final List<Map<String, dynamic>> maps =
        await dbClient.query('Municipios');

    // Convert the List<Map<String, dynamic> into a List<Usuario>.
    return List.generate(maps.length, (i) {
      return Municipios.fromDb(maps[i]);
    });
  }
    Future<Municipios> fetchMunicipio(int id) async {
    // Get a reference to the _database
    var dbClient = await db;

    // Query the table for All The Usuarios.
    var data = await dbClient.query('Municipios',
        columns: null, where: 'id = ?', whereArgs: [id]);

    // Convert the List<Map<String, dynamic> into a List<Usuario>.
    return Municipios.fromDb(data[0]);
  }

}