part of 'top_selling_bloc.dart';

@immutable
sealed class TopSellingState {
  const TopSellingState();
}

final class TopSellingInitial extends TopSellingState {
  const TopSellingInitial();
}

final class TopSellingEditing extends TopSellingState {
  const TopSellingEditing();
}

final class TopSellingLoading extends TopSellingState {}

final class TopSellingData extends TopSellingState {
  const TopSellingData(this.topSellingProducts);

  final List<ProductItem> topSellingProducts;
}

final class TopSellingFailure extends TopSellingState {
  const TopSellingFailure(this.error);

  final String error;
}
