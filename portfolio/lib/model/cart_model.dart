class ReviewCartModel {
  String cartId;
  String cartImage;
  String cartName;
  String cartPrice;
  int cartQuantity;
  String cartDescription;
  //var cartUnit;
  ReviewCartModel({
    required this.cartId,
    //required this.cartUnit,
    required this.cartImage,
    required this.cartName,
    required this.cartPrice,
    required this.cartQuantity,
    required this.cartDescription,
  });
}