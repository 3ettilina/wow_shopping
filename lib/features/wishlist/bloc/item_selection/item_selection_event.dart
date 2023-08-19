part of 'item_selection_bloc.dart';

@immutable
abstract class ItemSelectionEvent {}

class ItemSelectionEventSetSelectedItemRequested extends ItemSelectionEvent {
  ItemSelectionEventSetSelectedItemRequested({
    required this.selected,
  });

  final ProductItem selected;
}

class ItemSelectionEventToggleSelectAllRequested extends ItemSelectionEvent {
  ItemSelectionEventToggleSelectAllRequested();
}

class ItemSelectionEventToggleRemoveAllSelectedRequested
    extends ItemSelectionEvent {
  ItemSelectionEventToggleRemoveAllSelectedRequested();
}
