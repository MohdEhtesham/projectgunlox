import 'dart:convert';

import 'package:get/get.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Home/HomeScreen.dart.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class FirearmDetailsUpdateController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isActiveButton = false.obs;

  firearmDeatlsUpdate(firearmName, brand, model, serialNumber, caliber,
      emergency, storage, concealed, fireamId) async {
    isLoading.value = true;
    Map<String, dynamic> setPassPayload = {
      "name": firearmName,
      "brand": brand,
      "model": brand,
      "serialNumber": serialNumber,
      "caliber": caliber,
      "emergency": emergency,
      "storage": storage,
      "concealed": concealed
    };
    print(setPassPayload);
    var response = await ApiClient().commonPatchAPIMethod(
        "${Endpoints.UPDATE_FIREARM}/$fireamId",
        {
          'Content-Type': 'application/json',
        },
        jsonEncode(setPassPayload));
    print("set pass response $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      common.showCustomSnackBar(Constants.firearmUpdate);
    }
    isLoading.value = false;
  }

  UpdateFirearmEmergency(userId, Id, statusv) async {
    isLoading.value = true;

    Map<String, dynamic> setPassPayload = {
      "firearmId": Id,
      "userId": userId,
     "status":statusv,
    };
    print("hhhhhhhhhhhhh:$setPassPayload");
    var response = await ApiClient().commonPatchAPIMethod(
        Endpoints.UPDATE_EMERGENCY,
        {
          'Content-Type': 'application/json',
        },
        jsonEncode(setPassPayload));
    print("EMERGENCYUPDATE $response");
    if (response!["error"] != null) {
      common.showCustomSnackBar(response["error"]["message"]);
    } else {
      common.showCustomSnackBar(Constants.firearmUpdate);
      Get.back();
      Get.offAll(() => const HomeScreen());
    }
    isLoading.value = false;
  }
}
