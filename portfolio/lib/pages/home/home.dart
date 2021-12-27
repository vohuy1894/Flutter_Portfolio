import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/widgets/menu_drawer.dart';
import 'package:portfolio/global/global_color_const.dart';

import 'home_header.dart';
import 'home_recomended.dart';
import 'home_title_btn.dart';
import 'home_featured.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset("assets/icons/menu_icon.svg", color: primaryColor,),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Portfolio',
          style: TextStyle(color: primaryColor),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HomeHeader(size:size),
            HomeTitleBtn(title: "Recommended", press: (){}),
            HomeRecommended(),
            HomeTitleBtn(title: "Featured", press: (){}),
            HomeFeatured(),
      
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
