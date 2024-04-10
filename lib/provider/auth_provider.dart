import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resturant_delivery_boy/data/datasource/remote/dio/dio_client.dart';
import 'package:resturant_delivery_boy/data/model/body/delivery_man_body.dart';
import 'package:resturant_delivery_boy/data/model/response/base/api_response.dart';
import 'package:resturant_delivery_boy/data/model/response/base/error_response.dart';
import 'package:resturant_delivery_boy/data/model/response/config_model.dart';
import 'package:resturant_delivery_boy/data/repository/auth_repo.dart';
import 'package:resturant_delivery_boy/data/repository/response_model.dart';
import 'package:resturant_delivery_boy/helper/api_checker.dart';
import 'package:resturant_delivery_boy/localization/language_constrants.dart';
import 'package:resturant_delivery_boy/main.dart';
import 'package:resturant_delivery_boy/view/base/custom_snackbar.dart';
import 'package:http/http.dart' as http;


import 'splash_provider.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo? authRepo;

  AuthProvider({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // for login section
  String? _loginErrorMessage = '';

  String? get loginErrorMessage => _loginErrorMessage;

  XFile? _pickedImage;
  List<XFile> _pickedIdentities = [];
  final List<String> _identityTypeList = ['passport', 'driving_license', 'nid', 'restaurant_id'];
  int _identityTypeIndex = 0;
  final int _dmTypeIndex = 0;
  XFile? _pickedLogo;
  XFile? _pickedCover;
  int? _selectedBranchIndex;
  List<Branches>? _branchList;

  List<String> get identityTypeList => _identityTypeList;
  XFile? get pickedImage => _pickedImage;
  List<XFile> get pickedIdentities => _pickedIdentities;
  int get identityTypeIndex => _identityTypeIndex;
  int get dmTypeIndex => _dmTypeIndex;
  XFile? get pickedLogo => _pickedLogo;
  XFile? get pickedCover => _pickedCover;
  List<Branches>? get branchList => _branchList;
  int? get selectedBranchIndex => _selectedBranchIndex;

  Future<ResponseModel> login({String? emailAddress, String? password}) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.login(emailAddress: emailAddress, password: password);

    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String token = map["token"];
      authRepo!.saveUserToken(token);
      responseModel = ResponseModel('', true);
      await updateToken();
    } else {
      _loginErrorMessage = ApiChecker.getError(apiResponse).errors![0].message;
      responseModel = ResponseModel(_loginErrorMessage, false);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<void> updateToken() async {
    ApiResponse apiResponse = await   authRepo!.updateToken();
    if(apiResponse.response?.statusCode == null || apiResponse.response!.statusCode! != 200) {
      ApiChecker.checkApi(apiResponse);
    }
  }

  // for verification Code
  String _verificationCode = '';

  String get verificationCode => _verificationCode;
  bool _isEnableVerificationCode = false;

  bool get isEnableVerificationCode => _isEnableVerificationCode;

  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    notifyListeners();
  }

  // for Remember Me Section

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    notifyListeners();
  }

  bool isLoggedIn() {
    return authRepo!.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo!.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo!.saveUserNumberAndPassword(number, password);
  }

  String getUserEmail() {
    return authRepo!.getUserEmail();
  }

  String getUserPassword() {
    return authRepo!.getUserPassword();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo!.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo!.getUserToken();
  }


  void loadBranchList(){
    _branchList = [];

    _branchList?.add(Branches(id: 0, name: getTranslated('all', Get.context!)));
    _branchList?.addAll(Provider.of<SplashProvider>(Get.context!, listen: false).configModel?.branches ?? []);
  }

  void pickDmImage(bool isLogo, bool isRemove) async {
    if(isRemove) {
      _pickedImage = null;
      _pickedIdentities = [];
    }else {
      if (isLogo) {
        _pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if(xFile != null) {
          _pickedIdentities.add(xFile);
        }
      }
      notifyListeners();
    }
  }

  void setIdentityTypeIndex(String? identityType, bool notify) {
    int index0 = 0;
    for(int index=0; index<_identityTypeList.length; index++) {
      if(_identityTypeList[index] == identityType) {
        index0 = index;
        break;
      }
    }
    _identityTypeIndex = index0;
    if(notify) {
      notifyListeners();
    }
  }



  void removeIdentityImage(int index) {
    _pickedIdentities.removeAt(index);
    notifyListeners();
  }

  Future<void> registerDeliveryMan(DeliveryManBody deliveryManBody) async {
    _isLoading = true;
    notifyListeners();
    List<MultipartBody> multiParts = [];
    multiParts.add(MultipartBody('image', _pickedImage));
    for(XFile file in _pickedIdentities) {
      multiParts.add(MultipartBody('identity_image[]', file));
    }
    http.Response ? apiResponse = await authRepo?.registerDeliveryMan(deliveryManBody, multiParts);
    if (apiResponse != null  && apiResponse.statusCode == 200) {
      Navigator.of(Get.context!).pop();
      showCustomSnackBar(getTranslated('delivery_man_registration_successful', Get.context!)!, isError: false);
    } else {
      dynamic errorResponse;
      try{
        errorResponse = ErrorResponse.fromJson(jsonDecode(apiResponse!.body.toString())).errors![0].message;
      }catch(er){
        errorResponse = apiResponse?.body;
      }
      showCustomSnackBar(errorResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  void setBranchIndex(int index, {bool isUpdate = true}){
    _selectedBranchIndex = index;
    if(isUpdate){
      notifyListeners();
    }
  }
}
