import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:soytul/src/domain/models/product_model.dart';
import 'package:soytul/src/domain/repositories/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this.repository) : super(ProductsInitial()) {
    this.add(ProductsInitialized());
  }

  final ProductsRepository repository;

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is ProductsInitialized) {
      yield await _loadProducts();
    }

    if (event is ProductsRefreshed) {
      yield await _loadProducts();
    }
  }

  Future<ProductsState> _loadProducts() async {
    try {
      List<Product> _products = await repository.getProducts();
      return ProductsLoaded(products: _products);
    } catch (e) {
      print(e);
      return ProductsError(e);
    }
  }
}
