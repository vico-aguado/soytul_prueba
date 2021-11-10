import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:soytul/src/domain/models/product_model.dart';

abstract class ProductsNetworkClass {
  /// Obtiene toda la lista de productos que existen en la BD
  Future<List<Map<String, dynamic>>> getProducts();
}

class ProductsNetwork extends ProductsNetworkClass {
  final firabaseInstance = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      QuerySnapshot products = await FirebaseFirestore.instance.collection('products').get();
      return products.docs.map((e) => e.data()).toList();
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }
}

class ProductsLocalNetwork extends ProductsNetworkClass {
  @override
  Future<List<Map<String, dynamic>>> getProducts() {
    List<Map<String, dynamic>> _list = [];

    _list.add(Product(id: 1, name: "Producto 1", description: "Descripcion 1", image: "", quantity: 0,  sku: "001").toMap());

    return Future.value(_list);
  }
}
