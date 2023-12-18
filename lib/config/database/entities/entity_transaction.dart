import 'package:cloud_firestore/cloud_firestore.dart';

class EntityTransaction {
  final String? _id;
  String? _type;
  double? _value;
  Timestamp? _timestamp;
  String? _financeId;

  EntityTransaction(
      {required String id,
      required String type,
      required double value,
      required Timestamp time,
      required String financeId})
      : _id = id,
        _type = type,
        _value = value,
        _timestamp = time,
        _financeId = financeId;

  @override
  String toString() {
    return 'Operação de $_type realizada no dia ${_timestamp!.toDate()} no valor de R\$ $_value';
  }

  String getId() => _id!;
  String getType() => _type!;
  double getValue() => _value!;
  Timestamp getTimestamp() => _timestamp!;
  String getFinanceId() => _financeId!;
  setType(value) => _type = value;
  setValue(value) => _value = value;
  setTimestamp(value) => _timestamp = value;
  setFinanceId(value) => _financeId = value;

  updateTransaction(
      String type, double value, Timestamp time, String financeId) {
    _type = type;
    _value = value;
    _financeId = financeId;
  }
}
