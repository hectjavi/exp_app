import '../../../../shared/models/product_model.dart';
import '../../../../shared/models/category_model.dart';

abstract class HomeRepository {
  Future<List<ProductModel>> getFeaturedProducts();
  Future<List<ProductModel>> getPerfectForYou();
  Future<List<ProductModel>> getForThisSummer();
  Future<List<CategoryModel>> getCategories();
  Future<List<String>> getBanners();
}
