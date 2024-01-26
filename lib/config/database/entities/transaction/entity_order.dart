import 'package:simple_finances/config/database/entities/transaction/entity_transaction.dart';

class EntityOrder extends EntityTransaction {
  String? _customerId;
  bool? _isPayd;
  EntityOrder({
    required super.id,
    required super.type,
    required super.value,
    required super.description,
    required super.time,
    required super.cashflowId,
    required String customerId,
    required bool isPayd,
  })  : _customerId = customerId,
        _isPayd = isPayd;
  String getCustomerId() => _customerId!;
  bool getPaymentState() => _isPayd!;
  setCustomerId(String value) => _customerId = value;
  setPaymentState(bool value) => _isPayd = value;
}
