import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/widgets/menu_drawer.dart';
import '/widgets/bottom_app_bar.dart';
import 'package:portfolio/global/global_color_const.dart';

import 'home_header.dart';
import 'home_recomended.dart';
import 'home_title_btn.dart';
import 'home_featured.dart';
import 'home_featured_more.dart';
import 'package:portfolio/pages/home/home_recommended_more.dart';
import 'package:portfolio/model/product_model.dart';
import 'package:portfolio/providers/product_provider.dart';
import 'package:portfolio/providers/test_product_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Database db;
  List<Product>? docs;
  initialise() {
    db = Database();
    db.initiliase();
    db.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductProvider productProvider = Provider.of(context);
    if (docs == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        drawer: MenuDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/menu_icon.svg",
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          backgroundColor: primaryColor,
          title: Text(
            'Hi Huy',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomeHeader(size: size),
              HomeTitleBtn(
                  title: "Recommended",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeRecommendedMore()));
                  }),
              HomeRecommended(
                products: docs!,
              ),
              HomeTitleBtn(title: "Featured", press: () {}),
              HomeFeatured(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomAppBar(),
      );
    }
  }
}
