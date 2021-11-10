import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/domain/models/product_model.dart';
import 'package:soytul/src/presentation/sections/cart/bloc/cart_bloc.dart';
import 'package:soytul/src/presentation/widgets/cart_number_stepper.dart';

import 'alert_dialog_widget.dart';

/// Widget para crear la vista de cada producto.
class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({
    Key key,
    @required this.product,
    this.isCart = false,
  }) : super(key: key);

  final Product product;
  final bool isCart;

  _addToCart(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(CartsAddProduct(product.copyWith(quantity: 1)));
  }

  _deleteFromCart(BuildContext context) {
    showAlertDialog(
      context: context,
      title: "¡Alerta!",
      message: "¿Deseas eliminar este producto de tu carrito?",
      titleButton1: "Sí",
      titleButton2: "No",
      height: 220,
      onTapButton1: () {
        BlocProvider.of<CartBloc>(context).add(CartsDeleteProduct(product));
      },
      onTapButton2: () {},
    );
  }

  _updateFromCart(BuildContext context, int quantity) {
    BlocProvider.of<CartBloc>(context).add(CartsUpdateProduct(product, quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(product.sku),
      child: Card(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 95,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.image,
                        width: 80,
                        height: 95,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }

                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
                            ),
                          );
                        },
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: isCart ? 10 : 12,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "SKU: " + product.sku,
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                !isCart
                    ? SizedBox(
                        width: 40,
                        height: 95,
                        child: IconButton(
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              _addToCart(context);
                            }),
                      )
                    : SizedBox(
                        width: 70,
                        height: 95,
                        child: Center(
                          child: CartStepper<int>(
                            count: product.quantity,
                            radius: Radius.circular(3),
                            size: 25,
                            didChangeCount: (count) {
                              if (count < 1) {
                                _deleteFromCart(context);
                              } else {
                                _updateFromCart(context, count);
                              }
                            },
                          ),
                        ))
              ],
            )),
      ),
      background: Container(),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        color: isCart ? Colors.redAccent : Colors.green,
        child: Icon(isCart ? Icons.delete : Icons.add_shopping_cart, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        if (isCart) {
          _deleteFromCart(context);
        } else {
          _addToCart(context);
        }
        return Future.value(false);
      },
      onDismissed: (direction) {},
    );
  }
}
