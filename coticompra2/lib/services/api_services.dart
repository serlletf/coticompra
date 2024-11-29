import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coticompra2/database/database_helper.dart';
import 'package:coticompra2/models/precio.dart';
import 'package:coticompra2/models/producto.dart';
import 'package:coticompra2/models/supermercado.dart';
import 'package:coticompra2/models/categoria.dart';

class ApiService {
  final String baseUrl = 'https://serllet.shop/api';
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> cloneSupermercados() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/supermercados'));
      if (response.statusCode == 200) {
        List<dynamic> supermercadosJson = jsonDecode(response.body);
        for (var json in supermercadosJson) {
          Supermercado supermercado = Supermercado.fromMap(json);
          await _dbHelper.insertSupermercado(supermercado);
        }
      } else {
        throw Exception('Error al obtener supermercados: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en cloneSupermercados: $e');
    }
  }

  Future<void> cloneProductosYPrecios() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/productos'));
      if (response.statusCode == 200) {
        List<dynamic> productosJson = jsonDecode(response.body);
        for (var json in productosJson) {
          Producto producto = Producto.fromMap(json);
          await _dbHelper.insertProducto(producto);

          List<Precio> precios = await fetchPreciosProducto(producto.idProducto);
          for (var precio in precios) {
            await _dbHelper.insertPrecio(precio);
          }
        }
      } else {
        throw Exception('Error al obtener productos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en cloneProductosYPrecios: $e');
    }
  }

  Future<List<Precio>> fetchPreciosProducto(String idProducto) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/precios/$idProducto'));
      if (response.statusCode == 200) {
        List<dynamic> preciosJson = jsonDecode(response.body);
        return preciosJson.map((json) => Precio.fromMap(json)).toList();
      } else {
        throw Exception('Error al obtener precios: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en fetchPreciosProducto: $e');
      return [];
    }
  }

  Future<void> cloneCategorias() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categorias'));
      if (response.statusCode == 200) {
        List<dynamic> categoriasJson = jsonDecode(response.body);
        for (var json in categoriasJson) {
          Categoria categoria = Categoria.fromMap(json);
          await _dbHelper.insertCategoria(categoria);
        }
      } else {
        throw Exception('Error al obtener categorías: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en cloneCategorias: $e');
    }
  }
}
