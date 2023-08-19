part of 'wishlist_bloc.dart';

sealed class WishlistEvent {}

final class WishlistRequested extends WishlistEvent {}

final class WishlistSetSelectedRequested extends WishlistEvent {}

final class WishlistSelectAllRequested extends WishlistEvent {}

final class WishlistRemoveSelectedRequested extends WishlistEvent {}
