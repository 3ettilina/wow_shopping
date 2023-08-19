part of 'top_selling_bloc.dart';

@immutable
sealed class TopSellingState {
  const TopSellingState({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

final class TopSellingInitial extends TopSellingState {
  const TopSellingInitial() : super(username: '', password: '');
}

final class TopSellingEditing extends TopSellingState {
  const TopSellingEditing({String username, String password})
      : super(username: username ?? '', password: password ?? '');
}

final class TopSellingLoading extends TopSellingState {}

final class TopSellingData extends TopSellingState {
  TopSellingData(this.topSellingProducts);

  final List<ProductItem> topSellingProducts;

  TopSellingData copyWith({
    List<ProductItem>? newProducts,
  }) =>
      TopSellingData(
        newProducts ?? topSellingProducts,
      );
}

final class TopSellingFailure extends TopSellingState {
  TopSellingFailure(this.error);

  final String error;
}
