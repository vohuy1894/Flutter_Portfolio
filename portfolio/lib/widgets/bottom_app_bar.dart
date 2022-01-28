import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/account.dart';
import 'package:portfolio/pages/cart/cart.dart';
import 'package:portfolio/pages/home/home.dart';
class CustomBottomAppBar extends StatefulWidget {
  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}
class _CustomBottomAppBarState extends State<CustomBottomAppBar>{
  final screens = [
    HomePage(),
    CartPage(),
    AccountPage()
  ];
  int _page = 0;
  int index = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        backgroundColor: Colors.black,
        index: 0,
        color: Colors.white,
        buttonBackgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          items:  <Widget> [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(
                Icons.home,
                //color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: Icon(
                Icons.shopping_cart,
                //color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountPage()));
              },
              icon: Icon(
                Icons.person,
                //color: Colors.white,
              ),
            ),
            
        ],
        onTap: (index) {
            setState(() {
              _page = index;
          });
        },
       letIndexChange: (index) => true,
      );
  }
}

 // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     IconButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, '/home');
        //       },
        //       icon: Icon(
        //         Icons.home,
        //         color: Colors.white,
        //       ),
        //     ),
        //     IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
        //       },
        //       icon: Icon(
        //         Icons.shopping_cart,
        //         color: Colors.white,
        //       ),
        //     ),
        //     IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountPage()));
        //       },
        //       icon: Icon(
        //         Icons.person,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ],
        // ),