import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:gunlox/modules/Home/HomeScreen.dart.dart';

import 'package:gunlox/utils/SharedPreference.dart';
import '../../network/api_client.dart';
import '../../network/endpoints.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;
import '../Signup/phoneVerification.dart';
import 'LoginModel.dart';

class LoginController extends GetxController {
  RxBool isLoginButtonActive = false.obs;
  RxBool isLoading = false.obs;
  RxBool passwordVisible = true.obs;
  Login login = Login();
  // String? fcmToken;
  RxBool rememberMe = false.obs;
  String? fcmToken;

  doLogin(String email, String password) async {
    isLoading.value = true;
    // fcmToken = await FirebaseMessaging.instance.getAPNSToken();
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token $fcmToken");
    Map<String, dynamic> loginPayload = {
      "email": email.toString().toLowerCase().replaceAll(' ', ''),
      "password": password,
      "role": "user",
      "deviceToken": fcmToken,
    };
    String user;

    var response = await ApiClient().commonPostAPIMethod(
        Endpoints.LOGIN,
        {
          'Content-Type': 'application/json',
        },
        jsonEncode(loginPayload));
    // print("FCM TOken $fcmToken");
    // isLoading.value = false;
    print("login response: $response");

    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else if (response['id'] != null) {
      login = Login.fromJson(response);
      user = jsonEncode(login);

      print("-- rememberMe ${rememberMe.value}");
      if (!rememberMe.value) {
        await GunLoxPrefs.setBool('rememberMe', false);
      } else if (rememberMe.value && login.user!.phoneNumberVerified!) {
        await GunLoxPrefs.setBool('rememberMe', rememberMe.value);
        // common.showCustomSnackBar(Constants.loginSuccess);
      }

      if (login.user!.phoneNumberVerified!) {
        print("--Home Screen");
        await GunLoxPrefs.setString('user', user);
        Get.offAll(() => const HomeScreen());
      } else {
        Get.to(() => PhoneVerification(
              userId: response["userId"],
              accessToken: response["id"],
              phoneNumber: response["user"]["phone"],
              email: response["user"]["email"],
              user: user,
              route: "Login Screen",
            ));
      }
    }
    isLoading.value = false;
    // } else if (response!["error"]["statusCode"] == 401 &&
    //       response!["error"]["message"] == "Authorization Required") {
    //     common.showCustomSnackBar(Constants.userError);
    //     // isLoading.value = false;
    //   } else if (response!["error"]["statusCode"] == 400 ||
    //       response!["error"]["statusCode"] == 404) {
    //     common.showCustomSnackBar("${response!["error"]["message"]}");
    //     // isLoading.value = false;
    //   } else if (response!["error"]["statusCode"] == 422) {
    //     common.showCustomSnackBar("${response!["error"]["message"]}");
    //     // isLoading.value = false;
    //   }
    // } else if (response!["id"] != null) {
    //   login = Login.fromJson(response);
    //   // isUserMobileVerified.value = response!["user"]["_isMobileVerified"],
    //   // print(response!["user"]["mobile"]["e164Number"]),
    //   // access_token.value = login.id!,
    //   print(login!.user!.isTherapist!);
    //   common.setToken(login.id!);
    //   common.setUserType(login.user!.userType ?? "user");

    //   //setting and saving the information of user
    //   user = jsonEncode(login);
    //   print("user ===>>> ${user}");
    //   if (login.user!.bIsEmailVerified! && login.user!.bIsMobileVerified!) {
    //     isLoading.value = false;
    //     Get.offAll(() => DashboardPage(
    //       isTherapist: common.getUserType,
    //       index: 1,
    //     ));
    //   }
    //   if (!login.user!.bIsEmailVerified!) {
    //     Get.to(() => SignUpEmailVerifyScreen(
    //           email: login.user!.email!,
    //           phone: login.user!.mobile!.e164Number!,
    //           signUpRoute: false,
    //           isEmailVerified: login.user!.bIsEmailVerified!,
    //           isPhoneVerified: login.user!.bIsMobileVerified!,
    //         ));
    //   } else if (!login.user!.bIsMobileVerified!) {
    //     Get.to(() => SignUpPhoneVerifyScreen(
    //           email: login.user!.email!,
    //           phone: login.user!.mobile!.e164Number!,
    //           signUpRoute: false,
    //           isEmailVerified: login.user!.bIsEmailVerified!,
    //           isPhoneVerified: login.user!.bIsMobileVerified!,
    //         ));
    //   }
    // }

    isLoading.value = false;
  }
}
