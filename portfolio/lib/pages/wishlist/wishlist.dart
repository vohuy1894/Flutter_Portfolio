import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/widgets/menu_drawer.dart';
import '/widgets/bottom_app_bar.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/model/product_model.dart';
import 'package:portfolio/pages/product_detail/product_detail.dart';
import 'package:portfolio/pages/home/home_recomended.dart';

class WishListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //drawer: MenuDrawer(),
      appBar: AppBar(
      
        backgroundColor: primaryColor,
        title: const Text(
          'Wish List',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 433.0,),
            padding: const EdgeInsets.only(
              right:20.0,
              
            ),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                product: Product.products.elementAt(index),
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetail(product: Product.products.elementAt(index)),
                    ),
                  );
                },
                isWistList: true,
              );
            }),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}