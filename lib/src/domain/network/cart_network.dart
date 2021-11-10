import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:soytul/src/domain/models/cart_model.dart';
import 'package:soytul/src/domain/models/product_model.dart';

abstract class CartNetworkClass {
  /// Obtiene los carritos u órdenes pendientes y completadas.
  Future<List<Map<String, dynamic>>> getCarts();
  /// Agrega un producto al carrito indicado
  Future<bool> addProductToCart(Product product, int idCart);
  /// Modifica el producto correspondiente en el carrito indicado
  Future<bool> updateProductToCart(Product product, int idCart);
  /// Elimina el producto correspondiente en el carrito indicado
  Future<bool> deleteProductToCart(Product product, int idCart);
  /// Obtiene los productos agregados del carrito indicado
  Future<List<Map<String, dynamic>>> getProductsFromCart(int idCart);
  /// Obtiene el producto corresponiente mediante el `ID` del producto
  Future<List<Map<String, dynamic>>> getProductFromId(int idProduct);
  /// Finaliza el carrito correspondiente para marcarlo cómo `COMPLETED`
  Future<bool> createCart(Cart cart);
}

class CartsNetwork extends CartNetworkClass {
  final firabaseInstance = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getCarts() async {
    try {
      QuerySnapshot carts = await FirebaseFirestore.instance.collection('carts').get();
      return carts.docs.map((e) => e.data()).toList();
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

  @override
  Future<bool> addProductToCart(Product product, int idCart) async {
    try {
      CollectionReference cartsReference = FirebaseFirestore.instance.collection('carts');
      QuerySnapshot cart = await cartsReference.where("id", isEqualTo: idCart).get();

      if (cart.docs.isEmpty) {
        await cartsReference.add({'id': idCart, 'status': CartStatus.PENDING.index});
      }

      CollectionReference productCartsReference = FirebaseFirestore.instance.collection('product_carts');
      await productCartsReference.add({'quantity': product.quantity, 'product_id': product.id, 'cart_id': idCart});

      return true;
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getProductsFromCart(int idCart) async {
    try {
      CollectionReference productCartsReference = FirebaseFirestore.instance.collection('product_carts');
      QuerySnapshot products = await productCartsReference.where("cart_id", isEqualTo: idCart).get();
      return products.docs.map((e) => e.data()).toList();
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getProductFromId(int idProduct) async {
    try {
      CollectionReference productsReference = FirebaseFirestore.instance.collection('products');
      QuerySnapshot products = await productsReference.where("id", isEqualTo: idProduct).get();
      return products.docs.map((e) => e.data()).toList();
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

  @override
  Future<bool> updateProductToCart(Product product, int idCart) async {
    try {
      CollectionReference productCartsReference = FirebaseFirestore.instance.collection('product_carts');
      QuerySnapshot query = await productCartsReference.where("product_id", isEqualTo: product.id).where("cart_id", isEqualTo: idCart).get();

      if (query.docs.isNotEmpty) {
        String itemId = query.docs.first.id;
        DocumentReference document = productCartsReference.doc(itemId);
        await document.set({"quantity": product.quantity}, SetOptions(merge: true));
      }

      return true;
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

  @override
  Future<bool> deleteProductToCart(Product product, int idCart) async {
    try {
      CollectionReference productCartsReference = FirebaseFirestore.instance.collection('product_carts');
      QuerySnapshot query = await productCartsReference.where("product_id", isEqualTo: product.id).where("cart_id", isEqualTo: idCart).get();

      if (query.docs.isNotEmpty) {
        String itemId = query.docs.first.id;
        DocumentReference document = productCartsReference.doc(itemId);
        await document.delete();
      }

      return true;
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }

  @override
  Future<bool> createCart(Cart cart) async {
    try {
      CollectionReference cartsReference = FirebaseFirestore.instance.collection('carts');
      QuerySnapshot query = await cartsReference.where("id", isEqualTo: cart.id).get();

      if (query.docs.isNotEmpty) {
        String itemId = query.docs.first.id;
        DocumentReference document = cartsReference.doc(itemId);
        await document.set({"status": CartStatus.COMPLETED.index}, SetOptions(merge: true));
      }

      return true;
    } catch (e) {
      debugPrint(e);
      rethrow;
    }
  }
}

class CartsLocalNetwork extends CartNetworkClass {
  @override
  Future<List<Map<String, dynamic>>> getCarts() {
    List<Map<String, dynamic>> _list = [];

    _list.add(Cart(
      id: 1,
      products: [],
      status: CartStatus.PENDING,
    ).toMap());

    return Future.value(_list);
  }

  @override
  Future<bool> addProductToCart(Product product, int idCart) {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getProductsFromCart(int idCart) {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getProductFromId(int idProduct) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProductToCart(Product product, int idCart) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteProductToCart(Product product, int idCart) {
    throw UnimplementedError();
  }

  @override
  Future<bool> createCart(Cart cart) {
    throw UnimplementedError();
  }
}
