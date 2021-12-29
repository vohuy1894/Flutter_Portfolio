import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/product_detail/product_detail.dart';
import 'package:portfolio/model/product_model.dart';

class HomeRecommended extends StatelessWidget {
  const HomeRecommended({Key? key, required this.products}) : super(key: key);
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          ProductCard(
            product: products.first,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ProductDetail(
                      product: products.first,),
                ),
              );
            },
          ),
          ProductCard(
            product: products.elementAt(1),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ProductDetail(
                      product: products.elementAt(1)),
                ),
              );
            },
          ),
          ProductCard(
            product: products.elementAt(2),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                      product: products.elementAt(2)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.press,
    this.isWistList = false
  });
  final Product product;
  final VoidCallback press;
  final bool isWistList;

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
          GestureDetector(
            onTap: press,
            child: ClipRRect(
              child: Image.asset(product.imageUrl.toString()),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: Colors.black, width: 1.0),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 10),
                //     blurRadius: 50,
                //     color: primaryColor.withOpacity(0.23),
                //   ),
                // ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "${product.name}\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: product.category.toUpperCase(),
                          style: TextStyle(
                            color: primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$${product.price}',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: primaryColor),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
             ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart,
                    color: primaryColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: primaryColor,
                  )),
              isWistList
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: primaryColor,
                  ))
              : SizedBox(),

            ]),
          ),
        ],
      ),
    );
  }
}
