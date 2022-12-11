import 'package:flutter/material.dart';
import 'package:meus_lugares/maps.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _myPlaces = ["São Paulo", "Suzano", "Mogi das Cruzes", "Itanhaém"];

  void _openMap() {}

  void _deletePlace() {}

  void _addPlace() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Maps(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Lugares"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          _addPlace();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _myPlaces.length,
                itemBuilder: (context, index) {
                  String title = _myPlaces[index];
                  return GestureDetector(
                    onTap: () {
                      _openMap();
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _deletePlace();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.remove_circle,
                                    color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
