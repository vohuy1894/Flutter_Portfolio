
import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/widgets/bottom_app_bar.dart';
import 'package:portfolio/model/cart_model.dart';
import 'cart_image_icon.dart';
import 'cart_title_price.dart';
import 'package:portfolio/model/product_model.dart';

class CartProductDetail extends StatelessWidget {
  const CartProductDetail({required this.product});

  final ReviewCartModel product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share),
                color: Colors.white,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                  color: Colors.white),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Text(
                    "Add To Cart",
                    style: TextStyle(color: primaryColor),
                  ))
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProductImageAndIcons(
                size: size,
                product: product,
              ),
              ProductTitleAndPrice(
                product: product,
              ),
              SizedBox(height: defaultPadding),
              ExpansionTile(
                title: Text(
                  "Description",
                  style: TextStyle(color: primaryColor),
                ),
                initiallyExpanded: true,
                iconColor: primaryColor,
                children: [
                  ListTile(
                      title: Text(
                          product.cartDescription
                        )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
