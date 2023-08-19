import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wow_shopping/models/product_item.dart';

part 'item_selection_event.dart';
part 'item_selection_state.dart';

class ItemSelectionBloc extends Bloc<ItemSelectionEvent, ItemSelectionState> {
  ItemSelectionBloc() : super(ItemSelectionState()) {
    on<ItemSelectionEventSetSelectedItemRequested>(_onSelectItemRequested);
  }

  void _onSelectItemRequested(
    ItemSelectionEventSetSelectedItemRequested event,
    Emitter<ItemSelectionState> emit,
  ) {
    final selected = state.selectedItems;
    if (state.isSelected(event.selected)) {
      selected.add(event.selected.id);
    } else {
      selected.remove(event.selected.id);
    }
    emit(ItemSelectionState(selectedItems: selected));
  }

  void _onRemoveAllSelectedRequested(
    ItemSelectionEventToggleRemoveAllSelectedRequested event,
    Emitter<ItemSelectionState> emit,
  ) {}
}
