import 'dart:convert';

import 'package:flutter/foundation.dart';

class LoginResponseModel {
 String? access_token;
 String? refresh_token;

  LoginResponseModel( this.access_token,  this.refresh_token);

   LoginResponseModel.fromJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
    refresh_token = json['refresh_token'];
  }
}
