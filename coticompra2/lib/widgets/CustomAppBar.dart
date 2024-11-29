import 'package:flutter/material.dart';
import 'home_content.dart';
import 'search_content.dart';
import 'recipes_content.dart';
import 'list_content.dart';
import 'AppBarC.dart';
import 'BottomNavigationBar.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _selectedIndex = 0;
  List<String> shoppingLists = []; // Lista de compras inicializada vacía

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Actualiza la lista de compras desde ListContent
  void _updateShoppingLists(List<String> updatedLists) {
    setState(() {
      shoppingLists = updatedLists;
    });
  }

  // Widget que retorna el contenido según el índice seleccionado
  Widget _getSelectedContent() {
    switch (_selectedIndex) {
      case 0:
        return HomeContent(shoppingLists: shoppingLists); // Pasa la lista de compras a HomeContent
      case 1:
        return SearchContent();
      case 2:
        return RecipesContent();
      case 3:
        return ListContent(
          shoppingLists: shoppingLists, // Pasa la lista de compras a ListContent
          onListUpdated: _updateShoppingLists, // Callback para actualizar la lista
        );
      default:
        return HomeContent(shoppingLists: shoppingLists);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBarC(),
      ),
      body: _getSelectedContent(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}


