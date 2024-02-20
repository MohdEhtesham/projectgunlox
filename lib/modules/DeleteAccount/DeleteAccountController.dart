import 'dart:convert';

import 'package:get/get.dart';
import 'package:gunlox/modules/Login/LoginScreen.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import 'package:gunlox/utils/SharedPreference.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class DeleteAccountController extends GetxController {
  RxBool isLoading = false.obs;

  late Map userData;
  var userId;

  getUserDetails() async {
    String userString;
    userString = await GunLoxPrefs.getString('user');
    if (userString.isNotEmpty) {
      userData = jsonDecode(userString);
    }
  }

  deleteAccount() async {
    isLoading.value = true;
    await getUserDetails();
    print(
        "-- deleteAccount userData  $userData && ${userData["user"]["id"]} && ${userData["id"]}");

    var response = await ApiClient().commonDeleteAPIMethod(
        '${Endpoints.DELETE_ACCOUNT}/${userData["user"]["id"]}?access_token=${userData["id"]}',
    null,
       );

    if (response!["count"] == 1) {
      GunLoxPrefs.clearPrefs();
      isLoading.value = false;
      Get.offAll(() => const LoginScreen());
      Future.delayed(Duration.zero, () {
        common.showCustomSnackBar("Account Deleted");
      });
    } else {
      common.showCustomSnackBar("Some error occurred");
    }

    isLoading.value = false;
  }
}