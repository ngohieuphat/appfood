import 'package:dio/dio.dart';
import 'package:flutter_appsa/data/datasources/remote/app_response.dart';
import 'package:flutter_appsa/data/datasources/remote/cart_response.dart';
import 'package:flutter_appsa/data/datasources/remote/dio_request.dart';
import 'dart:async';

import '../../common/consttants/api_constant.dart';

class CartRepository {
  late Dio _dio;

  CartRepository() {
    _dio = DioRequest.instance.dio;
  }

  Future<CartResponse> fetchCart() {
    Completer<CartResponse> completer = Completer();
    _dio.get(ApiConstant.CART_API).then((response) {
      AppResponse<CartResponse> dataResponse =
          AppResponse.fromJson(response.data, CartResponse.parseJson);
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

  Future<CartResponse> addCart(String idProduct) {
    Completer<CartResponse> completer = Completer();
    _dio.post(ApiConstant.ADD_CART_API, data: {"id_product": idProduct}).then(
        (response) {
      AppResponse<CartResponse> dataResponse =
          AppResponse.fromJson(response.data, CartResponse.parseJson);
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

  Future<CartResponse> updateCart(
      String idCart, int quantity, String idProduct) {
    Completer<CartResponse> completer = Completer();
    _dio.post(ApiConstant.CART_UPDATE_API, data: {
      "id_product": idProduct,
      "id_cart": idCart,
      "quantity": quantity
    }).then((response) {
      AppResponse<CartResponse> dataResponse =
          AppResponse.fromJson(response.data, CartResponse.parseJson);
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

  Future<String> confirm(String idCart) {
    Completer<String> completer = Completer();
    _dio.post(ApiConstant.CART_CONFORM_API,
        data: {"id_cart": idCart, "status": false}).then((response) {
      completer.complete(response.data["data"]);
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
