import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/blocs/wishlist/index.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({
    required WishlistBloc wishlistBloc,
    Key? key,
  })  : _wishlistBloc = wishlistBloc,
        super(key: key);

  final WishlistBloc _wishlistBloc;

  @override
  WishlistScreenState createState() {
    return WishlistScreenState();
  }
}

class WishlistScreenState extends State<WishlistScreen> {
  WishlistScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
        bloc: widget._wishlistBloc,
        builder: (
          BuildContext context,
          WishlistState currentState,
        ) {
          if (currentState is UnWishlistState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorWishlistState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
           if (currentState is InWishlistState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.hello),
                  const Text('Flutter files: done'),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text('throw error'),
                      onPressed: () => _load(true),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
              child: CircularProgressIndicator(),
          );
          
        });
  }

  void _load([bool isError = false]) {
    widget._wishlistBloc.add(LoadWishlistEvent(isError));
  }
}
