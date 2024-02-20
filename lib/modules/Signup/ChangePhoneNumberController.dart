import 'dart:convert';

import 'package:get/get.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;
import '../../models/PhoneLoginModel.dart';
import '../../network/api_client.dart';
import '../../network/endpoints.dart';
import '../../utils/SharedPreference.dart';
import '../Home/HomeScreen.dart.dart';

class ChangePhoneNumberController extends GetxController {
  RxString phoneNumber = "".obs;
  RxBool isOTPEntered = false.obs;
  bool isActiveButton = false;
  // RxBool showEnterNumberField = false.obs;
  RxBool showVerificationSection = false.obs;
  PhoneLoginModel changePhoneLogin = PhoneLoginModel();

  changePhone(email, phone) async {
    phoneNumber.value = "+91$phone";
    var changePhonePayload = {
      "phone": phoneNumber.value,
      "email": email
      //Modified acc to Indian numbers for now
      //Need to change: Rohan
    };
    print(" changePhonePayload $changePhonePayload");
    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.CHANGE_PHONE_NUMBER, jsonEncode(changePhonePayload));
    print("response change Phone at signup $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      print("show verification section");
      showVerificationSection.value = true;
    }
  }

  resendPhoneCode(phone) async {
    // phoneNumber.value = "+91$phone";
    var resendPhoneCode = {
      "phone": phoneNumber.value
      //Modified acc to Indian numbers for now
      //Need to change: Rohan
    };
    print("resendPhoneCode $resendPhoneCode");
    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.SEND_OTP, jsonEncode(resendPhoneCode));
    print("response send mobile code $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      // print("show verification section");
      // showVerificationSection.value = true;
    }
  }

  verifyPhoneCode(code) async {
    String user;
    Map<String, dynamic> verifyMobilePayload = {
      "phone": phoneNumber.value,
      "otp": code
    };
    print("payload changephone number $verifyMobilePayload");

    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.VERIFY_OTP, jsonEncode(verifyMobilePayload));
    // print("response verifyPhone Code $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      changePhoneLogin = PhoneLoginModel.fromJson(response["message"]);
      user = jsonEncode(changePhoneLogin);
      print("User at phone login --> $user");
      await GunLoxPrefs.setString('user', user);
      await GunLoxPrefs.setBool('rememberMe', true);
      Get.offAll(() => const HomeScreen());
    }
  }
}
