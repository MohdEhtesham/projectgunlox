import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;
import '../../../models/PhoneLoginModel.dart';
import '../../../utils/SharedPreference.dart';
import '../../Home/HomeScreen.dart.dart';

class PhoneLoginController extends GetxController {
  RxBool showVerificationSection = false.obs;
  RxString phoneNumber = "".obs;
  RxBool isOTPEntered = false.obs;
  PhoneLoginModel phoneLogin = PhoneLoginModel();
  String? fcmToken;

  sendPhoneCode(phone) async {
    phoneNumber.value = "+91$phone";
    var sendCodePayload = {
      "phone": "+91$phone"
      //Modified acc to Indian numbers for now
      //Need to change: Rohan
    };
    print(" sendCodePayload phonelogin $sendCodePayload");
    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.SEND_OTP, jsonEncode(sendCodePayload));
    print("response send mobile code $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      print("show verification section");
      showVerificationSection.value = true;
    }
  }

  verifyPhoneCode(code) async {
    String user;
    fcmToken = await FirebaseMessaging.instance.getToken();
    Map<String, dynamic> verifyMobilePayload = {
      "phone": phoneNumber.value,
      "devicToken": fcmToken,
      "otp": code
    };
    print("payload verifyPhone Code $verifyMobilePayload");

    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.VERIFY_OTP, jsonEncode(verifyMobilePayload));
    // print("response verifyPhone Code $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      phoneLogin = PhoneLoginModel.fromJson(response["message"]);
      user = jsonEncode(phoneLogin);
      print("User at phone login --> $user");
      await GunLoxPrefs.setString('user', user);
      await GunLoxPrefs.setBool('rememberMe', true);
      Get.offAll(() => const HomeScreen());

      // common.showCustomSnackBar(Constants.loginSuccess);
      // Get.offAll(() => const LoginScreen());
    }
  }
}
