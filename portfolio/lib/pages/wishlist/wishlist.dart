import 'package:flutter/material.dart';
import 'package:portfolio/pages/cart/cart.dart';
import 'package:portfolio/providers/cart_provider.dart';
import 'package:portfolio/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/model/product_model.dart';
import 'package:portfolio/pages/product_detail/product_detail.dart';
import 'package:portfolio/pages/home/home_recomended.dart';
import 'package:badges/badges.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishListPage> {
  late WishListProvider wishListProvider;
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    wishListProvider = Provider.of(context);
    wishListProvider.getWishlistData();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    _counter = reviewCartProvider.getReviewCartDataList.length;
    return Scaffold(
      //drawer: MenuDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Wish List',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Badge(
            position: BadgePosition.topEnd(top: 0, end: 3),
            animationDuration: Duration(milliseconds: 3000),
            animationType: BadgeAnimationType.slide,
            badgeContent: Text(
              _counter.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartPage()));
                }),
          ),
        ],
        elevation: 0,
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 470.0,
          ),
          padding: const EdgeInsets.only(
            right: 20.0,
          ),
          itemCount: wishListProvider.getWishlist.length,
          itemBuilder: (BuildContext context, int index) {
            Product data = wishListProvider.getWishlist[index];
            return ProductCard(
              product: data,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(product: data),
                  ),
                );
              },
              isWistList: true,
            );
          }),
    );
  }
}
