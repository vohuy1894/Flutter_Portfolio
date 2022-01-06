import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';

class HomeFeatured extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          HomeFeaturedCard(
            image: "assets/images/drink1.jpg",
            press: () {},
          ),
          HomeFeaturedCard(
            image: "assets/images/drink2.jpg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class HomeFeaturedCard extends StatelessWidget {
  const HomeFeaturedCard({
    required this.image,
    required this.press,
  });
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(
          left: defaultPadding,
          top: defaultPadding / 2,
          bottom: defaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}