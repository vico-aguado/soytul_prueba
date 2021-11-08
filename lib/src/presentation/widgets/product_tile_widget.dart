import 'package:flutter/material.dart';
import 'package:soytul/src/domain/models/product_model.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({
    Key key,
    @required this.product,
    this.isCart = false,
  }) : super(key: key);

  final Product product;
  final bool isCart;

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
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.image,
                        width: 80,
                        height: 80,
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
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.description,
                          style: TextStyle(fontSize: 12, color: Colors.blueGrey),
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
                  width: 40,
                  height: 80,
                  child: IconButton(
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.green,
                      ),
                      onPressed: () {}),
                )
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
        return Future.value(false);
      },
      onDismissed: (direction) {},
    );
  }
}
