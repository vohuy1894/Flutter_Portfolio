import 'package:flutter/material.dart';
import '/widgets/menu_drawer.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset("assets/images/menu_icon.png"),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          backgroundColor: Colors.white,
          title: Text('Portfolio', style: TextStyle(color: Colors.black),),
        ),
      );
}
