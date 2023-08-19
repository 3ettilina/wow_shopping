part of 'item_selection_bloc.dart';

class ItemSelectionState {
  ItemSelectionState({
    this.selectedItems = const <String>{},
  });

  final Set<String> selectedItems;

  bool isSelected(ProductItem item) {
    return selectedItems.contains(item.id);
  }
}
