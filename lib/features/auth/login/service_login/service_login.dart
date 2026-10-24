import 'package:ecommerce_app_huma_volve/core/constants/api_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/models/login_response_model.dart';

class ServiceLogin {
  ApiClient apiClient;
  ServiceLogin(this.apiClient);
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoint.endPointLogin,
      data: {"email": email, "password": password},
    );
    final Map<String, dynamic> datajson = response.data;
    final dataobject = LoginResponseModel.fromJson(datajson);
   await SecureStorage.saveAccessToken(dataobject.access_token);
   await SecureStorage.saveRefreshToken(dataobject.refresh_token);
    return dataobject;
  }
}
