import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/common/bloc_states.dart';
import 'package:wow_shopping/features/cart/bloc/cart_bloc.dart';
import 'package:wow_shopping/features/cart/checkout_page.dart';
import 'package:wow_shopping/features/cart/widgets/cart_item.dart';
import 'package:wow_shopping/features/cart/widgets/cart_page_layout.dart';
import 'package:wow_shopping/features/cart/widgets/checkout_panel.dart';
import 'package:wow_shopping/widgets/app_button.dart';
import 'package:wow_shopping/widgets/common.dart';
import 'package:wow_shopping/widgets/top_nav_bar.dart';

@immutable
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc(cartRepo: context.cartRepo)
        ..add(CartItemsStreamUpdatesRequested()),
      child: _CartPageView(),
    );
  }
}

class _CartPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, AppState>(
      builder: (context, state) => switch (state) {
        InitialState() || LoadingState() => const Center(
            child: CircularProgressIndicator(),
          ),
        DataState() => Material(
            child: CartPageLayout(
              checkoutPanel: CheckoutPanel(
                onPressed: () {
                  Navigator.of(context).push(CheckoutPage.route());
                },
                label: 'Checkout',
              ),
              content: CustomScrollView(
                slivers: [
                  SliverTopNavBar(
                    title: state.data.isEmpty
                        ? const Text('No items in your cart')
                        : Text('${state.data.length} items in your cart'),
                    pinned: true,
                    floating: true,
                  ),
                  const SliverToBoxAdapter(
                    child: _DeliveryAddressCta(
                        // FIXME: onChangeAddress ?
                        ),
                  ),
                  for (final item in state.data) //
                    SliverCartItemView(
                      key: Key(item.product.id),
                      item: item,
                    ),
                ],
              ),
            ),
          ),
        FailureState() => ErrorWidget(Exception(state.errorMessage)),
      },
    );
  }
}

@immutable
class _DeliveryAddressCta extends StatelessWidget {
  const _DeliveryAddressCta();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding12 + verticalPadding16,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Delivery to '),
                      TextSpan(
                        // FIXME: replace with selected address name
                        text: 'Designer Techcronus',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalMargin4,
                // FIXME: replace with selected address
                Text(
                  '4/C Center Point,Panchvati, '
                  'Ellisbridge, Ahmedabad, Gujarat 380006',
                ),
              ],
            ),
          ),
          AppButton(
            onPressed: () {
              // FIXME open Delivery address screen
            },
            style: AppButtonStyle.outlined,
            label: 'Change',
          ),
        ],
      ),
    );
  }
}
