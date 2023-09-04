part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartItemsStreamUpdatesRequested extends CartEvent {}

class CartItemRemoveRequested extends CartEvent {
  CartItemRemoveRequested({required this.item});

  final CartItem item;
}

class CartItemIncreaseQuantityRequested extends CartEvent {
  CartItemIncreaseQuantityRequested({
    required this.item,
  });

  final CartItem item;
}

class CartItemDecreaseQuantityRequested extends CartEvent {
  CartItemDecreaseQuantityRequested({
    required this.item,
  });

  final CartItem item;
}
