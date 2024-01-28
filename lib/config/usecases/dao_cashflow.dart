import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_finances/config/database/entities/entity_cashflow.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';

class DaoCashflow {
  final _dataBase = CloudFirestoreDataBase();

  Future<void> persistCashflow(EntityCashflow cashflow) async {
    // open a new cashflow
    await _dataBase
        .persistDocument('/database/finance/cashflow', <String, dynamic>{
      'init': cashflow.getInitTime(),
      'open_value': cashflow.getOpenValue(),
      'is_open': true
    }).onError((error, stackTrace) {
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

  Future<EntityCashflow> getCurrentCashflow() async {
    // when the finance page is loaded, the app try o get the current, open, cashflow,
    // and, if it's closed, create a empty cashflow until a new one be opened
    final finance = await _dataBase.getDocument('database', 'finance');
    final cashflow = await _dataBase.getDocument(
        'database/finance/cashflow', finance['current_cashflow']);
    EntityCashflow? entity;
    cashflow['is_open']
        ? entity = EntityCashflow(
            id: cashflow.id,
            init: cashflow['init'],
            openValue: double.parse(cashflow['open_value'].toString()),
            isOpen: cashflow['is_open'])
        : entity = EntityCashflow(
            id: '', init: Timestamp.now(), openValue: 0, isOpen: true);
    return entity;
  }

  Future<EntityCashflow> getCashflow(String id) async {
    // return a cashflow searched by the id
    final cashflow =
        await _dataBase.getDocument('/database/finance/cashflow', id);
    if (cashflow.exists) {
      if (cashflow['is_open']) {
        return EntityCashflow(
          id: cashflow.id,
          init: cashflow['init'],
          openValue: cashflow['open_value'],
          isOpen: cashflow['is_open'],
        );
      } else {
        EntityCashflow entity = EntityCashflow(
          id: cashflow.id,
          init: cashflow['init'],
          openValue: cashflow['open_value'],
          isOpen: cashflow['is_open'],
        );
        entity.setCloseTime(cashflow['end']);
        entity.setCloseValue(cashflow['close_value']);
        return entity;
      }
    } else {
      return EntityCashflow(
        id: '',
        init: Timestamp.now(),
        openValue: 0,
        isOpen: true,
      );
    }
  }

  Future<List<EntityCashflow>> getCashflows() async {
    // return a collection with all cashflows on the database, filtered by date of openning
    // that way will simplify the database storage by not creating a collection for each year, month or day
    final collection =
        await _dataBase.getCollection('/database/finance/cashflow');
    List<EntityCashflow> cashflows = [];
    if (collection.docs.isNotEmpty) {
      for (var doc in collection.docs) {
        EntityCashflow entity = EntityCashflow(
          id: doc.id,
          init: doc['init'],
          openValue: doc['open_value'],
          isOpen: doc['is_open'],
        );
        entity.setCloseTime(doc['end']);
        entity.setCloseValue(doc['close_value']);
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
