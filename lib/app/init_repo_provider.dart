import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wow_shopping/backend/product_repo.dart';
import 'package:wow_shopping/backend/wishlist_repo.dart';

final initRepoProvider = FutureProvider((ref) async {
  await ref.read(productsRepoProvider).create();
  await ref.read(wishlistRepoProvider).create();
});
