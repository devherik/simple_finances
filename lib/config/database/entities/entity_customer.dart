class EntityCustomer {
  String? _id;
  String? _name;
  String? _email;
  String? _cpf;

  EntityCustomer(
      {required String id,
      required String name,
      required String email,
      required String cpf})
      : _email = email,
        _name = name,
        _id = id,
        _cpf = cpf;

  @override
  String toString() {
    return 'Cliente $_name ($_cpf)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': _id, 'name': _name, 'email': _email};
  }

  String getId() => _id!;
  String getName() => _name!;
  String getEmail() => _email!;
  String getCpf() => _cpf!;

  updateCliente(String id, String name, String email, String cpf) {
    _id = id;
    _name = name;
    _email = email;
    _cpf = cpf;
  }
}
