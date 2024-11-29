import 'package:flutter/material.dart';
import 'BottomNavigationBar.dart';

class CotizarScreen extends StatelessWidget {
  final String listName;

  CotizarScreen({required this.listName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // Fondo azul oscuro
        title: Text(
          'Cotizar: $listName',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Texto del título en blanco
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white), // Íconos en blanco
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Acción para notificaciones
            },
            color: Colors.white, // Color blanco para el icono
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Acción para más opciones
            },
            color: Colors.white, // Color blanco para el icono
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Mostrando cotización para $listName',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1, // O el índice que corresponde a "Cotizar" o "Buscar"
        onItemSelected: (index) {
          // Navegar a la pantalla seleccionada
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/'); // Navegar al Inicio
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/search'); // Navegar a Buscar
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/recipes'); // Navegar a Recetas
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/list'); // Navegar a Lista
              break;
          }
        },
      ),
    );
  }
}
