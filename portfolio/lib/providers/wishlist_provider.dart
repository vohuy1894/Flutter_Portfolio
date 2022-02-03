import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio/model/product_model.dart';

class WishListProvider extends ChangeNotifier {
  addWishlistData({
    required String wishlistId,
    required String wishListName,
    required String wishListPrice,
    required String wishListImage,
    required String wishListDescription,
    required String wishListCategory,
  }) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Your WishList")
        .doc(wishlistId)
        .set({
      "wishListId": wishlistId,
      "wishListName": wishListName,
      "wishListImage": wishListImage,
      "wishListPrice": wishListPrice,
      "wishListDescription": wishListDescription,
      "wishListCategory": wishListCategory,
      "wishList": true,
    });
  }

  List<Product> wishList = [];

  getWishlistData() async{
    List<Product> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance.collection("WishList").doc(FirebaseAuth.instance.currentUser!.uid).collection("Your WishList").get();
    value.docs.forEach((element) {
      Product product = Product(name: element.get("wishListName"), price: element.get("wishListPrice"), imageUrl: element.get("wishListImage"), description: element.get("wishListDescription"), category: element.get("wishListCategory"), productId: element.get("wishListId"));
      newList.add(product);
    });
    wishList = newList;
    notifyListeners();
  }

  List<Product> get getWishlist{
    return wishList;
  }

  deleteWishlist(wishlistId){
    FirebaseFirestore.instance.collection("WishList").doc(FirebaseAuth.instance.currentUser!.uid).collection("Your WishList").doc(wishlistId).delete();
  }
}
