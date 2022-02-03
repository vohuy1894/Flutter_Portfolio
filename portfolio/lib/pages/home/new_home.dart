import 'package:badges/badges.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/google_ad/fluid_example.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:portfolio/pages/account.dart';
import 'package:portfolio/pages/cart/cart.dart';
import 'package:portfolio/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:portfolio/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  int selectedpage = 0;
  final screens = [HomePage(), CartPage(), AccountPage()];
  bool isProductInCart = false;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    if(reviewCartProvider.getReviewCartDataList.length > 0)
    {
      setState(() {
        isProductInCart = true;
      });  
    }else{
      setState(() {
        isProductInCart = false;
      }); 
    }
    return SafeArea(
      child: Scaffold(
        body: PageTransitionSwitcher(
          duration: Duration(milliseconds: 1000),
          transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: screens[selectedpage],
        ),//screens[selectedpage],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: primaryColor.withOpacity(0.4),
          index: 0,
          color: Colors.white,
          buttonBackgroundColor: primaryColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          items: <Widget>[
            Icon(
              Icons.home,
              //color: Colors.white,
            ),
            isProductInCart ? 
             Badge(
            shape: BadgeShape.circle,
            position: BadgePosition.topEnd(top: -3, end: 0),
            borderRadius: BorderRadius.circular(100),
            child: Icon(Icons.shopping_cart,)
            ):
            Icon(
              Icons.shopping_cart,
              //color: Colors.white,
            ),
           
            Icon(
              Icons.person,
              //color: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              selectedpage = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
