import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'product_icon.dart';
import 'package:portfolio/model/product_model.dart';
class ProductImageAndIcons extends StatelessWidget {
  const ProductImageAndIcons({
    required this.size,
    required this.product
  });

  final Size size;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 3),
      child: SizedBox(
        height: size.height * 0.8,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 3),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultPadding),
                        icon: Icon(Icons.arrow_back_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Spacer(),
                    IconCard(icon: "assets/icons/sun-icon.svg"),
                    IconCard(icon: "assets/icons/cloud-icon.svg"),
                    IconCard(icon: "assets/icons/drop-rain-icon.svg"),
                    IconCard(icon: "assets/icons/cloud-icon.svg"),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.8,
              width: size.width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(63),
                  bottomLeft: Radius.circular(63),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 60,
                    color: primaryColor.withOpacity(0.29),
                  ),
                ],
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.cover,
                  image: AssetImage(product.imageUrl),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}