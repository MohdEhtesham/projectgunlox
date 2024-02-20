import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Home/LocksController.dart';

// ignore: must_be_immutable
class FoundLocks extends StatefulWidget {
  FoundLocks({super.key, required this.scanResults});
  List<ScanResult> scanResults;
  @override
  State<FoundLocks> createState() => _FoundLocksState();
}

class _FoundLocksState extends State<FoundLocks> {
  // final List<String> dataList = [];
  // BluetoothDevice? device;
  var locksController = Get.put(LocksController());
  BluetoothCharacteristic? storeChacterstics;
  var communicationKey;
  var communicationKeyUnicode;
  String rootKey = "Gunlox12";
  BluetoothDevice? connectedDevice;

  @override
  void initState() {
    super.initState();
    FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
    locksController.updateLockList(widget.scanResults);
    // print("Scan Results Found lock ${widget.scanResults[0].device.remoteId}");
    // dataList.add(widget.scanResults[0].device.remoteId as String);
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    List<BluetoothService> services;
    print("Device Details $device");
    try {
      await device.connect();
    } catch (e) {
      //  if (e != 'already_connected') {
      // showCustomSnackBar("alr");
      rethrow;
      //  }
    } finally {
      services = await device.discoverServices();
      // print("BT SERVICES ${services[0].characteristics}");

      displayCharacterstics(device);
    }
    // device.connect();
  }

  getCharacteristics(chactersticsValue) async {
    for (final c in chactersticsValue) {
      storeChacterstics = c;
    }
  }

  getLockId(BluetoothDevice device) async {
    List<BluetoothService> service = await device.discoverServices();
  }

  displayCharacterstics(BluetoothDevice device) async {
    List<BluetoothService> services;
    String gunLockDeviceId;

    services = await device.discoverServices();
    // print("BT SERVICES ${services[0].characteristics}");
    connectedDevice = device;
    services.forEach(
      (s) async {
        getCharacteristics(s.characteristics);
        for (var element in s.characteristics) {
            // print(" element  ${element}");
            if (element.uuid.toString() == "ff01") {
              storeChacterstics = element;
              print("Stored characterstics, $storeChacterstics");
            }
            // if (element.uuid.toString().contains("2a29")) {
            // element.readString()
            element.read().then((value) async {
              print("element value ${String.fromCharCodes(value)}");
              // gunLockDeviceId = utf8.decode(value);
            });

            final subscription = element.onValueReceived.listen((value) {
              // onValueReceived is updated:
              //   - anytime read() is called
              //   - anytime a notification arrives (if subscribed)
            });

// cleanup: cancel subscription when disconnected
            device.cancelWhenDisconnected(subscription);

// subscribe
// Note: If a characteristic supports both **notifications** and **indications**,
// it will default to **notifications**. This matches how CoreBluetooth works on iOS.
// await characteristic.setNotifyValue(true);

            // if(element.isNotifying){
            //   var valueChangedSubscriptions;

            //   valueChangedSubscriptions[s.uuid]?.cancel();
            //         print("element value ${String.fromCharCodes(value)}");
            //         // gunLockDeviceId = utf8.decode(value);
            //   }
          }
      },
    );
  }

  List<int> getLockID(String value) {
    List<int> item = <int>[];

    HashMap map1 = HashMap<String, int>();
    map1["0"] = 0x30;
    map1["1"] = 0x31;
    map1["2"] = 0x32;
    map1["3"] = 0x33;
    map1["4"] = 0x34;
    map1["5"] = 0x35;
    map1["6"] = 0x36;
    map1["7"] = 0x37;
    map1["8"] = 0x38;
    map1["9"] = 0x39;
    item = [map1[0], map1[1]];

    return item;
  }

  readLockDevice() async {}

  connectLockDevice() async {
    communicationKey = [0Xc2, 0Xde, 0X0a, 0X15, 0X30, 0Xe4, 0Xf8, 0X34];
    print("storeChacterstics listen, $storeChacterstics");

    await storeChacterstics!.write(communicationKey);

    displayCharacterstics(connectedDevice!);
    // storeChacterstics.value.listen((value) {
    //   // Handle the response data here
    //   print("Value listen, $value");
    // });

    // await FlutterDes.decrypt(Uint8List.fromList([194, 222, 10, 21, 48, 228, 248, 52]), rootKey);
  }

  Future<void> checkForResponse(BluetoothCharacteristic characteristic) async {
    // You may read from the characteristic to get the response
    List<int> response = await characteristic.read();

    // Handle the response as needed
    print('Received response from device: $response');
  }

  lockDevice() {}

  unlockDevice() {}

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => locksController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ))
          : Column(
              children: [
                // SizedBox(height: 4.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       height: 10.h,
                //       width: 45.w,
                //       decoration: const BoxDecoration(
                //         image: DecorationImage(
                //           image: AssetImage(AppImages.splashLogo),
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         Get.to(() => MyAccount());
                //       },
                //       child: Container(
                //         height: 10.h,
                //         width: 10.w,
                //         decoration: const BoxDecoration(
                //           image: DecorationImage(
                //             image: AssetImage(AppImages.useracc),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.off(() => const HomeScreen());
                        Get.back();
                      },
                      child: Container(
                        height: 5.h,
                        width: 10.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.arrow),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                      width: 60.w,
                      child: Center(
                        child: Text(Constants.addFirmware,
                            style: CommonTextStyles.poppinsBoldStyle.copyWith(
                              fontSize: CommonFontSizes.sp22.sp,
                              color: AppColors.primaryColor,
                            )),
                      ),
                    ),
                    const SizedBox()
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Constants.locksFound,
                    style: CommonTextStyles.poppinsSemiBoldStyle.copyWith(
                      fontSize: CommonFontSizes.sp20.sp,
                      color: AppColors.primaryBlackColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: locksController.deviceIdList.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          connectDevice(locksController.deviceList[index]);
                          // displayCharacterstics(
                          //     locksController.deviceList[index]);

                          //to uncomment
                          // Get.to(() => FirearmDetails(
                          //     device: locksController.deviceList[index]));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryWhiteColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryWhiteColor,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Constants.lockId,
                                          style: CommonTextStyles
                                              .poppinsSemiBoldStyle
                                              .copyWith(
                                            fontSize: CommonFontSizes.sp16.sp,
                                            color: AppColors.primaryBlackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${locksController.deviceIdList[index]}",
                                          style: CommonTextStyles
                                              .poppinsRegularStyle
                                              .copyWith(
                                            fontSize: CommonFontSizes.sp16.sp,
                                            color: AppColors.primaryBlackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                print("Write");
                                                connectLockDevice();
                                              },
                                              child: const Text("Write"),
                                            ),
                                            SizedBox(width: 5.w),
                                            GestureDetector(
                                              onTap: () {
                                                print("Read");
                                                readLockDevice();
                                              },
                                              child: const Text("Read"),
                                            ),
                                            SizedBox(width: 5.w),
                                            GestureDetector(
                                              onTap: () async {
                                                // print("Read");
                                                // readLockDevice();
                                                await locksController
                                                    .deviceList[index]
                                                    .disconnect();
                                              },
                                              child: const Text("Disconnect device"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 5.h,
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        AppImages.signal,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
    );
  }
}
