part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  const ProductsLoaded({
    @required this.products,
  });

  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  final error;

  const ProductsError(this.error);
}
