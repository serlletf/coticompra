class Receta {
  final String idReceta;
  final String nombreReceta;
  final String? descripcion;
  final String? preparacion;
  final String dificultad;
  final String condicionDietetica;
  final DateTime fechaCreacion;

  Receta({
    required this.idReceta,
    required this.nombreReceta,
    this.descripcion,
    this.preparacion,
    required this.dificultad,
    required this.condicionDietetica,
    required this.fechaCreacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_receta': idReceta,
      'nombre_receta': nombreReceta,
      'descripcion': descripcion,
      'preparacion': preparacion,
      'dificultad': dificultad,
      'condicion_dietetica': condicionDietetica,
      'fecha_creacion': fechaCreacion.toIso8601String(),
    };
  }

  factory Receta.fromMap(Map<String, dynamic> map) {
    return Receta(
      idReceta: map['id_receta'],
      nombreReceta: map['nombre_receta'],
      descripcion: map['descripcion'],
      preparacion: map['preparacion'],
      dificultad: map['dificultad'],
      condicionDietetica: map['condicion_dietetica'],
      fechaCreacion: DateTime.parse(map['fecha_creacion']),
    );
  }
}
