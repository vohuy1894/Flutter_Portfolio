import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/model/product_model.dart';
import 'package:portfolio/providers/cart_provider.dart';
import 'package:portfolio/providers/product_provider.dart';
import 'package:provider/provider.dart';

class CountProduct extends StatefulWidget {
  String productName;
  String productImage;
  String productId;
  int productPrice;
  String productDescription;
  //var productUnit;
  CountProduct({
    required this.productName,
    //this.productUnit,
    required this.productId,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
  });

  @override
  _CountProductState createState() => _CountProductState();
}

class _CountProductState extends State<CountProduct> {
  int count = 1;
  bool isTrue = false;
  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isTrue = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();

    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
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
          InkWell(
            onTap: () {
              if (count == 1) {
                reviewCartProvider.reviewCartDataDelete(widget.productId);
              } else if (count > 1) {
                setState(() {
                  count--;
                });
                reviewCartProvider.updateReviewCartData(
                  cartId: widget.productId,
                  cartImage: widget.productImage,
                  cartName: widget.productName,
                  cartPrice: widget.productPrice,
                  cartDescription: widget.productDescription,
                  cartQuantity: count,
                );
              
              }
            },
            child: Icon(
              Icons.remove,
              color: primaryColor,
            ),
          ),
          Text(
            '$count',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              setState(() {
                count++;
              });
              reviewCartProvider.updateReviewCartData(
                cartId: widget.productId,
                cartImage: widget.productImage,
                cartName: widget.productName,
                cartPrice: widget.productPrice,
                cartDescription: widget.productDescription,
                cartQuantity: count,
              );
            },
            child: Icon(
              Icons.add,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
