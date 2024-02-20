import 'dart:convert';

import 'package:get/get.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/ForgotPassword/SetPassword.dart';
import 'package:gunlox/modules/Login/LoginScreen.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class ForgotPasswordController extends GetxController {
  RxBool isActiveButton = false.obs;
  RxBool showVerificationSection = false.obs;
  RxString phoneNumber = "".obs;
  RxBool isOTPEntered = false.obs;
  RxBool setPasswordVisible = true.obs;
  RxBool confirmPasswordVisible = true.obs;
  RxBool isButtonActive = false.obs;
  RxBool isLoading = false.obs;
  RxBool passwordVisible = true.obs;

  sendForgotPasswordCode(email) async {
    // isLoading.value = true;
    Map<String, dynamic> forgotPassPayload = {
      "email": email.toString().toLowerCase(),
      "roleType": "user"
    };
    var response = await ApiClient().commonPostAPIMethod(
        Endpoints.FORGOT_PASSWORD,
        {
          'Content-Type': 'application/json',
        },
        jsonEncode(forgotPassPayload));
    print("forgot $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      print("show verification section");
      showVerificationSection.value = true;
    }

    // isLoading.value = false;
  }

  verifyEmailCode(code, email) async {
    Map<String, dynamic> verifyMobilePayload = {
      "email": email.toString().toLowerCase(),
      "otp": code
    };
    print("payload verifyPhone Code $verifyMobilePayload");

    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.VERIFY_CODE, jsonEncode(verifyMobilePayload));
    print("response verifyPhone Code $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      common.showCustomSnackBar(Constants.otpverified);
      Get.to(() => SetPassword(
            accesstoken: response["message"]["data"],
          ));
    }
  }

  setPassword(accessToken, password) async {
    isLoading.value = true;
    Map<String, dynamic> setPassPayload = {
      "newPassword": password,
    };
    print(setPassPayload);
    var response = await ApiClient().commonPostAPIMethod(
        "${Endpoints.RESET_USER_PASSWORD}/?access_token=$accessToken",
        {
          'Content-Type': 'application/json',
        },
        jsonEncode(setPassPayload));
    print("set pass response $response");
    if (response == null) {
      common.showCustomSnackBar("Error");
    } else if (response["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else if (response["statusCode"] == 200 ||
        response["statusCode"] == 204) {
      common.showCustomSnackBar(Constants.passwordChangeSuccess);
      Get.offAll(() => const LoginScreen());
    }
    isLoading.value = false;
  }
}
