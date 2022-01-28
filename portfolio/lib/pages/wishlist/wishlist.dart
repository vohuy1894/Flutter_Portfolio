import 'package:flutter/material.dart';
import 'package:portfolio/pages/cart/cart.dart';
import 'package:portfolio/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import '/widgets/bottom_app_bar.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/model/product_model.dart';
import 'package:portfolio/pages/product_detail/product_detail.dart';
import 'package:portfolio/pages/home/home_recomended.dart';

class WishListPage extends StatefulWidget{
  @override
  _WishListState createState() => _WishListState();
}
class _WishListState extends State<WishListPage> {
  late WishListProvider wishListProvider;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    wishListProvider = Provider.of(context);
    wishListProvider.getWishlistData();
    return Scaffold(
      //drawer: MenuDrawer(),
      appBar: AppBar(
      
        backgroundColor: primaryColor,
        title: const Text(
          'Wish List',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
      icon: Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
      onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));})
        
    
        ],
        elevation: 0,
      ),
      body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 470.0,),
            padding: const EdgeInsets.only(
              right:20.0,
              
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
                      builder: (context) =>
                          ProductDetail(product: data),
                    ),
                  );
                },
                isWistList: true,
              );
            }),
      
    );
  }
}