import '../../../../shared/models/product_model.dart';

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;
  final String category;
  final double rating;
  final int reviewCount;
  final bool isFavorite;
  final int stockQuantity; // ✅ agregado (lo usas en model)
  final String? brand;
  final String? material;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.category,
    required this.rating,
    required this.reviewCount,
    this.isFavorite = false,
    this.stockQuantity = 0, // ✅ importante
    this.brand,
    this.material,
  });

  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      images: model.images,
      sizes: model.sizes,
      colors: model.colors,
      category: model.category,
      rating: model.rating,
      reviewCount: model.reviewCount,
      isFavorite: model.isFavorite,
      stockQuantity: model.stockQuantity,
      brand: model.brand,
      material: model.material,
    );
  }
}
