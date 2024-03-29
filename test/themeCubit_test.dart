import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:soytul/src/presentation/sections/settings/bloc/theme_cubit.dart';

class MockStorage extends Mock implements HydratedStorage {}

void main() {
  MockStorage storage;
  

  setUp(() async {
    storage = MockStorage();
    HydratedBloc.storage = storage;
    when(storage.write(any, any)).thenAnswer((_) async {});
    when(storage.read(any)).thenAnswer((_) => {'brightness': 0});
    when(storage.delete(any)).thenAnswer((_) async {});
    when(storage.clear()).thenAnswer((_) async {});
  });

  test('[ HydratedBloc ] => Storage getter returns correct storage instance', () {
    final storage = MockStorage();
    HydratedBloc.storage = storage;
    expect(HydratedBloc.storage, storage);
  });

  group("[ ThemeCubit ]", () {
    test("=> Initial call state ", () {
      final bloc = ThemeCubit();
      expect(bloc.state, Brightness.dark);
    });

    test('=> work properly', () {
      final themeCubit = ThemeCubit();
      expect(
        themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
        themeCubit.state,
      );
    });

    blocTest(
      "=> Initial test",
      build: () => ThemeCubit(),
      expect: [],
    );

    blocTest<ThemeCubit, Brightness>(
      "=> Change Theme test",
      build: () => ThemeCubit(),
      act: (bloc) => bloc.changeTheme(),
      expect: [Brightness.light],
    );

    blocTest<ThemeCubit, Brightness>(
      "=> Change Theme twice test",
      build: () => ThemeCubit(),
      act: (bloc) {
        bloc.changeTheme();
        bloc.changeTheme();
      },
      expect: [Brightness.light, Brightness.dark],
    );

    blocTest<ThemeCubit, Brightness>(
      "=> Get Brightness.dark test",
      build: () => ThemeCubit(),
      act: (bloc) {
        bloc.changeTheme();
        bloc.changeTheme();
      },
      skip: 1,
      expect: [Brightness.dark],
    );
  });
}
