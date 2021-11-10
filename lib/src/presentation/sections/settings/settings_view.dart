import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:soytul/src/presentation/sections/settings/bloc/theme_cubit.dart';
import 'package:soytul/src/presentation/widgets/nav_bar.dart';

/// Pantalla de la configuración de la app
class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: false);

    return Scaffold(
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tema seleccionado: "),
                      BlocBuilder<ThemeCubit, Brightness>(
                        builder: (context, state) {
                          return FlutterSwitch(
                            width: 70.0,
                            height: 40.0,
                            toggleSize: 30.0,
                            value: state != Brightness.light,
                            borderRadius: 30.0,
                            padding: 2.0,
                            activeToggleColor: Color(0xFF6E40C9),
                            inactiveToggleColor: Color(0xFF2F363D),
                            activeSwitchBorder: Border.all(
                              color: Color(0xFF3C1E70),
                              width: 4.0,
                            ),
                            inactiveSwitchBorder: Border.all(
                              color: Color(0xFFD1D5DA),
                              width: 4.0,
                            ),
                            activeColor: Color(0xFF271052),
                            inactiveColor: Colors.white,
                            activeIcon: Icon(
                              Icons.nightlight_round,
                              color: Color(0xFFF8E3A1),
                            ),
                            inactiveIcon: Icon(
                              Icons.wb_sunny,
                              color: Color(0xFFFFDF5D),
                            ),
                            onToggle: (val) {
                              themeCubit.changeTheme();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              )),
        ),
        bottomNavigationBar: NavBarWidget(currentIndex: 3));
  }
}
