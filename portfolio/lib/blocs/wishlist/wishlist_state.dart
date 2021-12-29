import 'package:equatable/equatable.dart';

abstract class WishlistState extends Equatable {
  WishlistState(this.version);
 
  /// notify change state without deep clone state
  final int version;

  /// Copy object for use in action
  /// if need use deep clone
  WishlistState getStateCopy();

  WishlistState getNewVersion();

  @override
  List<Object> get props => [version];
}

/// UnInitialized
class UnWishlistState extends WishlistState {

  UnWishlistState(int version) : super(version);

  @override
  String toString() => 'UnWishlistState';

  @override
  UnWishlistState getStateCopy() {
    return UnWishlistState(0);
  }

  @override
  UnWishlistState getNewVersion() {
    return UnWishlistState(version+1);
  }
}

/// Initialized
class InWishlistState extends WishlistState {
  
  InWishlistState(int version, this.hello) : super(version);
 
  final String hello;

  @override
  String toString() => 'InWishlistState $hello';

  @override
  InWishlistState getStateCopy() {
    return InWishlistState(version, hello);
  }

  @override
  InWishlistState getNewVersion() {
    return InWishlistState(version+1, hello);
  }

  @override
  List<Object> get props => [version, hello];
}

class ErrorWishlistState extends WishlistState {
  ErrorWishlistState(int version, this.errorMessage): super(version);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorWishlistState';

  @override
  ErrorWishlistState getStateCopy() {
    return ErrorWishlistState(version, errorMessage);
  }

  @override
  ErrorWishlistState getNewVersion() {
    return ErrorWishlistState(version+1, 
    errorMessage);
  }

  @override
  List<Object> get props => [version, errorMessage];
}
