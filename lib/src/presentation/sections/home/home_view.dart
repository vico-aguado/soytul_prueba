import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/presentation/sections/home/bloc/products_bloc.dart';
import 'package:soytul/src/presentation/widgets/nav_bar.dart';
import 'package:soytul/src/presentation/widgets/product_tile_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: SafeArea(
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
                  print(state);

                  if (state is ProductsError) {
                    print(state.error);
                  }

                  if (state is ProductsLoaded) {
                    if (state.products.isEmpty) {
                      return Center(child: Text("Sin productos aún"));
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<ProductsBloc>(context).add(ProductsRefreshed());
                        await Future.delayed(Duration(milliseconds: 500));
                        return true;
                      },
                      child: ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (_, index) {
                          var item = state.products[index];

                          return ProductTileWidget(product: item);
                        },
                      ),
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              )),
            ],
          ),
        ),
        bottomNavigationBar: NavBarWidget(currentIndex: 0));
  }
}
