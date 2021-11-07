import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/app/router.dart';
import 'package:soytul/src/presentation/sections/settings/bloc/cubit/theme_cubit.dart';

class SoytulApp extends StatelessWidget {
  final AppRouter router;
  const SoytulApp({Key key, this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soytul Prueba',
      theme: ThemeData(brightness: themeCubit.state),
      initialRoute: "/",
      onGenerateRoute: router.generateRoute,
    );
  }
}
