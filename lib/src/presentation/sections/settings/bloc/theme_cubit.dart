import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<Brightness> {
  ThemeCubit() : super(Brightness.light);

  void changeTheme() {
    Brightness value = state == Brightness.light ? Brightness.dark : Brightness.light;
    emit(value);
  }

  @override
  Brightness fromJson(Map<String, dynamic> json) {
    if (json['brightness'] != null) {
      return Brightness.values[json['brightness'] as int];
    } else {
      return Brightness.light;
    }
  }

  @override
  Map<String, dynamic> toJson(Brightness state) {
    return <String, int>{'brightness': state.index};
  }
}
