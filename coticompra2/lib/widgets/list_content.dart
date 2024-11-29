import 'package:flutter/material.dart';

class ListContent extends StatefulWidget {
  final List<String> shoppingLists;
  final ValueChanged<List<String>> onListUpdated;

  ListContent({required this.shoppingLists, required this.onListUpdated});

  @override
  _ListContentState createState() => _ListContentState();
}

class _ListContentState extends State<ListContent> {
  TextEditingController _addController = TextEditingController();

  void _showAddDialog() {
    _addController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nueva lista'),
          content: TextField(
            controller: _addController,
            decoration: InputDecoration(
              hintText: 'Ingrese el nombre de la lista',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_addController.text.isNotEmpty) {
                  setState(() {
                    widget.shoppingLists.add(_addController.text);
                  });
                  widget.onListUpdated(List.from(widget.shoppingLists));
                }
                Navigator.of(context).pop();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Listas',
          style: TextStyle(
            fontSize: 24, // Tamaño de fuente más grande
            fontWeight: FontWeight.bold, // Negrita
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Elimina la flecha de retroceso
      ),
      body: ListView.builder(
        itemCount: widget.shoppingLists.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                widget.shoppingLists[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Negrita en las listas también
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  setState(() {
                    widget.shoppingLists.removeAt(index);
                  });
                  widget.onListUpdated(List.from(widget.shoppingLists));
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _addController.dispose();
    super.dispose();
  }
}
