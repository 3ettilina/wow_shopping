import 'package:wow_shopping/models/product_item.dart';

abstract class ProductsRepo {
  // TODO: Cache products
  List<ProductItem> get cachedItems;

  Future<ProductsRepo> create();

  Future<List<ProductItem>> fetchTopSelling();

  /// Find product from the top level products cache
  ///
  /// [id] for the product to fetch.
  ProductItem findProduct(String id);
}
