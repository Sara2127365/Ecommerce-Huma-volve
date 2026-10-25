import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/constants/api_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_request_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_response_model.dart';

class ServiceSignup {
  ApiClient apiClient;
  ServiceSignup(this.apiClient);
  Future<SignupResponseModel> signup(SignupRequestModel signupRequestModel ) async {
    final response = await apiClient.dio.post(
      ApiEndpoint.endPointSignup,
      data: { 
  "email": signupRequestModel.email,
  "name": signupRequestModel.name,
  "password": signupRequestModel.password,
   "avatar": "https://www.gravatar.com/avatar/?d=mp&s=200&utm_source=chatgpt.com"},
    );
    final Map<String, dynamic> dataJson = response.data;
    final dataObject = SignupResponseModel.fromJson(dataJson);
    return dataObject;
  }
}
