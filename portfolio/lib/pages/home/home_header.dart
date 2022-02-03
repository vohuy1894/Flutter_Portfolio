import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/model/product_model.dart';
import 'package:portfolio/pages/search.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class HomeHeader extends StatelessWidget {
  final Size size;
  const HomeHeader({
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    //final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      margin: EdgeInsets.only(bottom: defaultPadding),
      // It will cover 20% of our total height
      height: size.height * 0.1,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
              bottom: 36 + defaultPadding,
            ),
            height: size.height * 0.1 - 27,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
