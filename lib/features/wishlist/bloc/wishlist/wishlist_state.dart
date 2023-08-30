part of 'wishlist_bloc.dart';

sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistData extends WishlistState {
  WishlistData({
    required this.wishlistProducts,
  });

  final List<ProductItem> wishlistProducts;
}

final class WishlistFailure extends WishlistState {}
