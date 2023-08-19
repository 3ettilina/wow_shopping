import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:wow_shopping/backend/product_repo.dart';
import 'package:wow_shopping/backend/wishlist_repo.dart';
import 'package:wow_shopping/models/product_item.dart';
import 'package:wow_shopping/models/wishlist_storage.dart';

class WishlistRepoMock implements WishlistRepo {
  WishlistRepoMock._(this._productsRepo, this._file, this._wishlist);

  final ProductsRepo _productsRepo;
  final File _file;
  late WishlistStorage _wishlist;
  late StreamController<List<ProductItem>> _wishlistController;
  Timer? _saveTimer;

  Future<WishlistRepo> create(ProductsRepo productsRepo) async {
    try {
      final dir = await path_provider.getApplicationDocumentsDirectory();
      final file = File(path.join(dir.path, 'wishlist.json'));
      if (await file.exists()) {
        _wishlist = WishlistStorage.fromJson(
          json.decode(await file.readAsString()),
        );
      } else {
        _wishlist = WishlistStorage.empty;
      }
      return WishlistRepoMock._(productsRepo, file, _wishlist)..init();
    } catch (error, stackTrace) {
      print('$error\n$stackTrace'); // Send to server?
      rethrow;
    }
  }

  @override
  void init() {
    _wishlistController = StreamController<List<ProductItem>>.broadcast(
      onListen: () => _emitWishlist(),
    );
  }

  void _emitWishlist() {
    _wishlistController.add(currentWishlistItems);
  }

  @override
  List<ProductItem> get currentWishlistItems =>
      _wishlist.items.map(_productsRepo.findProduct).toList();

  @override
  Stream<List<ProductItem>> get streamWishlistItems =>
      _wishlistController.stream;

  @override
  bool isInWishlist(ProductItem item) {
    return _wishlist.items.contains(item.id);
  }

  @override
  Stream<bool> streamIsInWishlist(ProductItem item) async* {
    bool last = isInWishlist(item);
    yield last;
    await for (final list in streamWishlistItems) {
      final current = list.any((product) => product.id == item.id);
      if (current != last) {
        yield current;
        last = current;
      }
    }
  }

  @override
  void addToWishlist(String productId) {
    if (_wishlist.items.contains(productId)) {
      return;
    }
    _wishlist = _wishlist.copyWith(
      items: {..._wishlist.items, productId},
    );
    _emitWishlist();
    _saveWishlist();
  }

  @override
  void removeToWishlist(String productId) {
    _wishlist = _wishlist.copyWith(
      items: _wishlist.items.where((el) => el != productId),
    );
    _emitWishlist();
    _saveWishlist();
  }

  void _saveWishlist() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 1), () async {
      await _file.writeAsString(json.encode(_wishlist.toJson()));
    });
  }
}
