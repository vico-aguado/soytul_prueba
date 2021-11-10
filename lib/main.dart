import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soytul/src/app/base.dart';
import 'package:soytul/src/app/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); // <-- Inicialización de Firebase

  Bloc.observer = MyBlocObserver(); // <-- Asignar el BlocObserver para la app

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(), // <-- Dónde se almacena el estado actual del bloc
  );

  runApp(Base());
}
