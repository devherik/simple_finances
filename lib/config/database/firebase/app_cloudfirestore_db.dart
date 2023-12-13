import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';

class CloudFirestoreDataBase {
  final String uid = FireAuth().getUid();
  FirebaseFirestore get firestoredatabase => FirebaseFirestore.instance;

  Future persistDocument(Map<String, dynamic> doc, String path) async {
    // recevies a path and a map and persist it
  }
  Future getCollection(String path) async {
    // recevies a path to the collection and return it
  }
  Future getDocument(String path) async {
    // recevies a path to the document and return it
  }
  Future deleteDocument(String path) async {
    // recevies a path to the document and delete it
  }
}
