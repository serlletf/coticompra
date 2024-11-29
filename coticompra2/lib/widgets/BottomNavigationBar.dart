import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue, // Fondo azul
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Aseguramos que todos los ítems sean visibles
        backgroundColor: Colors.blue.shade900, // Fondo azul dentro del BottomNavigationBar
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Recetas"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lista"),
        ],
        onTap: onItemSelected,
        selectedItemColor: Colors.green, // Ítem seleccionado en verde
        unselectedItemColor: Colors.white, // Ítems no seleccionados en blanco
      ),
    );
  }
}



