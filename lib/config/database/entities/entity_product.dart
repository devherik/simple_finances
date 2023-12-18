import 'package:flutter/foundation.dart';

class EntityProduct {
  String? _id;
  String? _description;
  List? _productSizes;

  EntityProduct({required String id, required String description})
      : _id = id,
        _description = description;

  @override
  String toString() {
    return '$_description: ${_productSizes!.length} tamanhos';
  }

  String getId() => _id!;
  String getDescription() => _description!;
  List getProductSizes() => _productSizes!;

  updateProduct(String id, String description) {
    _id = id;
    _description = description;
  }

  addProductSize(Map<String, dynamic> size) {
    _productSizes!.add(size);
    if (kDebugMode) {
      print(_productSizes);
    }
  }

  removeProductSize(int index) {
    _productSizes!.removeAt(index);
    if (kDebugMode) {
      print(_productSizes);
    }
  }

  updateProductSize(int index, Map<String, dynamic> size) {
    _productSizes!.removeAt(index);
    _productSizes!.insert(index, size);
    if (kDebugMode) {
      print(_productSizes);
    }
  }
}
