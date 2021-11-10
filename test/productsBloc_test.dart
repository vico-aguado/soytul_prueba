import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soytul/src/domain/models/product_model.dart';
import 'package:soytul/src/domain/repositories/products_repository.dart';
import 'package:soytul/src/presentation/sections/home/bloc/products_bloc.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  ProductsRepository productsRepository;

  setUp(() {
    productsRepository = MockProductsRepository();
  });

  group("[ ProductsBloc ]", () {
    test("=> Initial call state ", () {
      ProductsBloc bloc = ProductsBloc(productsRepository);
      expect(bloc.state, ProductsInitial());
      bloc.close();
    });

    blocTest(
      "=> Get correct data",
      build: () {
        when(productsRepository.getProducts()).thenAnswer((_) {
          return Future<List<Product>>.value([]);
        });

        return ProductsBloc(productsRepository);
      },
      expect: [ProductsLoaded(products: [])],
    );

    blocTest<ProductsBloc, ProductsState>(
      "=> Refresh event test",
      build: () {
        when(productsRepository.getProducts()).thenAnswer((_) {
          return Future<List<Product>>.value([]);
        });

        return ProductsBloc(productsRepository);
      },
      act: (bloc) => bloc.add(ProductsRefreshed()),
      expect: [ProductsLoaded(products: [])],
    );
  });
}
