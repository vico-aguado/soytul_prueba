import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soytul/src/presentation/sections/settings/bloc/theme_cubit.dart';
import 'package:soytul/src/presentation/widgets/nav_bar/DotNavigationBarItem.dart';
import 'package:soytul/src/presentation/widgets/nav_bar/NavBars.dart';
import 'package:badges/badges.dart';

class NavBarWidget extends StatelessWidget {
  final int currentIndex;
  const NavBarWidget({Key key, this.currentIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, Brightness>(
      builder: (context, state) {
        return DotNavigationBar(
          backgroundColor: state == Brightness.light ? Colors.blue[100] : Colors.white,
          itemPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          currentIndex: currentIndex,
          dotIndicatorColor: Colors.transparent,
          unselectedItemColor: state == Brightness.light ? Colors.grey[200] : Colors.grey[300],
          onTap: (value) {
            String route = "/";
            switch (value) {
              case 0:
                route = "/";
                break;
              case 1:
                route = "/cart";
                break;
              case 2:
                route = "/orders";
                break;
              case 3:
                route = "/settings";
                break;
              default:
                route = "/";
            }
            Navigator.of(context).pushReplacementNamed(route);
          },
          items: [
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Colors.black,
            ),
            DotNavigationBarItem(
              icon: Badge(
                badgeContent: Text(
                  "5",
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
                child: Icon(Icons.shopping_cart),
              ),
              selectedColor: Colors.black,
            ),
            DotNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              selectedColor: Colors.black,
            ),
            DotNavigationBarItem(
              icon: Icon(Icons.settings),
              selectedColor: Colors.black,
            ),
          ],
        );
      },
    );
  }
}
