import 'package:flutter/foundation.dart';
import 'package:soytul/src/domain/models/cart_model.dart';
import 'package:soytul/src/domain/models/product_model.dart';
import 'package:soytul/src/domain/network/cart_network.dart';

class CartRepository {
  final CartNetworkClass network;

  CartRepository(this.network);

  /// Obtiene los carritos u órdenes pendientes y completadas.
  Future<List<Cart>> getCarts() async {
    try {
      List<Map<String, dynamic>> _carts = await network.getCarts();

      List<Cart> _cartsTMP = List<Cart>.from(_carts.map((e) => Cart.fromMap(e)).toList());

      for (Cart _cart in _cartsTMP) {
        List<Map<String, dynamic>> _products = await network.getProductsFromCart(_cart.id);

        for (var _product in _products) {
          List<Map<String, dynamic>> _productsID = await network.getProductFromId(_product['product_id']);
          if (_productsID.isNotEmpty) {
            Product _productObj = Product.fromMap(_productsID.first).copyWith(quantity: _product['quantity']);
            _cart.products.add(_productObj);
          }
        }
      }

      return _cartsTMP;
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

  /// Agrega un producto al carrito indicado
  Future<bool> addProductToCart(Product product, int idCart) async {
    try {
      bool _success = await network.addProductToCart(product, idCart);
      return _success;
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

  /// Modifica el producto correspondiente en el carrito indicado
  Future<bool> updateProductToCart(Product product, int idCart) async {
    try {
      bool _success = await network.updateProductToCart(product, idCart);
      return _success;
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

   /// Elimina el producto correspondiente en el carrito indicado
  Future<bool> deleteProductToCart(Product product, int idCart) async {
    try {
      bool _success = await network.deleteProductToCart(product, idCart);
      return _success;
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

  /// Finaliza el carrito correspondiente para marcarlo cómo `COMPLETED`
  Future<bool> createOrder(Cart cart) async {
    try {
      bool _success = await network.createCart(cart);
      return _success;
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

}
