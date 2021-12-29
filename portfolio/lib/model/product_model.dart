import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Product extends Equatable{
  final String name;
  final double price;
  final String basicUnit;
  final double taxPercentage;
  final String category;
  final String imageUrl;
  final bool isRecommended;
  final bool isPopular;
  const Product({required this.name, required this.price, required this.basicUnit, required this.taxPercentage, required this.category, required this.imageUrl, required this.isRecommended, required this.isPopular});
  @override
  List<Object> get props => [
    name,
    price,
    basicUnit,
    taxPercentage,
    category,
    imageUrl,
    isRecommended,
    isPopular
  ];


  static List<Product> products = [
    Product(
      name: "Cocktail",
      price: 200,
      basicUnit: "Oz",
      taxPercentage: 0.825,
      category: "Alcohol",
      imageUrl: "assets/images/drink1.jpg",
      isRecommended: true,
      isPopular:false,
    ),

     Product(
      name: "Mayday",
      price: 100,
      basicUnit: "Oz",
      taxPercentage: 0.825,
      category: "Alcohol",
      imageUrl: "assets/images/drink2.jpg",
      isRecommended: true,
      isPopular:false,
    ),

    Product(
      name: "Sunshine",
      price: 150,
      basicUnit: "Oz",
      taxPercentage: 0.825,
      category: "Alcohol",
      imageUrl: "assets/images/drink3.jpg",
      isRecommended: true,
      isPopular:false,
    ),

    Product(
      name: "Bramble",
      price: 149,
      basicUnit: "Oz",
      taxPercentage: 0.825,
      category: "Alcohol",
      imageUrl: "assets/images/drink4.jpg",
      isRecommended: true,
      isPopular:false,
    ),
  ];
}

