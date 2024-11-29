import 'package:flutter/material.dart';
import 'search_page.dart'; // Asegúrate de importar la página de búsqueda

class SearchContent extends StatelessWidget {
  final List<String> categories = [
      "Despensa", "Carnes", "Frutas y Verduras", "Lácteos", "Limpieza", "Bebestibles"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Cantidad de columnas
          crossAxisSpacing: 16.0, // Espacio horizontal entre las cards
          mainAxisSpacing: 16.0, // Espacio vertical entre las cards
        ),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navega a SearchPage con la categoría seleccionada
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(searchTerm: categories[index]),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category, size: 50, color: Colors.blue.shade700),
                  SizedBox(height: 10),
                  Text(
                    categories[index],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
