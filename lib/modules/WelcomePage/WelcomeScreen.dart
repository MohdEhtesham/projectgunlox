// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Signup/SignupScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Login/LoginScreen.dart';

// Import other necessary files

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 0.h,
            left: 3.w,
            child: Image.asset(
              AppImages.lock,
              height: 20.h,
              // width: 30.w,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0.h,
            right: 0.w,
            child: Image.asset(
              AppImages.sheildLogo,
              height: 20.h,
              // width: 30.w,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: Container(
                  height: 15.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.splashLogo),
                    ),
                  ),
                ),
              ),

              Center(
                child: Container(
                  height: 28.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.splashGunLogo,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Center(
                child: SizedBox(
                  height: 8.h,
                  child: Center(
                      child: Text(
                    Constants.hello,
                    style: CommonTextStyles.poppinsSemiBoldStyle.copyWith(
                        fontSize: CommonFontSizes.sp20.sp,
                        color: AppColors.primaryBlackColor),
                  )),
                ),
              ),
              Center(
                child: Center(
                    child: Text(
                  Constants.welcomeText,
                  style: CommonTextStyles.poppinsSemiBoldStyle.copyWith(
                      fontSize: CommonFontSizes.sp20.sp,
                      color: AppColors.welcomecolortext),
                  textAlign: TextAlign.center,
                )),
              ),
              SizedBox(height: 4.h),
              Center(
                child: SizedBox(
                  width: 85.w,
                  child: CommonButton(
                    width: 85.w,
                    onPressed: () {
                      Get.to(() => const SignupScreen());
                    },
                    buttonText: Constants.createAccount,
                    fontSize: 18,
                    fontFamily: "Poppins",
                    buttonColor: AppColors.secondaryColor,
                    textColor: AppColors.primaryWhiteColor,
                    horizontalPadding: 20,
                    verticalPadding: 10,
                    borderRadius: 25,
                    iconSpacing: 12,
                    borderColor: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Center(
                child: SizedBox(
                  width: 85.w,
                  child: CommonButton(
                    width: 85.w,
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                    },
                    buttonText: Constants.logIn,
                    buttonColor: AppColors.primaryWhiteColor,
                    textColor: AppColors.borderColor,
                    horizontalPadding: 20,
                    verticalPadding: 10,
                    borderRadius: 25,
                    iconSpacing: 12,
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: CommonFontWeight.regular,
                    borderColor: Colors.red,
                  ),
                ),
              ),
              // Expanded(
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [

              //       Container(
              //         height: 40.h,
              //         width: 30.w,
              //         decoration: const BoxDecoration(
              //           image: DecorationImage(
              //             image: AssetImage(AppImages.sheildLogo),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
