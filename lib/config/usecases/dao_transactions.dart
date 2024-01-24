import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';
import 'package:simple_finances/config/usecases/dao_finances.dart';

class DaoTransactions {
  final _dataBase = CloudFirestoreDataBase();
  final _daoFinances = DaoFinances();

  Future<void> persistTransaction(
      DateTime date, String tyoe, double value, String description) async {
    final transaction = <String, dynamic>{
      'description': description,
      'timestamp': Timestamp.fromDate(date),
      'type': tyoe,
      'value': value
    };
    await _daoFinances.createBalance(date).whenComplete(() async {
      await _dataBase
          .persistDocument(
              '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days/${date.day.toString()}/transactions',
              transaction)
          .whenComplete(() async {
        await _daoFinances
            .updateBalance(date, transaction)
            .onError((error, stackTrace) => null);
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }).onError((error, stackTrace) => null);
  }

  Future updateDatabaseBalance(
      Map<String, dynamic> newTransaction, DateTime date) async {
    await _dataBase
        .persistDocument(
      '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days/${date.day.toString()}',
      newTransaction,
    )
        .whenComplete(() {
      if (kDebugMode) {
        print('Transaction added');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
    await _daoFinances.updateBalance(date, newTransaction).whenComplete(() {
      if (kDebugMode) {
        print('Balance updated');
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getTransactionsCollection(
      DateTime date) async {
    List<Map<String, dynamic>> transactionList = [];
    await _dataBase
        .getCollection(
            'simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days/${date.day.toString()}/transactions')
        .then((collection) {
      if (collection.docs.isNotEmpty) {
        for (var doc in collection.docs) {
          transactionList.add(<String, dynamic>{
            'timestamp': doc['timestamp'],
            'type': doc['type'],
            'value': doc['value'],
            'description': doc['description']
          });
        }
      } else {
        transactionList.add(<String, dynamic>{'type': 'empty'});
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
    return transactionList;
  }
}
