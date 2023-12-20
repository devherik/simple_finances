import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';

class DaoFinances {
  final _dataBase = CloudFirestoreDataBase();

  Future<Map<String, dynamic>> getBalance(DateTime date) async {
    DocumentSnapshot balanceSnapshot = await _dataBase.getDocument(
        '/simple_finances/finances/years/${date.year.toString()}/months',
        date.month.toString());
    if (balanceSnapshot.exists) {
      return balanceSnapshot as Map<String, dynamic>;
    } else {
      final map = {'document': 'Não encontrado.'};
      return map;
    }
  }

  Future updateDatabaseBalance(
      Map<String, dynamic> newBalance, DateTime date) async {
    await _dataBase.updateDocument(
        '/simple_finances/finances/years/${date.year.toString()}/months',
        date.month.toString(),
        newBalance);
  }

  updateBalance() {}

  getGoal() {}
  updateGoal() {}
}
