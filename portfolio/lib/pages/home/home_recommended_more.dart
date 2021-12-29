import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'home_recomended.dart';
import '/widgets/bottom_app_bar.dart';
import 'package:portfolio/pages/product_detail/product_detail.dart';
import 'package:portfolio/model/product_model.dart';


class HomeRecommendedMore extends StatelessWidget {
  const HomeRecommendedMore({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommended"),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SafeArea(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 433.0,),
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
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
              );
            }),
      ),
    );
  }
}
