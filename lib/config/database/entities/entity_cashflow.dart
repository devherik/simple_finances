import 'package:cloud_firestore/cloud_firestore.dart';

class EntityCashflow {
  String? _id;
  double? _openValue;
  double? _closeValue;
  bool? _isOpen;
  Timestamp? _init;
  Timestamp? _end;

  EntityCashflow(
      {required String id,
      required Timestamp init,
      required double openValue,
      required double closeValue,
      required bool isOpen})
      : _id = id,
        _openValue = openValue,
        _init = init,
        _isOpen = isOpen,
        _closeValue = closeValue;

  @override
  String toString() {
    final date = getInitTimeToString();
    return 'Caixa aberto no dia $date, com saldo de R\$ $_closeValue';
  }

  String getId() => _id!;
  double getOpenValue() => _openValue!;
  double getCloseValue() => _closeValue!;
  bool getState() => _isOpen!;
  Timestamp getInitTime() => _init!;
  String getInitTimeToString() {
    final time = _init!.toDate();
    return '${time.day}/${time.month}/${time.year}';
  }

  Timestamp getEndTime() => _end!;
  setOpenValue(double value) => _openValue = value;
  setCloseValue(double value) => _closeValue = value;
  setState(bool value) => _isOpen = value;
  setInitTime(Timestamp value) => _init = value;
  setCloseTime(Timestamp value) => _end = value;
}
