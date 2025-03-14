import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('รายชื่อเกม'),
            SizedBox(width: 8),
            Icon(Icons.videogame_asset),
          ],
        ),
      ),    
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getGames(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var games = snapshot.data!.docs;

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              var game = games[index];
              var gameData = game.data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(gameData['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(gameData['category']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: const Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () => _editGame(game.id, gameData['name'], gameData['developer'], gameData['category']),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: const Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () => _firestoreService.deleteGame(game.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddGamePopup(context),
        label: Text("เพิ่มเกมใหม่"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _editGame(String docId, String currentName, String currentDeveloper, String currentCategory) {
    TextEditingController nameController = TextEditingController(text: currentName);
    TextEditingController developerController = TextEditingController(text: currentDeveloper);
    TextEditingController categoryController = TextEditingController(text: currentCategory);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("แก้ไขข้อมูลเกม"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "ชื่อเกม")),
            TextField(controller: developerController, decoration: InputDecoration(labelText: "ผู้พัฒนา"), enabled: false),
            TextField(controller: categoryController, decoration: InputDecoration(labelText: "ประเภท")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("ยกเลิก")),
          TextButton(
            onPressed: () {
              _firestoreService.updateGame(docId, nameController.text, categoryController.text);
              Navigator.pop(context);
            },
            child: Text("บันทึก"),
          ),
        ],
      ),
    );
  }

  void _showAddGamePopup(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController developerController = TextEditingController();
    TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("เพิ่มเกมใหม่"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "ชื่อเกม")),
            TextField(controller: developerController, decoration: InputDecoration(labelText: "ผู้พัฒนา")),
            TextField(controller: categoryController, decoration: InputDecoration(labelText: "ประเภท")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("ยกเลิก")),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isEmpty ||
                  developerController.text.isEmpty ||
                  categoryController.text.isEmpty) {
                _showErrorDialog(context);
                return;
              }
              _firestoreService.addGame(
                nameController.text,
                developerController.text,
                categoryController.text,
              );
              Navigator.pop(context);
            },
            child: Text("บันทึก"),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("แจ้งเตือน"),
        content: Text("กรุณากรอกข้อมูลให้ครบทุกช่อง!"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("ตกลง")),
        ],
      ),
    );
  }
}
