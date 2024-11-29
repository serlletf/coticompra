class Producto {
  final String idProducto;
  final String nombreProducto;
  final String marcaProducto;
  final String formatoProducto;
  final String? imagenUrl;
  final String idCategoria;

  Producto({
    required this.idProducto,
    required this.nombreProducto,
    required this.marcaProducto,
    required this.formatoProducto,
    this.imagenUrl,
    required this.idCategoria,
  });

  // Crear un objeto Producto desde un Map (API o SQLite)
  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      idProducto: map['id_producto'],
      nombreProducto: map['nombre_producto'],
      marcaProducto: map['marca_producto'],
      formatoProducto: map['formato_producto'],
      imagenUrl: map['imagen_url'],
      idCategoria: map['id_categoria'],
    );
  }

  // Convertir un objeto Producto a un Map
  Map<String, dynamic> toMap() {
    return {
      'id_producto': idProducto,
      'nombre_producto': nombreProducto,
      'marca_producto': marcaProducto,
      'formato_producto': formatoProducto,
      'imagen_url': imagenUrl,
      'id_categoria': idCategoria,
    };
  }
}
