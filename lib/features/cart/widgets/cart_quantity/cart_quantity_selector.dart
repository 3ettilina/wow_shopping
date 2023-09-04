import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_shopping/app/assets.dart';
import 'package:wow_shopping/app/theme.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/features/cart/widgets/cart_quantity/cart_quantity.dart';
import 'package:wow_shopping/models/cart_item.dart';
import 'package:wow_shopping/widgets/app_icon.dart';
import 'package:wow_shopping/widgets/common.dart';

class CartQuantitySelector extends StatelessWidget {
  const CartQuantitySelector({
    super.key,
    required this.item,
  });

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartQuantityCubit(cartRepo: context.cartRepo, item: item),
      child: const CartQuantitySelectorView(),
    );
  }
}

class CartQuantitySelectorView extends StatelessWidget {
  const CartQuantitySelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return BlocBuilder<CartQuantityCubit, CartQuantityState>(
      builder: (context, state) {
        final cubit = context.read<CartQuantityCubit>();
        return TextFieldTapRegion(
          child: Material(
            type: MaterialType.transparency,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: appButtonRadius,
              side: BorderSide(
                color: appTheme.appColor,
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: () => cubit.decreaseQuantity(),
                    child: Padding(
                      padding: leftPadding12 +
                          rightPadding8 +
                          verticalPadding4 +
                          verticalPadding2,
                      child: ValueListenableBuilder(
                        valueListenable: state.quantityController,
                        builder: (BuildContext context, TextEditingValue value,
                            Widget? child) {
                          return AppIcon(
                            iconAsset: state.item.quantity <= 1
                                ? Assets.iconRemove
                                : Assets.iconMinus,
                            color: appTheme.appColor,
                          );
                        },
                      ),
                    ),
                  ),
                  IntrinsicWidth(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 48.0),
                      child: TextField(
                        focusNode: state.quantityFocus,
                        controller: state.quantityController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: verticalPadding4,
                          isDense: true,
                        ),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        onTapOutside: (_) {
                          state.quantityFocus.unfocus();
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => cubit.increaseQuantity(),
                    child: Padding(
                      padding: leftPadding8 +
                          rightPadding12 +
                          verticalPadding4 +
                          verticalPadding2,
                      child: AppIcon(
                        iconAsset: Assets.iconAdd,
                        color: appTheme.appColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
