import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';

class CloudFirestoreDataBase {
  final String uid = FireAuth().getUid();
  FirebaseFirestore get _firestoredatabase => FirebaseFirestore.instance;

  Future<void> persistDocument(
      Map<String, dynamic> document, String path) async {
    // recevies a path and a map and persist it
    await _firestoredatabase.collection(path).add(document);
  }

  Future<void> updateDocument(
      String path, String document, Map<String, dynamic> documentUpdate) async {
    _firestoredatabase.collection(path).doc(document).update(documentUpdate);
  }

  Future<QuerySnapshot> getCollection(String path) async {
    // recevies a path to the collection and return it
    return await _firestoredatabase.collection(path).get();
  }

  Future<DocumentSnapshot> getDocument(String path, String document) async {
    // recevies a path to the document and return it
    return await _firestoredatabase.collection(path).doc(document).get();
  }

  Future deleteDocument(String path, String document) async {
    // recevies a path to the document and delete it
    await _firestoredatabase.collection(path).doc(document).delete();
  }
}
