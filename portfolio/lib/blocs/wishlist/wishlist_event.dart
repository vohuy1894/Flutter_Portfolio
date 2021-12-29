import 'dart:async';
import 'dart:developer' as developer;

import 'package:portfolio/blocs/wishlist/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WishlistEvent {
  Stream<WishlistState> applyAsync(
      {WishlistState currentState, WishlistBloc bloc});
  final WishlistRepository _wishlistRepository = WishlistRepository();
}

class UnWishlistEvent extends WishlistEvent {
  @override
  Stream<WishlistState> applyAsync({WishlistState? currentState, WishlistBloc? bloc}) async* {
    yield UnWishlistState(0);
  }
}

class LoadWishlistEvent extends WishlistEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadWishlistEvent';

  LoadWishlistEvent(this.isError);

  @override
  Stream<WishlistState> applyAsync(
      {WishlistState? currentState, WishlistBloc? bloc}) async* {
    try {
      yield UnWishlistState(0);
      await Future.delayed(const Duration(seconds: 1));
      _wishlistRepository.test(isError);
      yield InWishlistState(0, 'Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadWishlistEvent', error: _, stackTrace: stackTrace);
      yield ErrorWishlistState(0, _.toString());
    }
  }
}
