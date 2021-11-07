import 'package:flutter/material.dart';
import 'package:soytul/src/presentation/sections/home/home_view.dart';

class SoytulApp extends StatelessWidget {
  const SoytulApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soytul Prueba',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
    );
  }
}
