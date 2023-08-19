part of 'wishlist_bloc.dart';

sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistData extends WishlistState {
  WishlistData({
    required this.wishlistProducts,
    this.selectedItems = const [],
  });

  final List<ProductItem> wishlistProducts;
  final List<String> selectedItems;

  bool isSelected(ProductItem item) {
    return selectedItems.contains(item.id);
  }
}

final class WishlistFailure extends WishlistState {}
