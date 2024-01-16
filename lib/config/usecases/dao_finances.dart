import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';

class DaoFinances {
  final _dataBase = CloudFirestoreDataBase();

  Future<Map<String, dynamic>> getBalance(DateTime date) async {
    DocumentSnapshot balanceSnapshot = await _dataBase.getDocument(
        '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days',
        date.day.toString());
    if (balanceSnapshot.exists) {
      return balanceSnapshot as Map<String, dynamic>;
    } else {
      return <String, dynamic>{
        'previous_day': date.day.toString(),
        'initial_balance': 0.0,
        'current_balance': 0.0,
        'goal_balance': 0.0,
        'goal_balance_state': 0.0,
      };
    }
  }

  Future createBalance(
      DateTime date, Map<String, dynamic> updateValuers) async {
    // if it has no transactions, open a new balance with the data from previous day
    if (date.day == 01) {
      if (date.month == 01) {
        // situation where the date is January first
        DocumentSnapshot balanceSnapshot = await _dataBase.getDocument(
            '/simple_finances/finances/years/${date.year - 1}/months/12/days',
            '31');
        _dataBase.persistDocumentWithID(
          '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}',
          date.day.toString(),
          <String, dynamic>{
            'previous_day': balanceSnapshot.id,
            'initial_balance': balanceSnapshot['current_balance'],
            'current_balance': balanceSnapshot['current_balance'],
            'goal_balance': balanceSnapshot['goal_balance'],
            'goal_balance_state': 0.0,
          },
        );
      } else {
        // situation where the day is the first of a month after January
        String previousDay = DateTime(date.year, date.month - 1, 0)
            .toString(); //inserting 0, we indicate that we want the the last day of the month
        DocumentSnapshot balanceSnapshot = await _dataBase.getDocument(
            '/simple_finances/finances/years/${date.year}/months/${date.month.toString()}/days',
            previousDay);
        _dataBase.persistDocumentWithID(
          '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days',
          date.day.toString(),
          <String, dynamic>{
            'previous_day': balanceSnapshot.id,
            'initial_balance': balanceSnapshot['current_balance'],
            'current_balance': balanceSnapshot['current_balance'],
            'goal_balance': balanceSnapshot['goal_balance'],
            'goal_balance_state': 0.0,
          },
        );
      }
    } else {
      DocumentSnapshot balanceSnapshot = await _dataBase.getDocument(
          '/simple_finances/finances/years/${date.year}/months/${date.month.toString()}/days',
          date.day.toString());
      _dataBase.persistDocumentWithID(
        '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days',
        date.day.toString(),
        <String, dynamic>{
          'previous_day': balanceSnapshot.id,
          'initial_balance': balanceSnapshot['current_balance'],
          'current_balance': balanceSnapshot['current_balance'],
          'goal_balance': balanceSnapshot['goal_balance'],
          'goal_balance_state': 0.0,
        },
      );
    }
  }

  Future updateBalance(
      DateTime date, Map<String, dynamic> updateValuers) async {
    QuerySnapshot transactions = await _dataBase.getCollection(
        '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days/${date.day.toString()}/transactions');
    DocumentSnapshot balanceSnapshot = await _dataBase.getDocument(
        '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days',
        date.day.toString());
    if (transactions.docs.isNotEmpty) {
      updateValuers['type'] == 'income'
          ? await _dataBase.updateDocument(
              '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days',
              date.day.toString(),
              <String, dynamic>{
                'current_balance':
                    balanceSnapshot['current_balance'] + updateValuers['value'],
                'goal_balance_state': balanceSnapshot['goal_balance_state'] +
                    updateValuers['value'],
              },
            ).onError((error, stackTrace) {
              if (kDebugMode) {
                print(error);
              }
            })
          : await _dataBase.updateDocument(
              '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days',
              date.day.toString(),
              <String, dynamic>{
                'current_balance':
                    balanceSnapshot['current_balance'] - updateValuers['value'],
              },
            ).onError((error, stackTrace) {
              if (kDebugMode) {
                print(error);
              }
            });
    } else {
      createBalance(date, updateValuers);
    }
  }

  Future<List<Map<String, dynamic>>> getBalanceCollection(DateTime date) async {
    List<Map<String, dynamic>> balancesList = [];
    await _dataBase
        .getCollection(
            'simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days')
        .then((collection) {
      if (collection.docs.isNotEmpty) {
        for (var doc in collection.docs) {
          balancesList.add(<String, dynamic>{
            'current_day': doc.id.toString(),
            'previous_day': doc['previous_day'],
            'initial_balance': doc['current_balance'],
            'current_balance': doc['current_balance'],
            'goal_balance': doc['goal_balance'],
            'goal_balance_state': doc['goal_balance_state'],
          });
        }
      } else {
        balancesList.add(<String, dynamic>{
          'current_day': DateTime.now().day.toString(),
          'current_balance': 0.0,
        });
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
    return balancesList;
  }

  Future<String> getGoal(DateTime date) async {
    Map<String, dynamic> balanceMap =
        await getBalance(date).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
      return <String, dynamic>{'goal_balance': error.toString()};
    });
    return balanceMap['goal_balance'].toString();
  }

  Future updateGoal(DateTime date, String newGoal) async {
    await _dataBase.updateDocument(
        '/simple_finances/finances/years/${date.year.toString()}/months/${date.month.toString()}/days',
        date.day.toString(), <String, dynamic>{
      'goal_balance': newGoal
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
