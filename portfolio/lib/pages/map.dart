import 'package:flutter/material.dart';
import '/widgets/menu_drawer.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          title: Text('GiG'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
      );
}
