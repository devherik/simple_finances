class EntityAccount {
  String? _id;
  String? _name;
  String? _phone;

  EntityAccount(
      {required String id, required String name, required String phone})
      : _id = id,
        _name = name,
        _phone = phone;
  String getId() => _id!;
  String getName() => _name!;
  setName(String value) => _name = value;
  String getPhone() => _phone!;
  setPhone(String value) => _phone = value;
}
