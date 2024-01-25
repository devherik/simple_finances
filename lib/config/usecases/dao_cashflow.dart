import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';

class DaoCashflow {
  final _dataBase = CloudFirestoreDataBase();

  Future<void> persistCashflow(DateTime init, double openValue) async {
    // open a new cashflow
    Map<String, dynamic> cashflow = <String, dynamic>{
      'init': Timestamp.fromDate(init),
      'open_value': openValue,
      'is_open': true
    };
    await _dataBase
        .persistDocument('/database/finance/cashflow', cashflow)
        .onError((error, stackTrace) {
      if (kDebugMode) {
        print('Persist Cashflow ERROR: $error');
      }
    });
  }

  Future<void> closeCashflow(String id, DateTime end) async {
    // closes the cashflow
    await _dataBase.updateDocument(
        'database/finance/cashflow', id, <String, dynamic>{
      'end': Timestamp.fromDate(end),
      'is_open': false
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('Close Cashflow ERROR: $error');
      }
    });
  }

  Future<void> updateCashflow(String id, double value) async {
    // when a transction be done, it will send a value already calculated that will be used to update de cashflow
    await _dataBase.updateDocument('database/finance/cashflow', id,
        <String, dynamic>{'open_value': value}).onError((error, stackTrace) {
      if (kDebugMode) {
        print('Update Cashflow ERROR: $error');
      }
    });
  }

  Future<Map<String, dynamic>> getCashflow(String id) async {
    // return a cashflow searched by the id
    final cashflow =
        await _dataBase.getDocument('/database/finance/cashflow', id);
    if (cashflow.exists) {
      return cashflow as Map<String, dynamic>;
    } else {
      return <String, dynamic>{};
    }
  }

  Future<QuerySnapshot> getCashflows() async {
    // return a collection with all cashflows on the database, filtered by date of openning
    // that way will simplify the database storage by not creating a collection for each year, month or day
    final collection =
        await _dataBase.getCollection('/database/finance/cashflow');
    if (collection.docs.isNotEmpty) {
      collection.docs.sort(
        (a, b) => b.data()['timestamp'].compareTo(a.data()['timestamp']),
      );
      return collection;
    } else {
      return collection;
    }
  }
}
