import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wow_shopping/backend/cart_repo.dart';
import 'package:wow_shopping/common/bloc_states.dart';
import 'package:wow_shopping/models/cart_item.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, AppState> {
  CartBloc({
    required CartRepo cartRepo,
  })  : _cartRepo = cartRepo,
        super(InitialState()) {
    on<CartItemsStreamUpdatesRequested>(_onCartItemsStreamUpdatesRequested);
    on<CartItemIncreaseQuantityRequested>(_onCartItemIncreaseQuantityRequested);
    on<CartItemDecreaseQuantityRequested>(_onCartItemDecreaseQuantityRequested);
    on<CartItemRemoveRequested>(_onCartItemRemoveRequested);
  }

  final CartRepo _cartRepo;

  Future<void> _onCartItemsStreamUpdatesRequested(
    CartItemsStreamUpdatesRequested event,
    Emitter<AppState> emit,
  ) async {
    print('Fetching cart items');
    emit(LoadingState());
    await emit.forEach(_cartRepo.streamCartItems,
        onData: (items) => DataState<List<CartItem>>(data: items),
        onError: (error, stacktrace) => FailureState(
            errorMessage: 'Something went wrong while fetching card items.'));
  }

  void _onCartItemIncreaseQuantityRequested(
    CartItemIncreaseQuantityRequested event,
    Emitter<AppState> emit,
  ) {
    final currentQuantity = _cartRepo.getQuantity(event.item.product.id);
    _cartRepo.updateQuantity(event.item.product.id, currentQuantity + 1);
  }

  void _onCartItemDecreaseQuantityRequested(
    CartItemDecreaseQuantityRequested event,
    Emitter<AppState> emit,
  ) {
    final currentQuantity = _cartRepo.getQuantity(event.item.product.id);
    if (currentQuantity == 1) {
      add(CartItemRemoveRequested(item: event.item));
    } else {
      _cartRepo.updateQuantity(event.item.product.id, currentQuantity - 1);
    }
  }

  void _onCartItemRemoveRequested(
    CartItemRemoveRequested event,
    Emitter<AppState> emit,
  ) {
    _cartRepo.removeToCart(event.item.product.id);
  }
}
