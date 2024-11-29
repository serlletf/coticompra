import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'BottomNavigationBar.dart'; // Importamos el BottomNavigationBar reutilizable

class SearchPage extends StatefulWidget {
  final String searchTerm;

  SearchPage({required this.searchTerm});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchTerm;
    _performSearch(widget.searchTerm);
  }

  Future<void> _performSearch(String searchTerm) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://serllet.shop/api/buscar_productos?item=$searchTerm'),
      );

      if (response.statusCode == 200) {
        setState(() {
          searchResults = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          searchResults = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al buscar productos: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        searchResults = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de red: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultados de búsqueda"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Buscar Productos o Supermercado",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _performSearch(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Resultados para \"${_searchController.text}\":",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : searchResults.isEmpty
                ? Center(child: Text("No se encontraron productos"))
                : Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final producto = searchResults[index];
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            producto['imagen_url'] != "No disponible"
                                ? producto['imagen_url']
                                : 'https://via.placeholder.com/80',
                            height: 80,
                            width: 80,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 80,
                                width: 80,
                                color: Colors.grey.shade200,
                                child: Icon(Icons.image, size: 50, color: Colors.grey.shade400),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            "\$${producto['precio']?.toStringAsFixed(0) ?? 'N/A'}",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Flexible(
                            child: Text(
                              producto['nombre_producto'] ?? 'Sin nombre',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(6),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onItemSelected: (index) {
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

