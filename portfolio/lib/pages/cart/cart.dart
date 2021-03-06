import 'package:flutter/material.dart';
import 'package:portfolio/pages/cart_detail/cart_detail.dart';
import 'package:portfolio/pages/payment/payment_page.dart';
import 'package:portfolio/providers/cart_provider.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/widgets/review_product_card.dart';

class CartPage extends StatelessWidget {
  late ReviewCartProvider reviewCartProvider;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      backgroundColor: backgroundColor,
      //drawer: MenuDrawer(),
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text(
                "Subtotal: \$${reviewCartProvider.getTotalPrice().toStringAsFixed(2)}",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentPage(
                        amountToPay: reviewCartProvider.getTotalPrice(),
                        shippingCharge: 20.0,
                        discount: 10.0,
                        taxRate: 0.00875,
                      )));
            },
            child: Text("Proceed to check out"),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                primary: primaryColor),
          ),
          Expanded(
            child: SafeArea(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 503.0,
                  ),
                  padding: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  itemCount: reviewCartProvider.getReviewCartDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ReviewProductCard(
                      product: reviewCartProvider.getReviewCartDataList
                          .elementAt(index),
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartProductDetail(
                                product: reviewCartProvider
                                    .getReviewCartDataList
                                    .elementAt(index)),
                          ),
                        );
                      },
                      isCart: true,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
