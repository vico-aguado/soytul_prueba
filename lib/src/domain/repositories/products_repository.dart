import 'package:flutter/foundation.dart';
import 'package:soytul/src/domain/models/product_model.dart';
import 'package:soytul/src/domain/network/products_network.dart';

class ProductsRepository {
  final ProductsNetworkClass network;

  ProductsRepository(this.network);

  /// Obtiene toda la lista de productos que existen en la BD
  Future<List<Product>> getProducts() async {
    try {
      List<Map<String, dynamic>> _products = await network.getProducts();
      return List<Product>.from(_products.map((e) => Product.fromMap(e)).toList());
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }
}
