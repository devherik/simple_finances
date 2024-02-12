import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_finances/config/database/entities/entity_cashflow.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';

class DaoCashflow {
  final _dataBase = CloudFirestoreDataBase();

  Future<void> persistCashflow(
      EntityCashflow cashflow, String accountId) async {
    // open a new cashflow
    final currentCashflow = await getCurrentCashflow(accountId);
    if (!currentCashflow.getState()) {
      await _dataBase
          .persistDocument('/accounts/$accountId/cashflows', <String, dynamic>{
        'init': cashflow.getInitTime(),
        'open_value': cashflow.getOpenValue(),
        'is_open': true
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('Persist Cashflow ERROR: $error');
        }
      });
    } else {}
  }

  Future<void> closeCashflow(String accountId, DateTime end) async {
    // closes the cashflow
    final currentCashflow = await getCurrentCashflow(accountId);
    if (currentCashflow.getState()) {
      await _dataBase.updateDocument('accounts/$accountId/cashflows',
          currentCashflow.getId(), <String, dynamic>{
        'end': Timestamp.fromDate(end),
        'is_open': false
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('Close Cashflow ERROR: $error');
        }
      });
    } else {}
  }

  Future<void> updateCashflow(String accountId, double value) async {
    // when a transction be done, it will send a value already calculated that will be used to update de cashflow
    final currentCashflow = await getCurrentCashflow(accountId);
    await _dataBase.updateDocument(
        'accounts/$accountId/cashflow',
        currentCashflow.getId(),
        <String, dynamic>{'open_value': value}).onError((error, stackTrace) {
      if (kDebugMode) {
        print('Update Cashflow ERROR: $error');
      }
    });
  }

  Future<EntityCashflow> getCurrentCashflow(String accountId) async {
    // when the finance page is loaded, the app try o get the current, open, cashflow,
    // and, if it's closed, create a empty cashflow until a new one be opened
    final account = await _dataBase.getDocument('accounts', accountId);
    final currentCashflow = await _dataBase.getDocument(
        'accounts/$accountId/cashflows', account['current_cashflow']);
    EntityCashflow? entity;
    if (currentCashflow.exists) {
      currentCashflow['is_open']
          ? entity = EntityCashflow(
              id: currentCashflow.id,
              init: currentCashflow['init'],
              openValue: double.parse(currentCashflow['open_value'].toString()),
              closeValue:
                  double.parse(currentCashflow['close_value'].toString()),
              isOpen: currentCashflow['is_open'])
          : entity = EntityCashflow(
              id: '',
              init: Timestamp.now(),
              openValue: 0.0,
              closeValue: 0.0,
              isOpen: true);
    } else {
      entity = EntityCashflow(
          id: '',
          init: Timestamp.now(),
          openValue: 0.0,
          closeValue: 0.0,
          isOpen: true);
    }
    return entity;
  }

  Future<EntityCashflow> getCashflow(
      String accountId, String cashflowId) async {
    // return a cashflow searched by the id
    final cashflow = await _dataBase.getDocument(
        '/accounts/$accountId/cashflows', cashflowId);
    if (cashflow.exists) {
      if (cashflow['is_open']) {
        return EntityCashflow(
          id: cashflow.id,
          init: cashflow['init'],
          openValue: cashflow['open_value'],
          closeValue: cashflow['close_value'],
          isOpen: cashflow['is_open'],
        );
      } else {
        EntityCashflow entity = EntityCashflow(
          id: cashflow.id,
          init: cashflow['init'],
          openValue: cashflow['open_value'],
          closeValue: cashflow['close_value'],
          isOpen: cashflow['is_open'],
        );
        return entity;
      }
    } else {
      return EntityCashflow(
        id: '',
        init: Timestamp.now(),
        openValue: 0.0,
        closeValue: 0.0,
        isOpen: true,
      );
    }
  }

  Future<List<EntityCashflow>> getCashflows(String accountId) async {
    // return a collection with all cashflows on the database, filtered by date of openning
    // that way will simplify the database storage by not creating a collection for each year, month or day
    final collection =
        await _dataBase.getCollection('/accounts/$accountId/cashflows');
    List<EntityCashflow> cashflows = [];
    if (collection.docs.isNotEmpty) {
      for (var doc in collection.docs) {
        EntityCashflow entity = EntityCashflow(
          id: doc.id,
          init: doc['init'],
          openValue: doc['open_value'],
          closeValue: doc['close_value'],
          isOpen: doc['is_open'],
        );
        cashflows.add(entity);
      }
      cashflows.sort(
        (a, b) => b.getInitTime().compareTo(a.getInitTime()),
      );
      return cashflows;
    } else {
      return cashflows;
    }
  }
}
