import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddGameScreen extends StatefulWidget {
  @override
  _AddGameScreenState createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _developerController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  void _addGame() {
    if (_nameController.text.isNotEmpty &&
        _developerController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty) {
      _firestoreService.addGame(
        _nameController.text,
        _developerController.text,
        _categoryController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เพิ่มเกม")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "ชื่อเกม"),
            ),
            TextField(
              controller: _developerController,
              decoration: InputDecoration(labelText: "ผู้พัฒนา"),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: "ประเภท"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addGame,
              child: Text("เพิ่มเกม"),
            ),
          ],
        ),
      ),
    );
  }
}
