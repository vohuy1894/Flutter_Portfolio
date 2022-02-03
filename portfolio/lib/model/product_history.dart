import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/model/product_model.dart';

class ProductHistory {
  final List<Product>? viewedProduct;
  final List<Product>? purchasedProduct;
  ProductHistory({
    this.viewedProduct, this.purchasedProduct
  });
}