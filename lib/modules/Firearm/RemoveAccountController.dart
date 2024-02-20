
import 'package:get/get.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class RemoveAccountController extends GetxController {
  RxBool isLoading = false.obs;

  late Map userData;
  var userId;

removeAuthorizedUser(mappingId) async {
    isLoading.value = true;

    var response = await ApiClient().commonDeleteAPIMethod(
      '${Endpoints.REMOVE_AUTHORIZED_USER}/$mappingId',
null
    );

    print("ghdgvfhvghdfgv=====>:$response");
    if (response!["count"] == 1) {
    
      isLoading.value = false;
     
      Future.delayed(Duration.zero, () {
        common.showCustomSnackBar(Constants.removeAuthorized);
      });
    } else {
      common.showCustomSnackBar("Some error occurred");
    }


    isLoading.value = false;
  }
  
}
