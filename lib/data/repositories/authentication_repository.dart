import 'package:dio/dio.dart';
import 'package:flutter_appsa/common/consttants/api_constant.dart';
import 'package:flutter_appsa/data/datasources/remote/app_response.dart';
import 'package:flutter_appsa/data/datasources/remote/dio_request.dart';
import 'dart:async';

import 'package:flutter_appsa/data/datasources/remote/user_response.dart';

class AuthenticationRepository {
  late Dio _dio;

  AuthenticationRepository() {
    _dio = DioRequest.instance.dio;
  }

  Future<UserResponse> login({String email = "", String password = ""}) {
    Completer<UserResponse> completer = Completer();
    _dio.post(ApiConstant.SIGN_IN_API,
        data: {"email": email, "password": password}).then((response) {
      AppResponse<UserResponse> dataResponse =
          AppResponse.fromJson(response.data, UserResponse.parseJson);
      completer.complete(dataResponse.data);
    }).catchError((error) {
      if (error is DioError) {
        completer.completeError((error).response?.data["message"]);
      } else {
        completer.completeError(error);
      }
    });
    return completer.future;
  }

  Future<UserResponse> register(
      {String email = "",
      String password = "",
      String name = "",
      String phone = "",
      String address = ""}) {
    Completer<UserResponse> completer = Completer();
    _dio.post(ApiConstant.SIGN_UP_API, data: {
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
      "address": address,
    }).then((response) {
      AppResponse<UserResponse> dataResponse =
          AppResponse.fromJson(response.data, UserResponse.parseJson);
      completer.complete(dataResponse.data);
    }).catchError((error) {
      if (error is DioError) {
        completer.completeError((error).response?.data["message"]);
      } else {
        completer.completeError(error);
      }
    });
    return completer.future;
  }
}
