import 'package:flutter/material.dart';
import 'BottomNavigationBar.dart'; // Importamos el BottomNavigationBar reutilizable

class ProductDetailsPage extends StatelessWidget {
  final String productName;

  ProductDetailsPage({required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName), // Muestra el nombre del producto como título
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Aquí puedes personalizar cómo mostrar los detalles del producto
            Image.network('https://via.placeholder.com/150'), // Imagen del producto (puedes reemplazarla)
            SizedBox(height: 16),
            Text(
              'Nombre del producto: $productName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Marca: Ejemplo'),
            SizedBox(height: 10),
            Text('Precios en diferentes supermercados:'),
            // Lista de precios (mock data)
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Unimarc'),
              subtitle: Text('\$Precio'),
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Jumbo'),
              subtitle: Text('\$Precio'),
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Santa Isabel'),
              subtitle: Text('\$Precio'),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para agregar a la lista
                },
                child: Text('Agregar a lista'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1, // Marca la pestaña de "Buscar" como seleccionada
        onItemSelected: (index) {
          // Aquí manejamos la navegación según el índice seleccionado
          if (index == 0) {
            Navigator.pop(context); // Volver al inicio si presiona el ícono de inicio
          }
        },
      ),
    );
  }
}
