import 'package:bloc/bloc.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/models/product_item.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc({
    required WishlistRepo wishlistRepo,
  })  : _wishlistRepo = wishlistRepo,
        super(WishlistInitial()) {
    on<WishlistRequested>(_onWishlistRequested);
  }

  final WishlistRepo _wishlistRepo;

  Future<void> _onWishlistRequested(
    WishlistRequested event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      await emit.forEach<List<ProductItem>>(
        _wishlistRepo.streamWishlistItems,
        onData: (products) => WishlistData(wishlistProducts: products),
      );
    } catch (e) {
      emit(WishlistFailure());
    }
  }
}
