import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wow_shopping/features/main/main_screen.dart';

// To get access to the state we need this provided variable which uses
// StateNotifierProvider
final bottomNavbarProvider =
    StateNotifierProvider<BottomNavbarStateNotifier, NavItem>(
        (ref) => BottomNavbarStateNotifier());

// StateNotifier exposes de NavItem state
// This class notifies the state whenever it changes to the StateNotifierProvider
class BottomNavbarStateNotifier extends StateNotifier<NavItem> {
  BottomNavbarStateNotifier() : super(NavItem.home);

  void gotoSection(NavItem item) {
    state = item;
  }
}
