import 'package:flutter/material.dart';
import 'package:portfolio/blocs/wishlist/index.dart';

class WishlistPage extends StatefulWidget {
  static const String routeName = '/wishlist';

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final _wishlistBloc = WishlistBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: WishlistScreen(wishlistBloc: _wishlistBloc),
    );
  }
}
