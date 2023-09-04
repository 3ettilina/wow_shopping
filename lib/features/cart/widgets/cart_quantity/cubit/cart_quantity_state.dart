part of 'cart_quantity_cubit.dart';

enum CartQuantityStatus { initial, data }

class CartQuantityState {
  CartQuantityState({
    required this.item,
    TextEditingController? controller,
    FocusNode? focus,
  }) {
    quantityController = controller ??
        TextEditingController(
          text: item.quantity.toString(),
        );
    quantityFocus = focus ?? FocusNode();
  }

  final CartItem item;

  late TextEditingController quantityController;
  late FocusNode quantityFocus;

  CartQuantityState copyWith({
    CartItem? item,
    TextEditingController? quantityController,
    FocusNode? quantityFocus,
  }) =>
      CartQuantityState(
        item: item ?? this.item,
        controller: quantityController ?? this.quantityController,
        focus: quantityFocus ?? this.quantityFocus,
      );
}
