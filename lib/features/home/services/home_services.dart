import 'package:ecommerce_app_huma_volve/core/constants/api_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/products_model.dart';

class HomeServices {
  final ApiClient apiClient;
  HomeServices(this.apiClient);

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoint.endPointCategories);
    final List dataJson = response.data;
    final List<CategoryModel> categories = dataJson
        .map((e) => CategoryModel.fromJson(e))
        .toList();

    return categories;
  }

  Future<List<ProductsModel>> getProducts(int? categoryId) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoint.endPointCategories}/$categoryId/${ApiEndpoint.endPointProduct}',
    );
    final List dataJson = response.data;
    final List<ProductsModel> products = dataJson
        .map((e) => ProductsModel.fromJson(e))
        .toList();

    return products;
  }
}
