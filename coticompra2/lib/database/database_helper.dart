import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:coticompra2/models/categoria.dart';
import 'package:coticompra2/models/producto.dart';
import 'package:coticompra2/models/supermercado.dart';
import 'package:coticompra2/models/precio.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    // Crear tabla `categoria`
    await db.execute('''
      CREATE TABLE categoria (
        id_categoria TEXT PRIMARY KEY,
        nombre_categoria TEXT NOT NULL
      );
    ''');

    // Crear tabla `supermercado`
    await db.execute('''
      CREATE TABLE supermercado (
        id_supermercado INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre_supermercado TEXT NOT NULL
      );
    ''');

    // Crear tabla `producto`
    await db.execute('''
      CREATE TABLE producto (
        id_producto TEXT PRIMARY KEY,
        nombre_producto TEXT NOT NULL,
        marca_producto TEXT NOT NULL,
        formato_producto TEXT NOT NULL,
        imagen_url TEXT,
        id_categoria TEXT NOT NULL,
        FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria) ON DELETE CASCADE
      );
    ''');

    // Crear tabla `precio`
    await db.execute('''
      CREATE TABLE precio (
        id_precio TEXT PRIMARY KEY,
        id_producto TEXT NOT NULL,
        id_supermercado INTEGER NOT NULL,
        precio REAL NOT NULL,
        fecha_actualizacion TEXT NOT NULL,
        FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE CASCADE,
        FOREIGN KEY (id_supermercado) REFERENCES supermercado (id_supermercado) ON DELETE CASCADE
      );
    ''');
  }

  // Métodos para insertar datos
  Future<void> insertSupermercado(Supermercado supermercado) async {
    final db = await database;
    await db.insert('supermercado', supermercado.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertProducto(Producto producto) async {
    final db = await database;
    await db.insert('producto', producto.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertPrecio(Precio precio) async {
    final db = await database;
    await db.insert('precio', precio.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertCategoria(Categoria categoria) async {
    final db = await database;
    await db.insert('categoria', categoria.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Métodos para obtener datos
  Future<List<Supermercado>> getAllSupermercados() async {
    final db = await database;
    final result = await db.query('supermercado');
    return result.map((json) => Supermercado.fromMap(json)).toList();
  }

  Future<List<Producto>> getAllProductos() async {
    final db = await database;
    final result = await db.query('producto');
    return result.map((json) => Producto.fromMap(json)).toList();
  }

  Future<List<Categoria>> getAllCategorias() async {
    final db = await database;
    final result = await db.query('categoria');
    return result.map((json) => Categoria.fromMap(json)).toList();
  }

  Future<List<Precio>> getAllPrecios() async {
    final db = await database;
    final result = await db.query('precio');
    return result.map((json) => Precio.fromMap(json)).toList();
  }

  // Métodos para buscar datos específicos
  Future<Producto?> getProductoById(String idProducto) async {
    final db = await database;
    final result = await db.query('producto', where: 'id_producto = ?', whereArgs: [idProducto]);
    if (result.isNotEmpty) {
      return Producto.fromMap(result.first);
    }
    return null;
  }

  Future<List<Precio>> getPreciosByProducto(String idProducto) async {
    final db = await database;
    final result = await db.query('precio', where: 'id_producto = ?', whereArgs: [idProducto]);
    return result.map((json) => Precio.fromMap(json)).toList();
  }

  Future<List<Producto>> getProductosByCategoria(String idCategoria) async {
    final db = await database;
    final result = await db.query('producto', where: 'id_categoria = ?', whereArgs: [idCategoria]);
    return result.map((json) => Producto.fromMap(json)).toList();
  }

  // Método para cerrar la base de datos
  Future<void> close() async {
    final db = await _database;
    if (db != null) {
      await db.close();
    }
  }
}

