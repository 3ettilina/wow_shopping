part of 'main_cubit.dart';

class MainState extends Equatable {
  const MainState({this.selected = NavItem.home});

  final NavItem selected;

  @override
  List<Object?> get props => [selected];
}
