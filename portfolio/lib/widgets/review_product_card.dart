import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/model/cart_model.dart';
import 'package:portfolio/providers/cart_provider.dart';
import 'package:portfolio/widgets/count_product.dart';
import 'package:provider/provider.dart';

class ReviewProductCard extends StatelessWidget {
  const ReviewProductCard(
      {required this.product,
      required this.press,
      this.isCart = false});
  final ReviewCartModel product;
  final VoidCallback press;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: defaultPadding,
        top: defaultPadding / 2,
        bottom: defaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: ClipRRect(
              child: Image.asset(product.cartImage.toString()),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "${product.cartName}\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: product.cartName.toUpperCase(),
                          style: TextStyle(
                            color: primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$${product.cartPrice}',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: primaryColor),
                  )
                ],
              ),
            ),
          ),
          isCart
              ? CountProduct(
                  productName: product.cartName,
                  //productUnit: "Oz",
                  productId: product.cartId,
                  productImage: product.cartImage,
                  productPrice: product.cartPrice,
                  productDescription: product.cartDescription,
                )
              : SizedBox(),
          Container(
              padding: const EdgeInsets.all(defaultPadding / 2),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        reviewCartProvider.reviewCartDataDelete(product.cartId);
                        final snackBar = SnackBar(content:  Text("${product.cartName} has been removed from your cart"), duration: const Duration(seconds: snackbarDuration),);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: primaryColor,
                      ),
                    ),
                  ])),
        ],
      ),
    );
  }
}
