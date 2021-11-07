import 'package:flutter/material.dart';
import 'package:soytul/src/presentation/widgets/nav_bar.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: NavBarWidget(currentIndex: 2));
  }
}
