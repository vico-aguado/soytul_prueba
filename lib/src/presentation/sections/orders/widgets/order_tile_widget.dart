import 'package:flutter/material.dart';
import 'package:soytul/src/domain/models/cart_model.dart';

class OrderTileWidget extends StatelessWidget {
  const OrderTileWidget({Key key, this.cart}) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {

    int total =  cart.products.fold(0, (sum, element) => sum + element.quantity) ; 

    return Card(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Orden ${cart.id}"),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Productos: $total",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Center(child: 
                  cart.status == CartStatus.COMPLETED ?
                  Icon(Icons.check, color: Colors.green):
                  Icon(Icons.shopping_cart, color: Colors.blue)
                  
                  ))
              ],
            )));
  }
}
