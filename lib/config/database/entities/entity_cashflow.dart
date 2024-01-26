import 'package:cloud_firestore/cloud_firestore.dart';

class EntityCashflow {
  String? _id;
  int? _openValue;
  int? _closeValue;
  bool? _isOpen;
  Timestamp? _init;
  Timestamp? _end;

  EntityCashflow(
      {required String id,
      required Timestamp init,
      required int openValue,
      required bool isOpen})
      : _id = id,
        _openValue = openValue,
        _init = init,
        _isOpen = isOpen;

  String getId() => _id!;
  int getOpenValue() => _openValue!;
  int getCloseValue() => _closeValue!;
  bool getState() => _isOpen!;
  Timestamp getInitTime() => _init!;
  Timestamp getEndTime() => _end!;
  setOpenValue(int value) => _openValue = value;
  setCloseValue(int value) => _closeValue = value;
  setState(bool value) => _isOpen = value;
  setInitTime(Timestamp value) => _init = value;
  setCloseTime(Timestamp value) => _end = value;
}
