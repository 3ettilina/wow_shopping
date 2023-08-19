import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:wow_shopping/backend/product_repo.dart';
import 'package:wow_shopping/models/product_item.dart';
import 'package:wow_shopping/models/wishlist_storage.dart';

final wishlistRepoProvider = Provider<WishlistRepo>((ref) {
  return WishlistRepo._(ref);
});

// Provides state
final wishlistStorageState = StateProvider<WishlistStorage>((ref) {
  return const WishlistStorage(items: {});
});

class WishlistRepo {
  WishlistRepo._(this.ref);

  final Ref ref;
  late final File _file;
  Timer? _saveTimer;

  Future<void> create() async {
    late WishlistStorage wishlistStorage;
    try {
      final dir = await path_provider.getApplicationDocumentsDirectory();
      final file = File(path.join(dir.path, 'wishlist.json'));
      if (await file.exists()) {
        wishlistStorage = WishlistStorage.fromJson(
          json.decode(await file.readAsString()),
        );
      } else {
        wishlistStorage = WishlistStorage.empty;
      }
      ref
          .read(wishlistStorageState.notifier)
          .update((state) => wishlistStorage);
    } catch (error, stackTrace) {
      print('$error\n$stackTrace'); // Send to server?
      rethrow;
    }
  }

  List<ProductItem> get currentWishlistItems {
    final productsRepo = ref.read(productsRepoProvider);
    final products = ref.read(wishlistStorageState);
    return products.items.map(productsRepo.findProduct).toList();
  }

  void addToWishlist(String productId) {
    final wishlist = ref.read(wishlistStorageState);
    if (wishlist.items.contains(productId)) {
      return;
    }
    final updatedList = wishlist.copyWith(
      items: {...wishlist.items, productId},
    );
    ref.read(wishlistStorageState.notifier).update((state) => updatedList);
    _saveWishlist();
  }

  void removeToWishlist(String productId) {
    final wishlist = ref.read(wishlistStorageState);
    final updatedWishlist = wishlist.copyWith(
      items: wishlist.items.where((el) => el != productId),
    );
    ref.read(wishlistStorageState.notifier).update((state) => updatedWishlist);
    _saveWishlist();
  }

  void _saveWishlist() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 1), () async {
      await _file
          .writeAsString(json.encode(ref.read(wishlistStorageState).toJson()));
    });
  }
}
