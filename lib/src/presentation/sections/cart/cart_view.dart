import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/presentation/sections/cart/bloc/cart_bloc.dart';
import 'package:soytul/src/presentation/widgets/nav_bar.dart';
import 'package:soytul/src/presentation/widgets/product_tile_widget.dart';

class CartView extends StatelessWidget {
  const CartView({Key key}) : super(key: key);

  _createCart(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(CartsOrderFinished());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      body: SafeArea(
          child: Column(children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Carrito",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocBuilder<CartBloc, CartState>(builder: (_, state) {
           

            if (state is CartsError) {
              print(state.error);
            }

            if (state is CartsLoaded) {
              if (state.cartPending.products.isEmpty) {
                return Center(child: Text("Sin productos aún"));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<CartBloc>(context).add(CartsRefreshed());
                  await Future.delayed(Duration(milliseconds: 400));
                  return true;
                },
                child: ListView.builder(
                  itemCount: state.cartPending.products.length,
                  itemBuilder: (_, index) {
                    var item = state.cartPending.products[index];

                    return ProductTileWidget(
                      product: item,
                      isCart: true,
                    );
                  },
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
        ),
        BlocBuilder<CartBloc, CartState>(builder: (_, state) {
          
          if (state is CartsError) {
            print(state.error);
          }

          if (state is CartsLoaded) {
            if (state.cartPending.products.isNotEmpty) {
              return ElevatedButton(
                  onPressed: () {
                    _createCart(context);
                  },
                  child: Text("Crear orden"));
            }
          }

          return Container();
        }),
      ])),
      bottomNavigationBar: NavBarWidget(currentIndex: 1),
    );
  }
}
