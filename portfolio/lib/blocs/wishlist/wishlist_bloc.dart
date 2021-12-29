import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:portfolio/blocs/wishlist/index.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  // todo: check singleton for logic in project
  // use GetIt for DI in projct
  static final WishlistBloc _wishlistBlocSingleton = WishlistBloc._internal();
  factory WishlistBloc() {
    return _wishlistBlocSingleton;
  }
  
  WishlistBloc._internal(): super(UnWishlistState(0)){
    on<WishlistEvent>((event, emit) {
      return emit.forEach<WishlistState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'WishlistBloc', error: error, stackTrace: stackTrace);
          return ErrorWishlistState(0, error.toString());
        },
      );
    });
  }
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  WishlistState get initialState => UnWishlistState(0);

}
