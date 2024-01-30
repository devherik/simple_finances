import 'package:simple_finances/config/database/entities/transaction/entity_transaction.dart';

class EntityOrder extends EntityTransaction {
  String? _customerId;
  EntityOrder({
    required super.id,
    required super.type,
    required super.value,
    required super.description,
    required super.time,
    required super.cashflowId,
    required super.isPayd,
    required String customerId,
  }) : _customerId = customerId;

  String getCustomerId() => _customerId!;
  setCustomerId(String value) => _customerId = value;
}
