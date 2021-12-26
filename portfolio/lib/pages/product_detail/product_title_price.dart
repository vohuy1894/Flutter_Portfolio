import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';

class ProductTitleAndPrice extends StatelessWidget {
  const ProductTitleAndPrice({
    required this.title,
    required this.mainIngredient,
    required this.price,
  });

  final String title, mainIngredient;
  final int price;

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
                  text: "$title\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: mainIngredient,
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
            "\$$price",
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