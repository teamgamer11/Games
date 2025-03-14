import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference gamesCollection =
      FirebaseFirestore.instance.collection('Games');

  // เพิ่มเกม
  Future<DocumentReference> addGame(String name, String developer, String category) async {
    return gamesCollection.add({
      'name': name,
      'developer': developer,
      'category': category,
    });
  }

  // ดึงข้อมูลเกมทั้งหมด
  Stream<QuerySnapshot> getGames() {
    return gamesCollection.snapshots();
  }

  // แก้ไขเกม
  Future<void> updateGame(String docId, String newName, String newCategory) async {
    return gamesCollection.doc(docId).update({
      'name': newName,
      'category': newCategory, 
    });
  }

  // ลบเกม
  Future<void> deleteGame(String docId) async {
    return gamesCollection.doc(docId).delete();
  }
}
