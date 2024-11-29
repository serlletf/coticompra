class Supermercado {
  final int idSupermercado;
  final String nombreSupermercado;

  Supermercado({required this.idSupermercado, required this.nombreSupermercado});

  // Crear un objeto Supermercado desde un Map (API o SQLite)
  factory Supermercado.fromMap(Map<String, dynamic> map) {
    return Supermercado(
      idSupermercado: map['id_supermercado'],
      nombreSupermercado: map['nombre_supermercado'],
    );
  }

  // Convertir un objeto Supermercado a un Map
  Map<String, dynamic> toMap() {
    return {
      'id_supermercado': idSupermercado,
      'nombre_supermercado': nombreSupermercado,
    };
  }
}
