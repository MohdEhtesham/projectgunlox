import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/models/FirearmListModel.dart';
import 'package:gunlox/modules/Home/FindLock.dart';
import 'package:gunlox/modules/Home/MyAccount.dart';
import 'package:gunlox/modules/Home/NoFireamScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gunlox/utils/SharedPreference.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../Bluetooth/Bluetooth_Off_Screen.dart';
import '../Firearm/FirearmDetails2.dart';
import 'HomeController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;
  late Map userData;
  var userId;
  bool isLoading = true;
  var homecontroller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    checkBTPermission();
    var res = homecontroller.getListOfFireams();
    if (res != null) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }

    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      setState(() {
        _adapterState = state;
      });
      if (mounted) {
        print("FlutterBluePlus Mounted $_adapterState");
      }
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  checkBTPermission() async {
    var status = await Permission.bluetooth.status;
    print("checkBTPermission $status");
    if (status == PermissionStatus.denied) {
      var requestStatus = await Permission.bluetooth.request();
      print("checkBTPermission PermissionStatus $requestStatus");
      // showCustomSnackBar("Please turn on BT");
    }
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  getUserDetails() async {
    String userString;
    userString = await GunLoxPrefs.getString('user');
    // print("user string $userString");
    if (userString.isNotEmpty) {
      userData = jsonDecode(userString);
    }
  }

  void changeLastUpdatedState(
      FirearmListModel firearmList, firearmConnectivityList, String state) {
    // print(firearmList);
    // print(firearmConnectivityList);
    // print(firearmList);
  }

  @override
  Widget build(BuildContext context) {
    // Widget screen = _adapterState == BluetoothAdapterState.on
    //     ? const ScanScreen()
    //     : BluetoothOffScreen(adapterState: _adapterState);
    return _adapterState == BluetoothAdapterState.off
        ? BluetoothOffScreen(adapterState: _adapterState)
        : PopScope(
            canPop: true,
            child: Scaffold(
              body: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 10.h,
                            width: 45.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.splashLogo),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const MyAccount());
                            },
                            child: Container(
                              height: 10.h,
                              width: 10.w,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.useracc),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 3.h),
                      homecontroller.isLoading.value
                          ? SizedBox(
                              height: 60.h,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            )
                          : homecontroller.firearmList.isEmpty
                              ? const NoFirearmScreen()
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                homecontroller
                                                    .getListOfFireams();
                                              },
                                              child: Container(
                                                height: 10.h,
                                                width: 10.w,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        AppImages.refresh),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            CommonButton(
                                              onPressed: () {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                Get.to(() => const FindLock());
                                              },
                                              buttonText: Constants.addnew,
                                              fontSize: 16,
                                              imagePath: AppImages.plus,
                                              fontFamily: "Poppins",
                                              buttonColor:
                                                  AppColors.secondaryColor,
                                              textColor:
                                                  AppColors.primaryWhiteColor,
                                              horizontalPadding: 20,
                                              verticalPadding: 10,
                                              borderRadius: 25,
                                              iconSpacing: 12,
                                              borderColor: Colors.red,
                                              width: 40.w,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        Constants.inrange,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          color: AppColors.primaryBlackColor,
                                        ),
                                      ),
                                    ),
                                    //In Range List
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          homecontroller.firearmList.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.primaryWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                                border: Border.all(
                                                  color: AppColors.blackColor
                                                      .withOpacity(0.2),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(() => FirearmDetails2(
                                                            firearmId:
                                                                homecontroller
                                                                    .firearmList[
                                                                        index]
                                                                    .id!));
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: 70.w,
                                                                child: Text(
                                                                  homecontroller
                                                                      .firearmList[
                                                                          index]
                                                                      .name!,
                                                                  softWrap:
                                                                      true,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16.sp,
                                                                    color: AppColors
                                                                        .primaryBlackColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child:
                                                                    Image.asset(
                                                                  AppImages
                                                                      .signal,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            homecontroller
                                                                .firearmList[
                                                                    index]
                                                                .model!,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 16.sp,
                                                              color: AppColors
                                                                  .primaryBlackColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 2.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    //Blue Border container
                                                    Container(
                                                      // width: 100.w,
                                                      height: 8.h,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: AppColors
                                                                  .blue),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          color: AppColors
                                                              .softerBlue),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0,
                                                                right: 10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Lock Button
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  homecontroller
                                                                      .firearmConnectivityList[
                                                                          index]
                                                                      .lastUpdatedState = "Locked";
                                                                });
                                                              },
                                                              child: Container(
                                                                height: homecontroller
                                                                            .firearmConnectivityList[index]
                                                                            .lastUpdatedState ==
                                                                        "Locked"
                                                                    ? 12.w
                                                                    : 9.w,
                                                                width: homecontroller
                                                                            .firearmConnectivityList[index]
                                                                            .lastUpdatedState ==
                                                                        "Locked"
                                                                    ? 12.w
                                                                    : 9.w,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10),
                                                                decoration: homecontroller
                                                                            .firearmConnectivityList[index]
                                                                            .lastUpdatedState ==
                                                                        "Locked"
                                                                    ? const BoxDecoration(
                                                                        color: AppColors
                                                                            .blue,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(AppImages.closeLockSelected),
                                                                          fit: BoxFit
                                                                              .none,
                                                                          alignment:
                                                                              Alignment.center,
                                                                        ),
                                                                      )
                                                                    : const BoxDecoration(
                                                                        // shape: BoxShape.circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(AppImages.closeLock),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          alignment:
                                                                              Alignment.center,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  CustomPaint(
                                                                painter:
                                                                    DashedLinePainter(),
                                                                child:
                                                                    Container(
                                                                  height: 2.0,
                                                                ),
                                                              ),
                                                            ),
                                                            // Wrap the second image container with GestureDetector
                                                            GestureDetector(
                                                              onTap: () {
                                                                // dataList[index]deviceId[index] = 1;
                                                                // buttonPressed(dataList[index], index);

                                                                setState(() {
                                                                  homecontroller
                                                                      .firearmConnectivityList[
                                                                          index]
                                                                      .lastUpdatedState = "UnLocked";
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 11.w,
                                                                width: 11.w,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                decoration: homecontroller
                                                                            .firearmConnectivityList[index]
                                                                            .lastUpdatedState ==
                                                                        "UnLocked"
                                                                    ? const BoxDecoration(
                                                                        color: AppColors
                                                                            .blue,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(AppImages.unlockSelected),
                                                                          fit: BoxFit
                                                                              .none,
                                                                          alignment:
                                                                              Alignment.center,
                                                                        ),
                                                                      )
                                                                    : const BoxDecoration(
                                                                        // shape: BoxShape.circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(AppImages.unlock),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          alignment:
                                                                              Alignment.center,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  CustomPaint(
                                                                painter:
                                                                    DashedLinePainter(),
                                                                child:
                                                                    Container(
                                                                  height: 2.0,
                                                                ),
                                                              ),
                                                            ),
                                                            // Wrap the third image container with GestureDetector
                                                            GestureDetector(
                                                              onTap: () {
                                                                // buttonPressed(dataList[index], index);
                                                                setState(() {
                                                                  homecontroller
                                                                      .firearmConnectivityList[
                                                                          index]
                                                                      .lastUpdatedState = "Removed Shank";
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 11.w,
                                                                width: 11.w,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10),
                                                                decoration: homecontroller
                                                                            .firearmConnectivityList[index]
                                                                            .lastUpdatedState ==
                                                                        "Removed Shank"
                                                                    ? const BoxDecoration(
                                                                        color: AppColors
                                                                            .blue,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(AppImages.removeShankSelected),
                                                                          fit: BoxFit
                                                                              .none,
                                                                          alignment:
                                                                              Alignment.center,
                                                                        ),
                                                                      )
                                                                    : const BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(AppImages.removeShankUnselected),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          alignment:
                                                                              Alignment.center,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    SizedBox(
                                      height: 2.h,
                                    ),

                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        Constants.outrange,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          color: AppColors.primaryBlackColor,
                                        ),
                                      ),
                                    ),

                                    //Out of Range list
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: homecontroller.dataList.length,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.outback
                                                    .withOpacity(.5),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          Constants.myHunting,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16.sp,
                                                            color: AppColors
                                                                .primaryWhiteColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Image.asset(
                                                            AppImages.cross,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      Constants.huntingtext,
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16.sp,
                                                        color: AppColors
                                                            .primaryWhiteColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.grey
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 2.0;
    const double dashSpace = 2.0;
    double currentX = 0.0;

    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0.0),
        Offset(currentX + dashWidth, 0.0),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
