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

  Future updateBalance(
      DateTime date, Map<String, dynamic> updateValuers) async {
    QuerySnapshot transactions = await _dataBase.getCollection(
        '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/${date.day.toString()}');
    DocumentSnapshot balanceSnapshot = await _dataBase.getDocument(
        '/simple_finances/finances/years/${date.year.toString()}/months',
        date.month.toString());
    if (transactions.docs.isNotEmpty) {
      updateValuers['type'] == 'income'
          ? await _dataBase.updateDocument(
              '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}',
              date.day.toString(), <String, dynamic>{
              'current_balance':
                  balanceSnapshot['current_balance'] + updateValuers['value'],
              'current_balance_state':
                  balanceSnapshot['current_balance_state'] +
                      updateValuers['value']
            })
          : await _dataBase.updateDocument(
              '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}',
              date.day.toString(), <String, dynamic>{
              'current_balance':
                  balanceSnapshot['current_balance'] - updateValuers['value'],
              'current_balance_state':
                  balanceSnapshot['current_balance_state'] +
                      updateValuers['value']
            });
    } else {
      // if it has no transactions, open a new balance with the data from previous day
      if (date.day.toString() == '01') {
        //chech if the month has changed
      }
    }
  }

  getGoal() {}
  updateGoal() {}
}
