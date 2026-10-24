import 'package:ecommerce_app_huma_volve/core/constants/api_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/datasource/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/products_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

class HomeRemoteDataSourceImplemention implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImplemention(this.apiClient);
  @override
  Future<List<HomeCategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoint.endPointCategories);
    final List dataJson = response.data;
    final List<HomeCategoryModel> categories = dataJson
        .map((e) => HomeCategoryModel.fromJson(e))
        .toList();

    return categories;
  }

  @override
  Future<List<HomeProductModel>> getProducts(int? categoryId) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoint.endPointCategories}/$categoryId/${ApiEndpoint.endPointProduct}',
    );
    final List dataJson = response.data;
    final List<HomeProductModel> products = dataJson
        .map((e) => HomeProductModel.fromJson(e))
        .toList();

    return products;
  }
}
