import 'dart:convert';

import 'package:get/get.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import 'package:gunlox/utils/SharedPreference.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class AddAuthorizedUserController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isActiveButton = false.obs;

  late Map userData;
  var userId;

  getUserDetails() async {
    String userString;
    userString = await GunLoxPrefs.getString('user');
    if (userString.isNotEmpty) {
      userData = jsonDecode(userString);
    }
  }

  addAuthorizedUser(name, email, phone, firearmId) async {
    isLoading.value = true;
    await getUserDetails();
    List<String> nameParts = name.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    Map<String, dynamic> addAuthorizedUserPayload = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": "+91$phone",
      "firearmsId": firearmId,
    };
    print("login response: $addAuthorizedUserPayload");
    if(lastName =="" ){
common.showCustomSnackBar(Constants.fullName);
    }else{
  var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.ADD_AUTHORIZED_USER, jsonEncode(addAuthorizedUserPayload));
    print("response addAuthorized usr  $response");
     Get.back();
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      common.showCustomSnackBar(Constants.AddUserMessage);
    }
    isLoading.value = false;
  }
    }
  
}
