import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/domain/network/products_network.dart';
import 'package:soytul/src/domain/repositories/products_repository.dart';
import 'package:soytul/src/presentation/sections/cart/cart_view.dart';
import 'package:soytul/src/presentation/sections/home/bloc/products_bloc.dart';
import 'package:soytul/src/presentation/sections/home/home_view.dart';
import 'package:soytul/src/presentation/sections/orders/orders_view.dart';
import 'package:soytul/src/presentation/sections/settings/settings_view.dart';

class AppRouter {
  ProductsRepository _productsRepository;

  AppRouter() {
    //_productsRepository = ProductsRepository(ProductsLocalNetwork());
    _productsRepository = ProductsRepository(ProductsNetwork());
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/cart":
        return FadeRoute(widget: CartView(), name: '/cart');
        break;
      case "/orders":
        return FadeRoute(widget: OrdersView(), name: '/orders');
        break;
      case "/settings":
        return FadeRoute(widget: SettingsView(), name: '/settings');
        break;
      case "/":
      case "/home":
      default:
        return FadeRoute(
            widget: BlocProvider<ProductsBloc>(
              create: (context) => ProductsBloc(_productsRepository),
              child: HomeView(),
            ),
            name: '/');
    }
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget widget;
  final int duration;
  final String name;
  final Object arguments;

  @override
  Duration get transitionDuration => Duration(milliseconds: duration);

  FadeRoute({this.widget, this.duration = 300, @required this.name, this.arguments})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
              return FadeTransition(
                opacity: new Tween<double>(begin: 0, end: 1).animate(animation),
                child: child,
              );
            },
            settings: RouteSettings(name: name, arguments: arguments));
}
