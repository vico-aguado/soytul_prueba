import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soytul/src/domain/models/product_model.dart';
import 'package:soytul/src/presentation/widgets/nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: products.get(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (!snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  List<QueryDocumentSnapshot> data = snapshot.data.docs;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      var item = Product.fromMap(data[index].data());

                      return Text(item.sku);
                    },
                  );
                }

                return Text("loading");
              },
            ),
          ),
         
        ],
      ),
       bottomNavigationBar: NavBarWidget(currentIndex: 0)
    );
  }
}
