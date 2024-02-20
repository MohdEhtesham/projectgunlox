import 'dart:convert';

import 'package:get/get.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/models/GetEmergencyListModel.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import 'package:gunlox/utils/SharedPreference.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;
import '../Home/HomeScreen.dart.dart';
import 'package:http/http.dart' as http;

class FirearmdetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isActiveButton = false.obs;
  RxList<GetEmergencyListModel> emergencyListofFirearm =
      <GetEmergencyListModel>[].obs;

  late Map userData;
  var userId;

  getUserDetails() async {
    String userString;
    userString = await GunLoxPrefs.getString('user');
    if (userString.isNotEmpty) {
      userData = jsonDecode(userString);
    }
  }

  addFirearm(name, brand, model, serialNumber, caliber, emergency, storage,
      concealed) async {
    isLoading.value = true;
    await getUserDetails();
    Map<String, dynamic> addFirearmPayload = {
      "userId": userData["user"]["id"],
      "name": name,
      "brand": brand,
      "model": model,
      "serialNumber": serialNumber,
      "caliber": caliber,
      "description": "Test",
      "emergency": emergency,
      "storage": storage,
      "concealed": concealed
    };
    print("login response: $addFirearmPayload");
    var response = await ApiClient().commonHeaderPostAPIMethod(
        Endpoints.ADD_FIREARM, jsonEncode(addFirearmPayload));
    print("response addFirearm  $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      common.showCustomSnackBar(Constants.firearmAddMessage);
      Get.offAll(() => const HomeScreen());
    }
    isLoading.value = false;
    return response;
  }

  checkEmergencyList() async {
    isLoading.value = true;
    await getUserDetails();
    print("userrrrrrrId:${userData["userId"]}");
    Map<String, dynamic> filterParams = {
      "where": {"emergency": true, "userId": "${userData["userId"]}"}
    };

    String filter = jsonEncode(filterParams);

    String encodedFilter = Uri.encodeQueryComponent(filter);

    String url = "http://159.89.234.66:8912/api/firearms?filter=$encodedFilter";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("Response Body: ${response.body}");
        String jsonString = response.body;
        List list = jsonDecode(response.body);

        for (var element in list) {
          emergencyListofFirearm.clear();

          emergencyListofFirearm.add(GetEmergencyListModel.fromJson(element));
        }

        print("responnnnnnnn: $list");
        // print("responnnnnnnns: ${emergencyListofFirearm[0].name}");
        return response.body;
      }
    } catch (e) {
      print("Exception: $e");
    }

    isLoading.value = false;
  }
}
