import 'package:cloud_firestore/cloud_firestore.dart';

class EntityTransaction {
  final String? _id;
  String? _type;
  String? _description;
  int? _value;
  Timestamp? _timestamp;
  String? _cashflowId;

  EntityTransaction(
      {required String id,
      required String type,
      required String description,
      required int value,
      required Timestamp time,
      required String cashflowId})
      : _id = id,
        _type = type,
        _description = description,
        _value = value,
        _timestamp = time,
        _cashflowId = cashflowId;

  @override
  String toString() {
    return 'Operação de $_type realizada no dia ${_timestamp!.toDate()} no valor de R\$ $_value';
  }

  String getId() => _id!;
  String getType() => _type!;
  String getDescription() => _description!;
  int getValue() => _value!;
  Timestamp getTimestamp() => _timestamp!;
  String getFinanceId() => _cashflowId!;
  setType(value) => _type = value;
  setValue(value) => _value = value;
  setDescription(String value) => _description = value;
  setTimestamp(value) => _timestamp = value;
  setFinanceId(value) => _cashflowId = value;

  updateTransaction(String type, int value, Timestamp time, String financeId) {
    _type = type;
    _value = value;
    _cashflowId = financeId;
  }
}
