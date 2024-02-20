import 'dart:convert';

import 'package:get/get.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/models/FirearmListModel.dart';
import 'package:gunlox/modules/Home/HomeScreen.dart.dart';
import 'package:gunlox/modules/Login/LoginScreen.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import 'package:gunlox/utils/SharedPreference.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;
import 'package:http/http.dart' as http;

import '../../models/FirearmConnectivityModel.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isActiveButton = false.obs;
  FirearmListModel firearmListModel = FirearmListModel();
  RxList<FirearmListModel> firearmList = <FirearmListModel>[].obs;
  RxList<FirearmConnectivityModel> firearmConnectivityList =
      <FirearmConnectivityModel>[].obs;

  RxList<String> dataList = [
    '6784-8574-g574-42e1',
    '6784-8574-g574-42e2',
    '6784-8574-g574-42e3',
    '6784-8574-g574-42e4',
  ].obs;

  late Map userData;
  var userId;
  getUserDetails() async {
    String userString;
    userString = await GunLoxPrefs.getString('user');
    if (userString.isNotEmpty) {
      userData = jsonDecode(userString);
    }
  }

  contactUs(subject, message) async {
    isLoading.value = true;
    await getUserDetails();
    Map<String, dynamic> contactUsPayload = {
      "userId": userData["user"]["id"],
      "subject": subject,
      "description": message
    };
    print(contactUsPayload);
    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.CONTACT_US, jsonEncode(contactUsPayload));
    print("response contact Us $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      common.showCustomSnackBar(Constants.contactUsMessage);
      Get.off(() => const HomeScreen());
    }
    isLoading.value = false;
  }

  changePassword(oldPassword, password) async {
    isLoading.value = true;
    await getUserDetails();
    Map<String, dynamic> setPassPayload = {
      "oldPassword": oldPassword,
      "newPassword": password,
    };
    print(setPassPayload);
    var response = await ApiClient().commonPostAPIMethod(
        "${Endpoints.CHANGE_USER_PASSWORD}/?access_token=${userData["id"]}",
        {
          'Content-Type': 'application/json',
        },
        jsonEncode(setPassPayload));
    print("set pass response $response");
    if (response == null) {
      common.showCustomSnackBar("Error");
    } else if (response["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else if (response["statusCode"] == 200 || response["statusCode"] == 204) {
      GunLoxPrefs.clearPrefs();
      Get.offAll(() => const LoginScreen());
      Future.delayed(Duration.zero, () {
        common.showCustomSnackBar(Constants.passwordChangeSuccess);
      });
    }
    isLoading.value = false;
  }

  updateUser(fullName) async {
    isLoading.value = true;
    await getUserDetails();

    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    Map<String, dynamic> setPassPayload = {
      "firstName": firstName,
      "lastName": lastName,
      "fullName": fullName,
      "address": "",
      // "phone": ,
    };
    print(setPassPayload);
    var response = await ApiClient().commonPatchAPIMethod(
        "${Endpoints.UPDATE_USER}/${userData["user"]["id"]}?access_token=${userData["id"]}",
        {
          'Content-Type': 'application/json',
        },
        jsonEncode(setPassPayload));
    print("set pass response $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      common.showCustomSnackBar(Constants.profileUpdateSuccess);
      Get.off(const HomeScreen());
    }
    isLoading.value = false;
  }

  //Check Firearm
  getListOfFireams() async {
    isLoading.value = true;
    print("checkFirearm details: ");

    await getUserDetails();

    Map<String, dynamic> filterParams = {
      'where': {'userId': userData["user"]["id"]},
    };
    String filter = jsonEncode(filterParams);

    // URL encoding the filter parameter
    String encodedFilter = Uri.encodeQueryComponent(filter);

    String url = '${Endpoints.GET_FIREARMDETAILS}?filter=$encodedFilter';
    // print("checkFirearm url: $url");
    final response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    print("checkFirearm details: ${response.body}");

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      // List connectivityList = jsonDecode(response.body);

      Map<String, dynamic> firearmConnectivityJson = {};
      // ignore: avoid_function_literals_in_foreach_calls
      firearmList.clear();
      firearmConnectivityList.clear();
      for (var element in list) {
        firearmList.add(FirearmListModel.fromJson(element));
        firearmConnectivityJson = {"lastUpdatedState": "Locked"};
        firearmConnectivityList
            .add(FirearmConnectivityModel.fromJson(firearmConnectivityJson));
      }
    }

    isLoading.value = false;
    return response.body;
  }
}
