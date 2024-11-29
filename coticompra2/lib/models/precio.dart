class Precio {
  final String idPrecio;
  final String idProducto;
  final int idSupermercado;
  final double precio;
  final DateTime fechaActualizacion;

  Precio({
    required this.idPrecio,
    required this.idProducto,
    required this.idSupermercado,
    required this.precio,
    required this.fechaActualizacion,
  });

  // Crear un objeto Precio desde un Map (API o SQLite)
  factory Precio.fromMap(Map<String, dynamic> map) {
    return Precio(
      idPrecio: map['id_precio'],
      idProducto: map['id_producto'],
      idSupermercado: map['id_supermercado'],
      precio: (map['precio'] as num).toDouble(),
      fechaActualizacion: DateTime.parse(map['fecha_actualizacion']),
    );
  }

  // Convertir un objeto Precio a un Map
  Map<String, dynamic> toMap() {
    return {
      'id_precio': idPrecio,
      'id_producto': idProducto,
      'id_supermercado': idSupermercado,
      'precio': precio,
      'fecha_actualizacion': fechaActualizacion.toIso8601String(),
    };
  }
}
