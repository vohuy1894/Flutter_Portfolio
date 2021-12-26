import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/product_detail/product_detail.dart';

class HomeRecommended extends StatelessWidget {
  const HomeRecommended({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          RecomendPlantCard(
            image: "assets/images/drink1.jpg",
            title: "Mound Bar",
            country: "Rum",
            price: 240,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductDetail(title: "Mound Bar", mainIngredient: "Rum", price: 240),
                ),
              );
            },
          ),
          RecomendPlantCard(
            image: "assets/images/drink2.jpg",
            title: "Mayday",
            country: "Rum",
            price: 140,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductDetail(title: "Mayday", mainIngredient: "Rum", price: 140),
                ),
              );
            },
          ),
          RecomendPlantCard(
            image: "assets/images/drink3.jpg",
            title: "Mind Eraser",
            country: "Vodka",
            price: 40,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductDetail(title: "Mind Eraser", mainIngredient: "Vodka", price: 40),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
  });

  final String image, title, country;
  final int price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: defaultPadding,
        top: defaultPadding / 2,
        bottom: defaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          ClipRRect(
            child: Image.asset(image),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: primaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(
                            color: primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: primaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
