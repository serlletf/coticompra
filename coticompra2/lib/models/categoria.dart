class Categoria {
  final String idCategoria;
  final String nombreCategoria;

  Categoria({required this.idCategoria, required this.nombreCategoria});

  // Crear un objeto Categoria desde un Map (API o SQLite)
  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      idCategoria: map['id_categoria'],
      nombreCategoria: map['nombre_categoria'],
    );
  }

  // Convertir un objeto Categoria a un Map
  Map<String, dynamic> toMap() {
    return {
      'id_categoria': idCategoria,
      'nombre_categoria': nombreCategoria,
    };
  }
}
