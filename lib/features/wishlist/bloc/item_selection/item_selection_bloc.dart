import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/models/product_item.dart';

part 'item_selection_event.dart';
part 'item_selection_state.dart';

class ItemSelectionBloc extends Bloc<ItemSelectionEvent, ItemSelectionState> {
  ItemSelectionBloc({required WishlistRepo wishlistRepo})
      : _wishlistRepo = wishlistRepo,
        super(ItemSelectionState()) {
    on<ItemSelectionEventSetSelectedItemRequested>(_onSelectItemRequested);
    on<ItemSelectionEventToggleSelectAllRequested>(_onSelectAllItemsRequested);
    on<ItemSelectionEventToggleRemoveAllSelectedRequested>(
        _onRemoveAllSelectedRequested);
  }

  final WishlistRepo _wishlistRepo;

  void _onSelectItemRequested(
    ItemSelectionEventSetSelectedItemRequested event,
    Emitter<ItemSelectionState> emit,
  ) {
    final selected = state.selectedItems;
    if (state.isSelected(event.selected)) {
      _wishlistRepo.removeToWishlist(event.selected.id);
      selected.remove(event.selected.id);
    } else {
      _wishlistRepo.addToWishlist(event.selected.id);
      selected.add(event.selected.id);
    }
    emit(ItemSelectionState(selectedItems: selected));
  }

  void _onSelectAllItemsRequested(
    ItemSelectionEventToggleSelectAllRequested event,
    Emitter<ItemSelectionState> emit,
  ) {
    final allSelected = event.allProducts.map((item) => item.id).toSet();
    emit(ItemSelectionState(selectedItems: allSelected));
  }

  void _onRemoveAllSelectedRequested(
    ItemSelectionEventToggleRemoveAllSelectedRequested event,
    Emitter<ItemSelectionState> emit,
  ) {
    for (final selected in state.selectedItems) {
      _wishlistRepo.removeToWishlist(selected);
    }
    emit(ItemSelectionState(selectedItems: {}));
  }
}
