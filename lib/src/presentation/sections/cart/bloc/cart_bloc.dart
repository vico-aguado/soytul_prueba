import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:soytul/src/domain/models/cart_model.dart';
import 'package:soytul/src/domain/models/product_model.dart';
import 'package:soytul/src/domain/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.repository) : super(CartsInitial()) {
    this.add(CartsInitialized());
  }

  final CartRepository repository;

  Cart cartPending = Cart(id: 1, products: [], status: CartStatus.PENDING);

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    yield CartsLoading();
    if (event is CartsInitialized) {
      yield await _loadCarts();
    }

    if (event is CartsRefreshed) {
      yield await _loadCarts();
    }

    if (event is CartsAddProduct) {
      yield await _addProduct(event.product);
    }

    if (event is CartsDeleteProduct) {
      yield await _deleteProduct(event.product);
    }

    if (event is CartsUpdateProduct) {
      yield await _updateProduct(event.product, event.quantity);
    }

    if (event is CartsOrderFinished) {
      yield await _createOrder();
    }
  }

  Future<CartState> _createOrder() async {
    try {
       await repository.createOrder(cartPending);

      return await _loadCarts();
    } catch (e) {
      print(e);
      return CartsError(e);
    }
  }

  Future<CartState> _loadCarts() async {
    try {
      List<Cart> _carts = await repository.getCarts();
      List<Cart> _cartPending = _carts.where((element) => element.status == CartStatus.PENDING).toList();
      if (_cartPending.isNotEmpty) {
        cartPending = _cartPending.first;
      } else {
        if (_carts.isNotEmpty) {
          _carts.sort((a, b) => a.id.compareTo(b.id));
          cartPending = Cart(id: _carts.last.id + 1, products: [], status: CartStatus.PENDING);
        }
      }
      
      return CartsLoaded(carts: _carts, cartPending: cartPending, );
    } catch (e) {
      print(e);
      return CartsError(e);
    }
  }

  Future<CartState> _addProduct(Product product) async {
    try {
      bool isUpdate = false;

      for (var i = 0; i < cartPending.products.length; i++) {
        Product _product = cartPending.products[i];
        if (product.id == _product.id) {
          isUpdate = true;
          cartPending.products[i] = product = _product.copyWith(quantity: _product.quantity + 1);
        }
      }

      if (isUpdate) {
        await repository.updateProductToCart(product, cartPending.id);
      } else {
        await repository.addProductToCart(product, cartPending.id);
      }
      return await _loadCarts();
    } catch (e) {
      print(e);
      return CartsError(e);
    }
  }

  Future<CartState> _deleteProduct(Product product) async {
    try {
      for (var i = 0; i < cartPending.products.length; i++) {
        Product _product = cartPending.products[i];
        if (product.id == _product.id) {
          cartPending.products.removeAt(i);
        }
      }

      await repository.deleteProductToCart(product, cartPending.id);

      return await _loadCarts();
    } catch (e) {
      print(e);
      return CartsError(e);
    }
  }

  Future<CartState> _updateProduct(Product product, int quantity) async {
    try {
      for (var i = 0; i < cartPending.products.length; i++) {
        Product _product = cartPending.products[i];
        if (product.id == _product.id) {
          cartPending.products[i] = product = _product.copyWith(quantity: quantity);
        }
      }

      await repository.updateProductToCart(product, cartPending.id);

      return await _loadCarts();
    } catch (e) {
      print(e);
      return CartsError(e);
    }
  }
}
