import 'package:portfolio/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier{
  late Product productModel;
  List<Product> search = [];
  productModels(QueryDocumentSnapshot element) {
    
    productModel = Product(
      imageUrl: element.get("productImage"),
      name: element.get("productName"),
      price: element.get("productPrice"),
      category: element.get("productCategory"),
      description: element.get("description"),
      // productId: element.get("productId"),
      // productUnit: element.get("productUnit"),
    );
    search.add(productModel);
  }

   List<Product> alcoholProductList = [];
  //late Product productModel;
  fetchProductList() async {
    List<Product> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance.collection("products").get();
    value.docs.forEach((element) {
      //productModel = Product(name: element.get("productName"), price: element.get("productImage"), category: element.get("productCategory"), imageUrl: element.get("productImage"), description: element.get("description"));
      productModels(element);
      newList.add(productModel);
    });

  alcoholProductList = newList;
  print(alcoholProductList);
  notifyListeners();
  }
  List<Product> get getAlcoholProductDataList {
    return alcoholProductList;
  }
  List<Product> get gerAllProductSearch {
    return search;
  }
}