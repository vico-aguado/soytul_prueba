import 'package:flutter/material.dart';
import 'package:soytul/src/presentation/widgets/nav_bar.dart';

class CartView extends StatelessWidget {
  const CartView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: NavBarWidget(currentIndex: 1));
  }
}
