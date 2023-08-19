import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/features/home/top_selling/bloc/top_selling_bloc.dart';
import 'package:wow_shopping/features/home/top_selling/widgets/sliver_top_selling_list.dart';

class SliverTopSellingSection extends StatelessWidget {
  const SliverTopSellingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopSellingBloc>(
      create: (_) => TopSellingBloc(productsRepo: context.productsRepo),
      child: const SliverTopSellingView(),
    );
  }
}

@immutable
class SliverTopSellingView extends StatelessWidget {
  const SliverTopSellingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopSellingBloc, TopSellingState>(
      builder: (context, state) {
        if (state is TopSellingInitial) {
          return const Text('Checking state with if statement');
        }
        return switch (state) {
          TopSellingInitial() => const SizedBox.shrink(),
          TopSellingLoading() => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          TopSellingFailure() => Text(state.error),
          TopSellingData() => SliverTopSellingList(
              products: state.topSellingProducts,
            ),
        };
      },
    );
  }
}
