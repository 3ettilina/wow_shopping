import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_shopping/features/connection_monitor/connection_monitor.dart';
import 'package:wow_shopping/features/main/cubit/main_cubit.dart';
import 'package:wow_shopping/features/main/widgets/bottom_nav_bar.dart';

export 'package:wow_shopping/models/nav_item.dart';

@immutable
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static Route<void> route() {
    return PageRouteBuilder(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) {
        return FadeTransition(
          opacity: animation,
          child: const MainScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainCubit(),
      child: const MainView(),);
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNav = context.select((MainCubit cubit) => cubit.state.selected,);
    return SizedBox.expand(
      child: Material(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ConnectionMonitor(
                    child: IndexedStack(
                      index: selectedNav.index,
                      children: [
                        for (final item in NavItem.values) //
                          item.builder(),
                      ],
                    ),
                  ),
                ),
                BottomNavBar(
                  onNavItemPressed: context.read<MainCubit>().gotoSection,
                  selected: selectedNav,
                ),
              ],
        ),
      ),
    );
  }
}
