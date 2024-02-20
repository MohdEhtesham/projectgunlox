import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class LocksController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<DeviceIdentifier> deviceIdList = <DeviceIdentifier>[].obs;
  RxList<BluetoothDevice> deviceList = <BluetoothDevice>[].obs;

  updateLockList(List<ScanResult> scanResults) {
    isLoading = true.obs;
    // ignore: avoid_function_literals_in_foreach_calls
    deviceIdList.clear();
    deviceList.clear();
    for (var element in scanResults) {
      // print("Element:--- ${element.advertisementData.advName}");
      String deviceName = element.advertisementData.advName;
      if (deviceName.isNotEmpty && deviceName.substring(0, 6) == "Gunlox") {
        deviceIdList.add(element.device.remoteId);
        deviceList.add(element.device);
      }
    }
    isLoading = false.obs;
  }

  listConnectedDevices() {
    print('list of paired devices');
    List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
    for (var d in devs) {
      print("Connected BT devices $d");
    }
  }
}
