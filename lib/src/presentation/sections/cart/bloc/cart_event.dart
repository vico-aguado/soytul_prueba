part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartsInitialized extends CartEvent {}

class CartsRefreshed extends CartEvent {}

class CartsAddProduct extends CartEvent {
  final Product product;

  CartsAddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class CartsDeleteProduct extends CartEvent {
  final Product product;

  CartsDeleteProduct(this.product);

  @override
  List<Object> get props => [product];
}

class CartsUpdateProduct extends CartEvent {
  final Product product;
  final int quantity;

  CartsUpdateProduct(this.product, this.quantity);

  @override
  List<Object> get props => [product];
}


class CartsOrderFinished extends CartEvent {}
