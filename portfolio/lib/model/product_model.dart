import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Product extends Equatable{
  final String name;
  final int price;
  final String imageUrl;
  final String description;
  final String category;
  const Product({required this.name, required this.price, required this.imageUrl, required this.description, required this.category});
  @override
  List<Object> get props => [
    name,
    price,
    imageUrl,
    description,
    category
  ];


  static List<Product> products = [
    Product(
      name: "Cocktail",
      price: 200,
      imageUrl: "assets/images/drink1.jpg",
       category: "Alcohol",
      description: "Fruity, bright, and crushable, this tiki cocktail was first invented in Hollywood, Calif. by bartender “Don The Beachcomber” in 1934. The cocktail consists of lime, lemon, and pineapple juices, passion fruit syrup, Angostura bitters, brown sugar, and three different types of rum (light, dark, and 151-proof)."
    ),

     Product(
      name: "Mayday",
      price: 100,
      imageUrl: "assets/images/drink2.jpg",
      category: "Alcohol",
      description: "The days of the Cosmo as the bartender’s piñata are over. You may even see crafted spins on this drink, but mostly, there’s indifference. If you need reminding, it’s vodka, triple sec, cranberry, and lime. Despite dropping 14 spots since 2017, the Cosmo has remained relevant, meaning it might be time to give the pink drink a second chance."
    ),

    Product(
      name: "Sunshine",
      price: 150,
      category: "Alcohol",
      imageUrl: "assets/images/drink3.jpg",
      description: "A drink from the days of Prohibition, the revival of the Last Word — which combines gin, green chartreuse, Maraschino liqueur, and lime juice — has been credited to bartender Murray Stenson, who came across the drink in an old bar manual while working at Seattle’s Zig Zag Café in 2004."
    ),

    Product(
      name: "Bramble",
      price: 149,
      category: "Alcohol",
      imageUrl: "assets/images/drink4.jpg",
      description: "Created by Dick Bradsell at Fred’s Club in London in the 1980s, the Bramble combines the bright, tangy berry flavors of gin and blackcurrant liqueur (Merlet Crème de Mures is a favorite of some bartenders, although crème de cassis works as well). It also includes gin, lemon, simple syrup, and plenty of crushed ice."
    ),
  ];
}

