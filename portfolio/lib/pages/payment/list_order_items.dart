import 'package:flutter/material.dart';
import 'package:portfolio/model/cart_model.dart';
import 'package:portfolio/providers/cart_provider.dart';

class ListOrderItem extends StatelessWidget {
  final ReviewCartModel reviewCartModel;
  const ListOrderItem({Key? key, required this.reviewCartModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(reviewCartModel.cartImage),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            reviewCartModel.cartName,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            "Total: \$${reviewCartModel.cartPrice}",
          ),
        ],
      ),
      subtitle: Text("Quantity: ${reviewCartModel.cartQuantity.toString()}" ),
    );
  }
}
