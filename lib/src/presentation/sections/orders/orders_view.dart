import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/presentation/sections/cart/bloc/cart_bloc.dart';
import 'package:soytul/src/presentation/sections/orders/widgets/order_tile_widget.dart';
import 'package:soytul/src/presentation/widgets/nav_bar.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key key}) : super(key: key);

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
            "Órdenes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: BlocBuilder<CartBloc, CartState>(
            builder: (_, state) {
              if (state is CartsLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<CartBloc>(context).add(CartsRefreshed());
                    await Future.delayed(Duration(milliseconds: 400));
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: state.carts.reversed.length,
                    itemBuilder: (_, index) {
                      var item = state.carts.reversed.toList()[index];

                      return OrderTileWidget(
                        cart: item,
                      );
                    },
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ))
        ])),
        bottomNavigationBar: NavBarWidget(currentIndex: 2));
  }
}
