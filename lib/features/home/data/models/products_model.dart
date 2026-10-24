
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

class HomeProductModel extends HomeProductEntity {
  const HomeProductModel({
    super.id,
    super.title,
    super.slug,
    super.price,
    super.description,
    super.category,
    super.images,
  });

  factory HomeProductModel.fromJson(Map<String, dynamic> json) {
    return HomeProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      category: json['category'] != null
          ? HomeCategoryModel.fromJson(json['category'])
          : const HomeCategoryEntity(),
      images: json['images'] is List
          ? (json['images'] as List).whereType<String>().toList()
          : const [],
    );
  }
}
