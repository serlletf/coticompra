import 'package:flutter/material.dart';

class RecipesContent extends StatelessWidget {
  final List<String> recipes = ["Receta 1", "Receta 2", "Receta 3", "Receta 4"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "¿Qué quieres cocinar hoy?",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Cantidad de columnas
                crossAxisSpacing: 16.0, // Espacio horizontal entre las cards
                mainAxisSpacing: 16.0, // Espacio vertical entre las cards
              ),
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://cdn-icons-png.flaticon.com/512/9633/9633297.png', // Imagen de ejemplo
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      Text(
                        recipes[index],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Descripción',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
