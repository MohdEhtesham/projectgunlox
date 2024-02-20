import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/CommonExt/Components.dart';
import '../../components/Constants/AppColors.dart';
import '../../components/Constants/AppFontFamily.dart';
import '../../components/Constants/AppImages.dart';
import '../../components/strings/Constants.dart';
import 'FindLock.dart';

class NoFirearmScreen extends StatelessWidget {
  const NoFirearmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 20.h,
              width: 40.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.sheild),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              height: 20.h,
              width: 90.w,
              child: Center(
                child: Text(Constants.Homeword,
                    style: CommonTextStyles.poppinsSemiBoldStyle.copyWith(
                      fontSize: CommonFontSizes.sp22.sp,
                      color: AppColors.blackColor,
                    )),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 20.h,
              width: 40.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.gunLock),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        CommonButton(
          onPressed: () {
            Get.to(() => const FindLock());
          },
          buttonText: Constants.addFirm,
          fontSize: 20,
          imagePath: AppImages.plus,
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
    );
  }
}
