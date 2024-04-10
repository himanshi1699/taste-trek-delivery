import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_delivery_boy/data/model/response/base/api_response.dart';
import 'package:resturant_delivery_boy/data/model/response/base/error_response.dart';
import 'package:resturant_delivery_boy/localization/language_constrants.dart';
import 'package:resturant_delivery_boy/main.dart';
import 'package:resturant_delivery_boy/provider/splash_provider.dart';
import 'package:resturant_delivery_boy/view/screens/auth/login_screen.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) {
    ErrorResponse error = getError(apiResponse);

    if((error.errors![0].code == '401' || error.errors![0].code == 'auth-001')) {
      Provider.of<SplashProvider>(Get.context!, listen: false).removeSharedData();
      Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
    }else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(error.errors![0].message ?? getTranslated('not_found', Get.context!)!
            , style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    }
  }

  static ErrorResponse getError(ApiResponse apiResponse){
    ErrorResponse error;

    try{
      error = ErrorResponse.fromJson(apiResponse);
    }catch(e){
      if(apiResponse.error != null){
        error = ErrorResponse.fromJson(apiResponse.error);
      }else{
        error = ErrorResponse(errors: [Errors(code: '', message: apiResponse.error.toString())]);
      }
    }
    return error;
  }
}