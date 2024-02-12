class EntityUser {
  final String? _id;
  String? _name;
  List<dynamic> accountsLinked = [];

  EntityUser({required String id, required String name})
      : _id = id,
        _name = name;

  String getId() => _id!;
  String getName() => _name!;
  setName(String value) => _name = value;
}
