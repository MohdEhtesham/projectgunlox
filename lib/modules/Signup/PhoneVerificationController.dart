import 'dart:convert';

import 'package:get/get.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Home/HomeScreen.dart.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;
import '../../utils/SharedPreference.dart';

class PhoneVerificationController extends GetxController {
  RxString phoneNumber = "".obs;
  RxBool isOTPEntered = false.obs;
  bool isActiveButton = false;
  // RxBool showEnterNumberField = false.obs;
  // RxBool showVerificationSection = true.obs;

  sendPhoneCode(phone) async {
    phoneNumber.value = phone;
    var sendCodePayload = {
      "phone": phone
      //Modified acc to Indian numbers for now
      //Need to change: Rohan
    };
    print(" sendCodePayload phone verification $sendCodePayload");
    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.SEND_OTP, jsonEncode(sendCodePayload));
    print("response send mobile code $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      print("OTP send success");
    }
  }

  verifyPhoneCode(code, phoneNumber, email, user) async {
    Map<String, dynamic> verifyMobilePayload = {
      "phone": phoneNumber,
      "otp": code,
      "email": email,
    };
    print("payload verifyPhone Code $verifyMobilePayload & user: $user");

    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.VERIFY_OTP, jsonEncode(verifyMobilePayload));
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      common.showCustomSnackBar(Constants.registerSuccess);
      isActiveButton = true;
      await GunLoxPrefs.setString('user', user);
      await GunLoxPrefs.setBool('rememberMe', true);
      // common.showCustomSnackBar(Constants.loginSuccess);
      Get.offAll(() => const HomeScreen());
    }
    print("response verifyPhone Code $response");
  }

  resendPhoneCode(phone, String accessToken, email) async {
    var sendCodePayload = {
      "phone": phone,
      "email": email,
    };
    print(" sendCodePayload hello $sendCodePayload ,$accessToken");
    var response = await ApiClient().commonPostAPIMethod(
        Endpoints.RESEND_OTP,
        {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        jsonEncode(sendCodePayload));
    print("response send mobile code $response");
    // if (response!["error"] != null) {
    //   common.showCustomSnackBar(response!["error"]["message"]);
    // } else {
    //   print("show verification section");
    //   // showVerificationSection.value = true;
    // }
  }
}
