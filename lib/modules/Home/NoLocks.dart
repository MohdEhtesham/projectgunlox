import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NoLocks extends StatelessWidget {
  const NoLocks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        //     Container(
        //       height: 10.h,
        //       width: 10.w,
        //       decoration: const BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage(AppImages.useracc),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(height: 3.h),
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
                child: Text(Constants.noword,
                    style: CommonTextStyles.poppinsBoldStyle.copyWith(
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
        Image.asset(AppImages.nofind),
        SizedBox(
          height: 4.h,
        ),
        SizedBox(
          width: 85.w,
          child: Center(
            child: Text(Constants.findword2,
                textAlign: TextAlign.center,
                style: CommonTextStyles.poppinsRegularStyle.copyWith(
                  fontSize: CommonFontSizes.sp18.sp,
                  color: AppColors.blackColor,
                )),
          ),
        ),
      ],
    );
  }
}
