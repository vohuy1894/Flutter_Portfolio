import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/widgets/bottom_app_bar.dart';

import 'product_image_icon.dart';
import 'product_title_price.dart';
import 'package:portfolio/model/product_model.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({required this.product});

  final Product product;

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
                          "A drink from the days of Prohibition, the revival of the Last Word — which combines gin, green chartreuse, Maraschino liqueur, and lime juice — has been credited to bartender Murray Stenson, who came across the drink in an old bar manual while working at Seattle’s Zig Zag Café in 2004.")),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     SizedBox(
              //       width: size.width / 2,
              //       height: 84,
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(20),
              //             ),
              //           ),
              //           primary: primaryColor,
              //         ),
              //         onPressed: () {},
              //         child: Text(
              //           "Buy Now",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16,
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: size.width / 2,
              //       height: 84,
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(20),
              //             ),
              //           ),
              //           primary: primaryColor,
              //         ),
              //         onPressed: () {},
              //         child: Text(
              //           "Description",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16,
              //           ),
              //         ),
              //       ),
              //     ),
              //     // Expanded(
              //     //   child: ElevatedButton(
              //     //     style: ElevatedButton.styleFrom(
              //     //       primary: ,
              //     //     ),
              //     //     onPressed: () {},
              //     //     child: Text("Description", style: TextStyle(color: Colors.black),),
              //     //   ),
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
