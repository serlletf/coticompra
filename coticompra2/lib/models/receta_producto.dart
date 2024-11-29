class RecetaProducto {
  final String idReceta;
  final String idProducto;
  final double cantidad;
  final String unidadMedida;

  RecetaProducto({
    required this.idReceta,
    required this.idProducto,
    required this.cantidad,
    required this.unidadMedida,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_receta': idReceta,
      'id_producto': idProducto,
      'cantidad': cantidad,
      'unidad_medida': unidadMedida,
    };
  }

  factory RecetaProducto.fromMap(Map<String, dynamic> map) {
    return RecetaProducto(
      idReceta: map['id_receta'],
      idProducto: map['id_producto'],
      cantidad: map['cantidad'],
      unidadMedida: map['unidad_medida'],
    );
  }
}
