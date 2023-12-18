import 'package:cloud_firestore/cloud_firestore.dart';

class EntityTransaction {
  String? _id;
  String? _type;
  double? _value;
  Timestamp? _timestamp;
  String? _financeId;

  EntityTransaction(
      {required String id,
      required String type,
      required double value,
      required Timestamp timestamp,
      required String financeId})
      : _id = id,
        _type = type,
        _value = value,
        _timestamp = timestamp,
        _financeId = financeId;

  @override
  String toString() {
    return 'Operação de $_type realizada no dia ${_timestamp!.toDate()} no valor de R\$ $_value';
  }
}
