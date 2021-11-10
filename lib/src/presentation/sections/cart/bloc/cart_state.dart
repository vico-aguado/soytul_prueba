part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartsInitial extends CartState {}

class CartsLoading extends CartState {}

class CartsLoaded extends CartState {
  final List<Cart> carts;
  final Cart cartPending;
  const CartsLoaded({
    @required this.carts,
    @required this.cartPending,
  });

  @override
  List<Object> get props => [carts, cartPending];
}

class CartsError extends CartState {
  final error;

  const CartsError(this.error);
}
