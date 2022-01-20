import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/account.dart';
import 'package:portfolio/pages/cart/cart.dart';
class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountPage()));
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
  }
}