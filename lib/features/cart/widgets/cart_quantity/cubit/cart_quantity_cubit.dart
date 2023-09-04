import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wow_shopping/backend/cart_repo.dart';
import 'package:wow_shopping/models/cart_item.dart';

part 'cart_quantity_state.dart';

class CartQuantityCubit extends Cubit<CartQuantityState> {
  CartQuantityCubit({required CartRepo cartRepo, required CartItem item})
      : _cartRepo = cartRepo,
        super(CartQuantityState(item: item)) {
    state.quantityController.addListener(_onQuantityChanged);
  }

  final CartRepo _cartRepo;

  void increaseQuantity() {
    final currentQuantity = state.item.quantity;
    final newQuantity = currentQuantity + 1;
    final newCartItem = state.item.copyWith(quantity: newQuantity);
    _updateQuantityController(newQuantity);
    emit(state.copyWith(item: newCartItem));
  }

  void decreaseQuantity() {
    final currentQuantity = state.item.quantity;
    final newQuantity = currentQuantity - 1;
    final newCartItem = state.item.copyWith(quantity: newQuantity);
    if (newQuantity == 0) {
      _cartRepo.removeToCart(state.item.product.id);
    }
    _updateQuantityController(newQuantity);
    emit(state.copyWith(item: newCartItem));
  }

  void _onQuantityChanged() {
    final quantity = state.quantityController.text.trim();
    if (quantity.isNotEmpty) {
      final newCartItem = state.item.copyWith(quantity: int.parse(quantity));
      emit(state.copyWith(item: newCartItem));
      _cartRepo.updateQuantity(state.item.product.id, int.parse(quantity));
    }
  }

  void _updateQuantityController(int value) {
    final text = value.toString();
    final newControllerValue = state.quantityController.value.copyWith(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length),
      ),
    );
    state.quantityController.value = newControllerValue;
    emit(state.copyWith(quantityController: state.quantityController));
  }
}
