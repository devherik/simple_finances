import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';

class CloudFirestoreDataBase {
  final String uid = FireAuth().getUid();
  FirebaseFirestore get _firestoredatabase => FirebaseFirestore.instance;

  Future<void> persistDocument(
      String path, Map<String, dynamic> document) async {
    // recevies a path and a map and persist it
    await _firestoredatabase.collection(path).add(document);
  }

  Future<void> persistDocumentWithID(
      String path, String documentId, Map<String, dynamic> document) async {
    // recevies a path, an id and a map and persist it
    await _firestoredatabase.collection(path).doc(documentId).set(document);
  }

  Future<void> updateDocument(
      String path, String documentId, Map<String, dynamic> newDocument) async {
    _firestoredatabase.collection(path).doc(documentId).update(newDocument);
  }

  Future<QuerySnapshot> getCollection(String path) async {
    // recevies a path to the collection and return it
    return await _firestoredatabase.collection(path).get();
  }

  Future<QuerySnapshot> getCollectionFiltered(String path, String query) async {
    // recevies a path to the collection and return it
    return await _firestoredatabase.collection(path).where(query).get();
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
