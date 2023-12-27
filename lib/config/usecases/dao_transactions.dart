import 'package:flutter/foundation.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';
import 'package:simple_finances/config/usecases/dao_finances.dart';

class DaoTransactions {
  final _dataBase = CloudFirestoreDataBase();
  final _daoFinances = DaoFinances();

  Future updateDatabaseBalance(
      Map<String, dynamic> newTransaction, DateTime date) async {
    await _dataBase
        .persistDocument(
      newTransaction,
      '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/${date.day.toString()}',
    )
        .whenComplete(() {
      if (kDebugMode) {
        print('Transaction added');
      }
    });
    await _daoFinances.updateBalance(date, newTransaction).whenComplete(() {
      if (kDebugMode) {
        print('Balance updated');
      }
    });
  }
}
