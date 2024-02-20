import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/CommonExt/Components.dart';
import '../../components/Constants/AppColors.dart';
import '../../components/Constants/AppFontFamily.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({super.key, this.adapterState});

  final BluetoothAdapterState? adapterState;

  Widget buildBluetoothOffIcon(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          AppImages.bluetoothLost,
          height: 70.w,
          width: 70.w,
        )
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    String? state = adapterState?.toString().split(".").last;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bluetooth Adapter is ${state ?? 'not available'}',
            style: CommonTextStyles.poppinsRegularStyle.copyWith(
                fontWeight: CommonFontWeight.semiBold,
                color: AppColors.primaryColor,
                fontSize: CommonFontSizes.sp18.sp),
          ),
          // Text(
          //   'Bluetooth Adapter is ${state ?? 'not available'}',
          //   style: Theme.of(context)
          //       .primaryTextTheme
          //       .titleSmall
          //       ?.copyWith(color: AppColors.primaryColor),
          // ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            Constants.checkBTAdapterText,
            style: CommonTextStyles.poppinsRegularStyle.copyWith(
                fontWeight: CommonFontWeight.regular,
                color: AppColors.blackColor,
                fontSize: CommonFontSizes.sp16.sp),
          ),
        ],
      ),
    );
  }

  Widget buildTryAgainButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: CommonButton(
        width: 70.w,
        buttonText: Constants.tryAgain,
        buttonColor: AppColors.secondaryColor,
        textColor: AppColors.white,
        horizontalPadding: 20,
        verticalPadding: 10,
        borderRadius: 25,
        iconSpacing: 12,
        fontSize: 18,
        fontFamily: "Poppins",
        fontWeight: CommonFontWeight.regular,
        borderColor: Colors.red,
        onPressed: () async {
          try {
            if (Platform.isAndroid) {
              await FlutterBluePlus.turnOn();
            } else {
              openAppSettings();
            }
          } catch (e) {
            // Snackbar.show(ABC.a, prettyException("Error Turning On:", e), success: false);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      // key: Snackbar.snackBarKeyA,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildBluetoothOffIcon(context),
              buildTitle(context),
              buildTryAgainButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
