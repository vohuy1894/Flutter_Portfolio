import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/model/cart_model.dart';
import 'package:portfolio/model/product_model.dart';
class ProductTitleAndPrice extends StatelessWidget {
  const ProductTitleAndPrice({
    required this.product
  });

  final ReviewCartModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${product.cartName}\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: product.cartName,
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            "\$${product.cartPrice}",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: primaryColor),
          )
        ],
      ),
    );
  }
}