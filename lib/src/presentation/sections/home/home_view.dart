import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/presentation/sections/cart/bloc/cart_bloc.dart';
import 'package:soytul/src/presentation/sections/home/bloc/products_bloc.dart';
import 'package:soytul/src/presentation/widgets/alert_dialog_widget.dart';
import 'package:soytul/src/presentation/widgets/nav_bar.dart';
import 'package:soytul/src/presentation/widgets/product_tile_widget.dart';

/// Pantalla de la lista de productos
class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Productos",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (_, state) {
                      if (state is ProductsError) {
                        showAlertDialog(
                          context: context,
                          title: "¡Error!",
                          message: state.error,
                        );
                      }

                      if (state is ProductsLoaded) {
                        if (state.products.isEmpty) {
                          return Center(child: Text("Sin productos aún"));
                        }
                        return RefreshIndicator(
                          onRefresh: () async {
                            BlocProvider.of<ProductsBloc>(context).add(ProductsRefreshed());
                            await Future.delayed(Duration(milliseconds: 400));
                            BlocProvider.of<CartBloc>(context).add(CartsRefreshed());
                            await Future.delayed(Duration(milliseconds: 400));
                            return true;
                          },
                          child: ListView.builder(
                            itemCount: state.products.length,
                            itemBuilder: (_, index) {
                              var item = state.products[index];

                              return ProductTileWidget(
                                product: item,
                              );
                            },
                          ),
                        );
                      }

                      return Container();
                    },
                  )),
                ],
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (_, state) {
                if (state is CartsLoading) {
                  return Container(
                      color: Colors.black.withOpacity(0.6),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                }

                return Container(
                  height: 0,
                  width: 0,
                );
              },
            )
          ],
        ),
        bottomNavigationBar: NavBarWidget(currentIndex: 0));
  }
}
