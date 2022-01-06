import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/product_detail/product_detail.dart';
import 'package:portfolio/model/product_model.dart';
import 'package:portfolio/providers/cart_provider.dart';
import 'package:portfolio/providers/wishlist_provider.dart';
import 'package:portfolio/widgets/count_product.dart';
import 'package:provider/provider.dart';

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
                  builder: (context) => ProductDetail(
                    product: products.first,
                  ),
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
                  builder: (context) =>
                      ProductDetail(product: products.elementAt(1)),
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
                  builder: (context) =>
                      ProductDetail(product: products.elementAt(2)),
                ),
              );
            },
          ),
          ProductCard(
            product: products.elementAt(3),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetail(product: products.elementAt(3)),
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
  const ProductCard(
      {required this.product,
      required this.press,
      this.isWistList = false,
      this.isCart = false});
  final Product product;
  final VoidCallback press;
  final bool isWistList;
  final bool isCart;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    WishListProvider wishListProvider = Provider.of(context);
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
          isCart
              ? CountProduct(
                  productName: product.name,
                  //productUnit: "Oz",
                  productId: product.productId,
                  productImage: product.imageUrl,
                  productPrice: product.price,
                  productDescription: product.description,
                )
              : SizedBox(),
          Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: isWistList
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          isCart
                              ? IconButton(
                                  onPressed: () {
                                    wishListProvider.addWishlistData(
                                        wishlistId: product.productId,
                                        wishListName: product.name,
                                        wishListPrice: product.price,
                                        wishListImage: product.imageUrl,
                                        wishListDescription:
                                            product.description,
                                        wishListCategory: product.category);
                                    final snackBar = SnackBar(
                                      content: Text(
                                          "${product.name} has been added to your wish lists"),
                                      duration: const Duration(
                                          seconds: snackbarDuration),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: primaryColor,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    reviewCartProvider.addReviewCartData(
                                      cartId: product.productId,
                                      cartImage: product.imageUrl,
                                      cartName: product.name,
                                      cartPrice: product.price,
                                      cartDescription: product.description,
                                      cartQuantity: 1,
                                    );

                                    final snackBar = SnackBar(
                                      content: Text(
                                          "${product.name} has been added to your cart"),
                                      duration: const Duration(
                                          seconds: snackbarDuration),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: primaryColor,
                                  ),
                                ),
                          IconButton(
                            onPressed: () {
                              wishListProvider
                                  .deleteWishlist(product.productId);
                              final snackBar = SnackBar(
                                content: Text(
                                    "${product.name} has been removed from your wish lists"),
                                duration:
                                    const Duration(seconds: snackbarDuration),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              color: primaryColor,
                            ),
                          ),
                        ])
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          IconButton(
                            onPressed: () {
                              reviewCartProvider.addReviewCartData(
                                cartId: product.productId,
                                cartImage: product.imageUrl,
                                cartName: product.name,
                                cartPrice: product.price,
                                cartDescription: product.description,
                                cartQuantity: 1,
                              );

                              final snackBar = SnackBar(
                                content: Text(
                                    "${product.name} has been added to your cart"),
                                duration:
                                    const Duration(seconds: snackbarDuration),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: Icon(
                              Icons.shopping_cart,
                              color: primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              wishListProvider.addWishlistData(
                                  wishlistId: product.productId,
                                  wishListName: product.name,
                                  wishListPrice: product.price,
                                  wishListImage: product.imageUrl,
                                  wishListDescription: product.description,
                                  wishListCategory: product.category);
                              final snackBar = SnackBar(
                                content: Text(
                                    "${product.name} has been added to your wish lists"),
                                duration:
                                    const Duration(seconds: snackbarDuration),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: primaryColor,
                            ),
                          ),
                        ])),
        ],
      ),
    );
  }
}
