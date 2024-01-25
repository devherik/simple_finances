import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_finances/config/database/entities/transaction/entity_order.dart';
import 'package:simple_finances/config/database/entities/transaction/entity_transaction.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';
import 'package:simple_finances/config/usecases/dao_cashflow.dart';
import 'package:simple_finances/config/util/app_ui_widgets.dart';

class DaoTransactions {
  final _dataBase = CloudFirestoreDataBase();
  final _daoCashflow = DaoCashflow();
  final uiw = UiWidgets();

  BuildContext? parentContext;

  DaoTransactions({required BuildContext context}) : parentContext = context;

  Future<void> persistTransaction(DateTime date, String type, double value,
      String description, String cashflowId) async {
    // by receiving a value (negative or positive), thie function persist a transaction, then update the cashflow open_value field
    final transaction = <String, dynamic>{
      'description': description,
      'timestamp': Timestamp.fromDate(date),
      'type': type,
      'value': value
    };
    final cashflow = await _daoCashflow.getCashflow(cashflowId);
    final newValue = cashflow['open_value'] + value;
    await _dataBase
        .persistDocument(
            '/database/finance/cashflow/$cashflowId/transactions', transaction)
        .whenComplete(
            () async => await _daoCashflow.updateCashflow(cashflowId, newValue))
        .onError((error, stackTrace) {
      uiw.showMessage(error.toString(), parentContext);
    });
  }

  Future<void> deleteTransaction(
      String cashflowId, String transactionId) async {}

  Future<void> updateTransaction(
      String cashflowId, EntityTransaction transaction) async {
    // update using the id of the transaction
  }

  Future<List<EntityTransaction>> getTransactionsCollection(
      String cashflowId) async {
    List<EntityTransaction> transactionList = [];
    await _dataBase
        .getCollection('database/finance/cashflow/$cashflowId/transactions')
        .then((collection) {
      if (collection.docs.isNotEmpty) {
        for (var doc in collection.docs) {
          doc['type'] == 'order'
              ? transactionList.add(EntityOrder(
                  id: doc.id,
                  type: doc['type'],
                  value: doc['value'],
                  time: doc['timestamp'],
                  cashflowId: cashflowId,
                  customerId: doc['customer_id'],
                  isPayd: doc['is_paid']))
              : transactionList.add(EntityTransaction(
                  id: doc.id,
                  type: doc['type'],
                  value: doc['value'],
                  time: doc['timestamp'],
                  cashflowId: cashflowId));
        }
      }
    }).onError((error, stackTrace) {
      uiw.showMessage(error.toString(), parentContext);
    });
    return transactionList;
  }
}
