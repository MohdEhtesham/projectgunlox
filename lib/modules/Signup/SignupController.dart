import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:gunlox/modules/Signup/SignupModel.dart';
import 'package:gunlox/modules/Signup/phoneVerification.dart';
import '../../network/api_client.dart';
import '../../network/endpoints.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class SignupController extends GetxController {
  Signup signup = Signup();
  RxBool isRegisterButtonActive = false.obs;
  RxBool isLoading = false.obs;
  RxBool passwordVisible = true.obs;
  RxBool passwordVisible2 = true.obs;
  RxBool checkBoxValue = true.obs;
  RxBool isVerifyButtonActive = false.obs;

  String? fcmToken;

  registerUser(fullname, email, phonenumber, password, confirmpassword) async {
    String user;
    isLoading.value = true;

    // Splitting full name into first name and last name
    List<String> nameParts = fullname.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    String phoneNumber = "+91$phonenumber";

    fcmToken = await FirebaseMessaging.instance.getToken();

    Map<String, dynamic> loginPayload = {
      "firstName": firstName,
      "lastName": lastName,
      "fullName": fullname,
      "email": email.toString().toLowerCase().replaceAll(' ', ''),
      "password": password,
      "phone": phoneNumber,
      "confirmpassword": confirmpassword,
      "deviceToken": fcmToken,
    };

    var response = await ApiClient().commonPostAPIMethod(
      Endpoints.SIGNUP,
      {
        'Content-Type': 'application/json',
      },
      jsonEncode(loginPayload),
    );
    print("Signup response: $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      // common.showCustomSnackBar(Constants.SignupSuccess);
      signup = Signup.fromJson(response);
      user = jsonEncode(signup);
      print("user at Signup: $user");
      Get.off(() => PhoneVerification(
            phoneNumber: phoneNumber,
            accessToken: response["token"]["id"],
            userId: response["token"]["userId"],
            email: response["email"],
            user: user,
          ));
    }

    print("login response: $response");
    isLoading.value = false;
  }
}
