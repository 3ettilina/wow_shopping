import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wow_shopping/features/main/main_screen.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void gotoSection(NavItem item) {
    emit(MainState(selected: item));
  }
}
