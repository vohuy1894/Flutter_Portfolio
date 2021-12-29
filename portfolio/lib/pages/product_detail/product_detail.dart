import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';

import 'product_image_icon.dart';
import 'product_title_price.dart';
import 'package:portfolio/model/product_model.dart';

class ProductDetail extends StatelessWidget {

  const ProductDetail({
    required this.product
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProductImageAndIcons(size: size, product: product,),
              ProductTitleAndPrice(
                  product: product,),
              SizedBox(height: defaultPadding),
              
              Row(
                children: <Widget>[
                  SizedBox(
                    width: size.width / 2,
                    height: 84,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                          ),
                        ),
                        primary: primaryColor,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Buy Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 2,
                    height: 84,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        primary: primaryColor,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Description",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       primary: ,
                  //     ),
                  //     onPressed: () {},
                  //     child: Text("Description", style: TextStyle(color: Colors.black),),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
