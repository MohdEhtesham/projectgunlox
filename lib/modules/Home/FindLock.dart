import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/CommonFunctions/CommonFunctions.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Firearm/FoundLocks.dart';
import 'package:gunlox/modules/Home/NoLocks.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'LocksController.dart';
import 'MyAccount.dart';

class FindLock extends StatefulWidget {
  const FindLock({super.key});

  @override
  State<FindLock> createState() => _FindLockState();
}

class _FindLockState extends State<FindLock> {
  final List<ScanResult> _scanResults = [];

  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;
  var locksController = Get.put(LocksController());

  @override
  void initState() {
    super.initState();
    startScanning();
  }

  void onConnectPressed(BluetoothDevice device) {
    device.connect().catchError((e) {
      // Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
      showCustomSnackBar("Connect error $e");
    });
    // MaterialPageRoute route = MaterialPageRoute(
    //     builder: (context) => DeviceScreen(device: device),
    //     settings: RouteSettings(name: '/DeviceScreen'));
    // Navigator.of(context).push(route);
  }

  Future onDisconnectPressed(BluetoothDevice device) async {
    device.disconnect().catchError((e) {
      // Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
      showCustomSnackBar("Connect error $e");
    });
    // try {
    //   await device.disconnect().catchError()
    //   // Snackbar.show(ABC.c, "Disconnect: Success", success: true);
    //   showCustomSnackBar("Connect error $e");

    // } catch (e) {
    //   Snackbar.show(ABC.c, prettyException("Disconnect Error:", e), success: false);
    // }
  }

  Future onRefresh() {
    if (_isScanning == false) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    }
    if (mounted) {
      setState(() {});
    }
    return Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    _scanResults.clear();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  startScanning() async {
    // FlutterBluePlus.startScan(withServices: Guid("sdsf"));
    // await FlutterBluePlus.startScan(withServices: Guid("0000ff02-0000-1000-8000-00805f9b34fb"),timeout: const Duration(seconds: 7000000));
    // _scanResults = FlutterBluePlus.scanResults;
    print('list of paired devices');
    List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
    for (var d in devs) {
      print("Connected BT devices $d");
    }
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 4),
      // withServices: [Guid('0000ff02-0000-1000-8000-00805f9b34fb')],
      // withNames: ["Gunlox"],
    );

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      // setState(() {
      _scanResults.clear();
      for (var element in results) {
        String deviceName = element.advertisementData.advName;
        if (deviceName.isNotEmpty && deviceName.substring(0, 6) == "Gunlox") {
          _scanResults.add(element);
        }
      }
      // _scanResults = results;
      // });
      // print("_scanResults $_scanResults");
      // if (mounted) {
      //   setState(() {});
      // }
    }, onError: (e) {
      // Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  // List<Widget> _buildScanResultTiles(BuildContext context) {
  //   return _scanResults
  //       .map(
  //         (r) => ScanResultTile(
  //           result: r,
  //           onTap: () => r.device.isConnected
  //               ? onDisconnectPressed(r.device)
  //               : onConnectPressed(r.device),
  //         ),
  //       )
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
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

              SizedBox(
                height: 3.h,
              ),
              _isScanning
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
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
                              width: 50.w,
                              child: Center(
                                child: Text(Constants.findword,
                                    style: CommonTextStyles.poppinsBoldStyle
                                        .copyWith(
                                      fontSize: CommonFontSizes.sp22.sp,
                                      color: AppColors.primaryColor,
                                    )),
                              ),
                            ),
                            const SizedBox()
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 50.h,
                          width: 90.w,
                          child: const MyAnimatedImageWidget(),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        SizedBox(
                          width: 85.w,
                          child: Text(Constants.findword2,
                              textAlign: TextAlign.center,
                              style:
                                  CommonTextStyles.poppinsRegularStyle.copyWith(
                                fontSize: CommonFontSizes.sp18.sp,
                                color: AppColors.blackColor,
                              )),
                        ),
                      ],
                    )
                  : !_isScanning && _scanResults.isEmpty
                      ? const Column(
                          children: [
                            NoLocks(),
                          ],
                        )
                      : Column(
                          children: [
                            FoundLocks(scanResults: _scanResults),
                            CommonButton(
                              onPressed: () {
                                locksController.listConnectedDevices();
                                //Uncomment
                                // print("Tapped");
                                // // FocusManager.instance.primaryFocus?.unfocus();
                                // setState(() {
                                //   _isScanning = true;
                                //   _scanResults.clear();
                                // });
                                // startScanning();
                                // Get.off(() => const FindLock());
                              },
                              buttonText: Constants.scanAgain,
                              fontSize: 20,
                              fontFamily: "Poppins",
                              buttonColor: AppColors.secondaryColor,
                              textColor: AppColors.primaryWhiteColor,
                              horizontalPadding: 20,
                              verticalPadding: 10,
                              borderRadius: 25,
                              iconSpacing: 12,
                              borderColor: Colors.red,
                              width: 90.w,
                              fontWeight: CommonFontWeight.semiBold,
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyAnimatedImageWidget extends StatefulWidget {
  const MyAnimatedImageWidget({super.key});

  @override
  _MyAnimatedImageWidgetState createState() => _MyAnimatedImageWidgetState();
}

class _MyAnimatedImageWidgetState extends State<MyAnimatedImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Container(
            height: 50.h,
            width: 90.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                    AppImages.search), // Replace with your image asset
                // fit: BoxFit.,
              ),
            ),
            child: CustomPaint(
              painter: RipplePainter(_controller.value),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RipplePainter extends CustomPainter {
  final double animationValue;
  final int numberOfCircles;
  int dashes = 6;
  Color emptyColor = AppColors.slightGrey;
  Color filledColor = AppColors.primaryColor.withOpacity(0.2);
  double gapSize = 2.0;
  double strokeWidth = 1.0;
  double fillCount = 10;
  StrokeCap strokeCap = StrokeCap.round;
  RipplePainter(this.animationValue, {this.numberOfCircles = 5});

  @override
  void paint(Canvas canvas, Size size) {
    //ripple
    Paint paint = Paint()
      ..color = AppColors.primaryColor.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0;

    double maxRadius = min(size.width, size.height) / 2;
    double step = maxRadius / numberOfCircles;

    for (int i = 1; i <= numberOfCircles; i++) {
      double currentRadius = step * i * animationValue;
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), currentRadius, paint);
    }

//Dashed circle

    // for (int i = 0; i < dashes; i++) {
    //   final Paint paint = Paint()
    //     ..color = filledColor
    //     ..strokeWidth = strokeWidth
    //     ..style = PaintingStyle.stroke
    //     ..strokeCap = strokeCap;
    // double currentDashedRadius = step * i * animationValue;

    // canvas.drawCircle(
    //   Offset(size.width / 2, size.height / 2),
    //   currentDashedRadius,
    //   paint,
    // );
    // }

    final double gap = pi / 180 * gapSize;
    final double singleAngle = (pi * 2) / dashes;

    for (int i = 0; i < dashes; i++) {
      final Paint paint = Paint()
        ..color = filledColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = strokeCap;
      double currentDashedRadius = step * i * animationValue;

      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        currentDashedRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DashPainter extends CustomPainter {
  // DashPainter();

  int dashes = 30;
  Color emptyColor = AppColors.slightGrey;
  Color filledColor = AppColors.primaryColor;
  double gapSize = 2.0;
  double strokeWidth = 1.0;
  double fillCount = 10;
  StrokeCap strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final double gap = pi / 180 * gapSize;
    final double singleAngle = (pi * 2) / dashes;

    for (int i = 0; i < dashes; i++) {
      final Paint paint = Paint()
        ..color = filledColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = strokeCap;

      canvas.drawArc(
        Offset.zero & size,
        gap + singleAngle * i,
        singleAngle - gap * 2,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(DashPainter oldDelegate) {
    return dashes != oldDelegate.dashes || emptyColor != oldDelegate.emptyColor;
  }
}
