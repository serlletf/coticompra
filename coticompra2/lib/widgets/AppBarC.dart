import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'search_page.dart';

class AppBarC extends StatefulWidget {
  @override
  _AppBarCState createState() => _AppBarCState();
}

class _AppBarCState extends State<AppBarC> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> filteredProducts = [];
  bool isSearching = false;
  String userName = '';
  String nearestSupermarket = 'Supermercado más cercano';
  String supermarketAddress = 'Dirección del supermercado más cercano';

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _getNearestSupermarket();  // Llamamos a la función para simular la obtención del supermercado
    _searchController.addListener(() {
      filterProducts();
    });
  }

  void _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('userName');
    setState(() {
      userName = name ?? 'Usuario';
    });
  }

  // Simulamos la función para obtener el supermercado más cercano
  Future<void> _getNearestSupermarket() async {
    // Aquí es donde iría tu endpoint en caso de implementar el backend
    // final response = await http.get(Uri.parse('<TU_ENDPOINT_DE_SUPERMERCADO>'));

    // Simulación de datos
    setState(() {
      nearestSupermarket = 'Supermercado Unimarc';
      supermarketAddress = 'Av. Siempre Viva 742, Springfield';
    });

    // Descomenta este bloque y modifica el endpoint para implementar el backend
    /*
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        nearestSupermarket = data['nombreSupermercado'] ?? 'Supermercado más cercano';
        supermarketAddress = data['direccion'] ?? 'Dirección no disponible';
      });
    } else {
      setState(() {
        nearestSupermarket = 'Error al cargar el supermercado cercano';
        supermarketAddress = '';
      });
    }
    */
  }

  Future<void> filterProducts() async {
    String searchTerm = _searchController.text;

    if (searchTerm.isEmpty) {
      setState(() {
        filteredProducts = [];
        isSearching = false;
      });
      return;
    }

    final response = await http.get(Uri.parse('https://serllet.shop/buscar_producto?nombre=$searchTerm'));

    if (response.statusCode == 200) {
      List<dynamic> products = json.decode(response.body);
      setState(() {
        filteredProducts = products;
        isSearching = true;
      });
    } else {
      setState(() {
        filteredProducts = [];
        isSearching = false;
      });
    }
  }

  void navigateToSearchPage(String searchTerm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(searchTerm: searchTerm),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue.shade900,
          child: SafeArea(
            child: AppBar(
              backgroundColor: Colors.blue.shade900,
              toolbarHeight: 150.0,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Hola, $userName",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
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
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              if (_searchController.text.isNotEmpty) {
                                navigateToSearchPage(_searchController.text);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "SUPERMERCADO MÁS CERCANO",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$nearestSupermarket\n$supermarketAddress",
                          style: TextStyle(color: Colors.white),
                        ),
                        Stack(
                          children: [
                            Icon(Icons.notifications, color: Colors.white, size: 30),
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isSearching)
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final producto = filteredProducts[index];
                  return ListTile(
                    title: Text(producto['nombreProducto']),
                    subtitle: Text('Precio: \$${producto['Precio']}'),
                    onTap: () {
                      navigateToSearchPage(producto['nombreProducto']);
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

