import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/app/app.dart';
import 'package:soytul/src/app/router.dart';
import 'package:soytul/src/presentation/sections/settings/bloc/cubit/theme_cubit.dart';

class Base extends StatelessWidget {
  Base({Key key}) : super(key: key);

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: SoytulApp(
        router: _router,
      ),
    );
  }
}
