import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/model/product_model.dart';

class WistList extends Equatable{
  final List<Product> products;
  
  const WistList({this.products = const <Product>[]});
  @override
  List<Object> get props => [
    products
  ];


}