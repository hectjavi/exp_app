import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../features/product/domain/entities/product_entity.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required List<String> images,
    required List<String> sizes,
    required List<String> colors,
    required String category,
    required double rating,
    required int reviewCount,
    @Default(false) bool isFavorite,
    @Default(0) int stockQuantity,
    String? brand,
    String? material,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// ✅ Mapper desde Entity
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      images: entity.images,
      sizes: entity.sizes,
      colors: entity.colors,
      category: entity.category,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      isFavorite: entity.isFavorite,
      stockQuantity: entity.stockQuantity,
      brand: entity.brand,
      material: entity.material,
    );
  }

  /// ✅ ✅ 🔥 NUEVO: Mapper desde Firestore
  factory ProductModel.fromFirestore(
    Map<String, dynamic> json,
    String id,
  ) {
    return ProductModel(
      id: id,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      images: List<String>.from(json['images'] ?? []),
      sizes: List<String>.from(json['sizes'] ?? []),
      colors: List<String>.from(json['colors'] ?? []),
      category: json['category'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
      stockQuantity: json['stockQuantity'] ?? 0,
      brand: json['brand'],
      material: json['material'],
    );
  }
}
extension ProductModelX on ProductModel {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }
}
