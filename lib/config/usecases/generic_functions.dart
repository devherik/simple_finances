class GenericFunctions {
  List<Map<String, dynamic>> convertFutureList(
      Future<List<Map<String, dynamic>>> futureList) {
    List<Map<String, dynamic>> normalList = [];
    futureList.then((value) {
      normalList = value;
    });
    return normalList;
  }

  Map<String, dynamic> convertFutureMap(
      Future<Map<String, dynamic>> mapFuture) {
    Map<String, dynamic> normalMap = {};
    mapFuture.then((value) => normalMap = value);
    return normalMap;
  }
}
