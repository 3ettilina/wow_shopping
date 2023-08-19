import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wow_shopping/app/assets.dart';
import 'package:wow_shopping/backend/product_repo.dart';
import 'package:wow_shopping/models/product_item.dart';

class ProductsRepoMock implements ProductsRepo {
  ProductsRepoMock(this._products);

  final List<ProductItem> _products;

  // TODO: Cache products

  @override
  Future<ProductsRepo> create() async {
    try {
      final data = json.decode(
        await rootBundle.loadString(Assets.productsData),
      );
      final products = (data['products'] as List) //
          .cast<Map>()
          .map(ProductItem.fromJson)
          .toList();
      return ProductsRepoMock(products);
    } catch (error, stackTrace) {
      // FIXME: implement logging
      print('$error\n$stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<ProductItem>> fetchTopSelling() async {
    //await Future.delayed(const Duration(seconds: 3));
    return List.unmodifiable(_products); // TODO: filter to top-selling only
  }

  /// Find product from the top level products cache
  ///
  /// [id] for the product to fetch.
  @override
  ProductItem findProduct(String id) {
    return _products.firstWhere(
      (product) => product.id == id,
      orElse: () => ProductItem.none,
    );
  }

  @override
  // TODO: implement cachedItems
  List<ProductItem> get cachedItems => throw UnimplementedError();
}
