
import 'package:get/get.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class DeleteFirearmController extends GetxController {
  RxBool isLoading = false.obs;

  late Map userData;
  var userId;

  deleteFirearm(firearmId) async {
    isLoading.value = true;

    var response = await ApiClient()
        .commonDeleteAPIMethod('${Endpoints.DELETE_FIREARM}/$firearmId', null);

    print("ghdgvfhvghdfgv=====>:$response");
    if (response!["count"] == 1) {
      isLoading.value = false;
      // Get.off(()=> const HomeScreen());
      common.showCustomSnackBar(Constants.deleteFire);
      Future.delayed(Duration.zero, () {
        Get.back();
      });
    } else {
      common.showCustomSnackBar("Some error occurred");
    }

    isLoading.value = false;
  }
}
