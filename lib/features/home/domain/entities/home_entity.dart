import '../../../../shared/models/product_model.dart';
import '../../../../shared/models/category_model.dart';

class HomeEntity {
  final List<ProductModel> featuredProducts;
  final List<ProductModel> perfectForYou;
  final List<ProductModel> forThisSummer;
  final List<CategoryModel> categories;
  final List<String> banners;

  const HomeEntity({
    required this.featuredProducts,
    required this.perfectForYou,
    required this.forThisSummer,
    required this.categories,
    required this.banners,
  });
}
