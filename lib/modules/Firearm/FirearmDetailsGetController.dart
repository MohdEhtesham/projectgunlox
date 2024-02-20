import 'dart:convert';
import 'package:get/get.dart';
import 'package:gunlox/models/FirearmDetailsModel.dart';
import 'package:gunlox/models/GetAuthorizedModel.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import 'package:gunlox/utils/SharedPreference.dart';
import 'package:http/http.dart' as http;

class FirearmDetailsGetController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isChecked = false.obs;
  RxBool isChecked2 = false.obs;
  RxBool isChecked3 = false.obs;
  RxBool isActiveButton = false.obs;
  RxMap<String, dynamic>? firearmDetails = RxMap<String, dynamic>();
  RxList<GetAuthorizedModel> authorizedUser = <GetAuthorizedModel>[].obs;

  late Map userData;
  var userId;
  getUserDetails() async {
    String userString;
    userString = await GunLoxPrefs.getString('user');
    if (userString.isNotEmpty) {
      userData = jsonDecode(userString);
    }
  }

  getFirearmDetails(firearmId) async {
    isLoading.value = true;
    await getUserDetails();

    var response = await ApiClient().commonGetAPIMethod(
      "${Endpoints.GET_FIREARMDETAILS}/$firearmId",
      {
        'Content-Type': 'application/json',
      },
    );

    print("jhgdsfadhsgdhsfhgadsfgdhs: $response");
    if (response != null) {
      firearmDetails = FirearmDetailsModel.fromJson(response).toJson().obs;
    }
    print("shammmmmmmm: $firearmDetails");

    isLoading.value = false;
  }

  getUserAuthorized(firearmId) async {
    isLoading.value = true;
    await getUserDetails();

    Map<String, dynamic> filterParams = {
      'where': {'firearmsId': firearmId},
      'include': 'user',
    };
    String filter = jsonEncode(filterParams);

    String encodedFilter = Uri.encodeQueryComponent(filter);

    String url =
        "http://159.89.234.66:8912/api/firearm-mappings?filter=$encodedFilter";

    try {
      // print("Request URL: $url");
      // Making the HTTP GET request with the Content-Type header
      final response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      // print("Response Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Response Body: ${response.body}");
        String jsonString = response.body;

        List<Map<String, dynamic>> userAuthorized2 =
            List<Map<String, dynamic>>.from(jsonDecode(jsonString));
        // authorizedUser.clear();
        if (userAuthorized2.isNotEmpty) {
          for (var element in userAuthorized2) {
            authorizedUser.add(GetAuthorizedModel.fromJson(element));
          }

          print("responnnnnnnn: $firearmId");
        } else {
          // print('Response is empty.');
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    isLoading.value = false;
  }
}
