import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:soytul/src/domain/models/cart_model.dart';
import 'package:soytul/src/domain/models/product_model.dart';
import 'package:soytul/src/domain/repositories/cart_repository.dart';
import 'package:soytul/src/presentation/sections/cart/bloc/cart_bloc.dart';

class MockCartsRepository extends Mock implements CartRepository {}

void main() {
  CartRepository cartsRepository;
  Product productTest = Product(id: 1, sku: "0001", name: "Test", image: "", description: "", quantity: 1);
  Cart cartTest = Cart(id: 1, products: [], status: CartStatus.PENDING);

  setUp(() {
    cartsRepository = MockCartsRepository();
  });

  group("[ CartBloc ]", () {
    test("=> Initial call state ", () {
      CartBloc bloc = CartBloc(cartsRepository);
      expect(bloc.state, CartsInitial());
      bloc.close();
    });

    blocTest<CartBloc, CartState>(
      "=> Get correct data",
      build: () {
        when(cartsRepository.getCarts()).thenAnswer((_) {
          return Future<List<Cart>>.value([]);
        });

        return CartBloc(cartsRepository);
      },
      expect: [
        CartsLoading(),
        CartsLoaded(
          carts: [],
          cartPending: cartTest,
        )
      ],
    );

    blocTest<CartBloc, CartState>(
      "=> Refresh event test",
      build: () {
        when(cartsRepository.getCarts()).thenAnswer((_) {
          return Future<List<Cart>>.value([]);
        });

        return CartBloc(cartsRepository);
      },
      act: (bloc) => bloc.add(CartsRefreshed()),
      skip: 2,
      expect: [
        CartsLoading(),
        CartsLoaded(
          carts: [],
          cartPending: cartTest,
        )
      ],
    );

    Cart cartWithProducts = cartTest.copyWith(products: [productTest]);

    blocTest<CartBloc, CartState>(
      "=> Get products in cart pending",
      build: () {
        when(cartsRepository.getCarts()).thenAnswer((_) {
          return Future<List<Cart>>.value([cartWithProducts]);
        });

        return CartBloc(cartsRepository);
      },
      expect: [
        CartsLoading(),
        CartsLoaded(
          carts: [cartWithProducts],
          cartPending: cartWithProducts,
        )
      ],
    );

    Cart cartCompletedWithProducts = cartTest.copyWith(products: [productTest], status: CartStatus.COMPLETED);

    blocTest<CartBloc, CartState>(
      "=> Get products in cart completed",
      build: () {
        when(cartsRepository.getCarts()).thenAnswer((_) {
          return Future<List<Cart>>.value([cartCompletedWithProducts]);
        });

        return CartBloc(cartsRepository);
      },
      expect: [
        CartsLoading(),
        CartsLoaded(
          carts: [cartCompletedWithProducts],
          cartPending: cartTest.copyWith(id: 2),
        )
      ],
    );

    blocTest<CartBloc, CartState>(
      "=> Add Product event test",
      build: () {
        when(cartsRepository.getCarts()).thenAnswer((_) {
          return Future<List<Cart>>.value([]);
        });

        when(cartsRepository.addProductToCart(productTest, 1)).thenAnswer((_) {
          return Future.value(true);
        });

        return CartBloc(cartsRepository);
      },
      act: (bloc) => bloc.add(CartsAddProduct(productTest)),
      skip: 2,
      expect: [
        CartsLoading(),
        CartsLoaded(
          carts: [],
          cartPending: cartTest,
        )
      ],
    );

    blocTest<CartBloc, CartState>(
      "=> Update Product event test",
      build: () {
        when(cartsRepository.getCarts()).thenAnswer((_) {
          return Future<List<Cart>>.value([]);
        });

        when(cartsRepository.updateProductToCart(productTest, 1)).thenAnswer((_) {
          return Future.value(true);
        });

        return CartBloc(cartsRepository);
      },
      act: (bloc) => bloc.add(CartsUpdateProduct(productTest, 1)),
      skip: 2,
      expect: [
        CartsLoading(),
        CartsLoaded(
          carts: [],
          cartPending: cartTest,
        )
      ],
    );

    blocTest<CartBloc, CartState>(
      "=> Delete Product event test",
      build: () {
        when(cartsRepository.getCarts()).thenAnswer((_) {
          return Future<List<Cart>>.value([]);
        });

        when(cartsRepository.deleteProductToCart(productTest, 1)).thenAnswer((_) {
          return Future.value(true);
        });

        return CartBloc(cartsRepository);
      },
      act: (bloc) => bloc.add(CartsDeleteProduct(productTest)),
      skip: 2,
      expect: [
        CartsLoading(),
        CartsLoaded(
          carts: [],
          cartPending: cartTest,
        )
      ],
    );

    blocTest<CartBloc, CartState>(
      "=> Create Order event test",
      build: () {
        when(cartsRepository.getCarts()).thenAnswer((_) {
          return Future<List<Cart>>.value([]);
        });

        when(cartsRepository.createOrder(
          cartTest,
        )).thenAnswer((_) {
          return Future.value(true);
        });

        return CartBloc(cartsRepository);
      },
      act: (bloc) => bloc.add(CartsOrderFinished()),
      skip: 2,
      expect: [
        CartsLoading(),
        CartsLoaded(
          carts: [],
          cartPending: cartTest,
        )
      ],
    );
  });
}
