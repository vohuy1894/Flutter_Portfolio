import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:portfolio/model/product_model.dart';

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create({
    required String productName,
    required String productImage,
    required String productPrice,
    required String productCategory,
    required String productDescription,
    //var cartUnit,
  }) async {
    try {
      await firestore.collection("products").add({
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice,
        "productCategory": productCategory,
        "productDescription": productDescription,
        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("products").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Product>?> read() async {
    QuerySnapshot querySnapshot;
    List<Product> docs = [];
    try {
      querySnapshot = await firestore.collection('products').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs.toList()) {
          Product a = Product(
            imageUrl: element.get("productImage"),
            name: element.get("productName"),
            price: element.get("productPrice"),
            category: element.get("productCategory"),
            description: element.get("description"),
            productId: element.id,
          );
          docs.add(a);
        }
        return docs;
      }
    } on FirebaseException catch (e) {
      print(e);
    }
    //return docs;
  }

  Future<void> update({
    required String productId,
    String? productName,
    String? productImage,
    String? productPrice,
    String? productCategory,
    String? productDescription,
  }) async {
    try {
      await firestore.collection("products").doc(productId).update({
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice,
        "productCategory": productCategory,
        "productDescription": productDescription,
        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }
}
