import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/app/app.dart';
import 'package:soytul/src/app/router.dart';
import 'package:soytul/src/domain/network/cart_network.dart';
import 'package:soytul/src/domain/repositories/cart_repository.dart';
import 'package:soytul/src/presentation/sections/cart/bloc/cart_bloc.dart';
import 'package:soytul/src/presentation/sections/settings/bloc/theme_cubit.dart';

class Base extends StatelessWidget {
  Base({Key key}) : super(key: key);

  final _router = AppRouter();
  final CartRepository _cartRepository = CartRepository(CartsNetwork());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(_cartRepository),
        ),
      ],
      child: SoytulApp(
        router: _router,
      ),
    );
  }
}
