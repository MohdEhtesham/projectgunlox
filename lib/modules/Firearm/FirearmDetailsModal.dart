import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Firearm/DeleteFirearmController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class FirearmdetailsModal extends StatefulWidget {
  FirearmdetailsModal({super.key, required this.firearmId});
  String firearmId;
  @override
  State<FirearmdetailsModal> createState() => _FirearmdetailsModalState();
}

class _FirearmdetailsModalState extends State<FirearmdetailsModal> {
  var deleteFirearmController = Get.put(DeleteFirearmController());

  bool isNextPressed = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => deleteFirearmController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Container(
                      height: 1.w,
                      margin: const EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(
                          color: AppColors.slightGrey,
                          borderRadius: BorderRadius.circular(25.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: const AssetImage(AppImages.deleteAccount),
                              color: AppColors.primaryColor,
                              width: 6.w,
                              height: 6.w,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              Constants.deleteFirearm,
                              style: CommonTextStyles.poppinsRegularStyle
                                  .copyWith(
                                      fontWeight: CommonFontWeight.bold,
                                      color: AppColors.primaryColor,
                                      fontSize: CommonFontSizes.sp20.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //are you sure label & description
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Constants.areYouSure,
                                    style: CommonTextStyles.poppinsMediumStyle
                                        .copyWith(
                                            color: AppColors.primaryBlackColor,
                                            fontSize: CommonFontSizes.sp18.sp),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    Constants.deleteFirearmdetails,
                                    style: CommonTextStyles.poppinsMediumStyle
                                        .copyWith(
                                            color: AppColors.primaryBlackColor,
                                            fontSize: CommonFontSizes.sp18.sp),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 5.h,
                              ),

                              //Buttons
                              Row(
                                children: [
                                  CommonButton(
                                    onPressed: () {
                                      print("Hello");
                                      deleteFirearmController
                                          .deleteFirearm(widget.firearmId);
                                    },
                                    width: 40.w,
                                    buttonText: Constants.yes,
                                    buttonColor: AppColors.primaryWhiteColor,
                                    textColor: AppColors.borderColor,
                                    horizontalPadding: 20,
                                    verticalPadding: 10,
                                    borderRadius: 25,
                                    iconSpacing: 12,
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    fontWeight: CommonFontWeight.semiBold,
                                    borderColor: Colors.red,
                                  ),
                                  const Spacer(),
                                  CommonButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    width: 40.w,
                                    buttonText: Constants.no,
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    buttonColor: AppColors.secondaryColor,
                                    textColor: AppColors.primaryWhiteColor,
                                    horizontalPadding: 20,
                                    verticalPadding: 10,
                                    borderRadius: 25,
                                    iconSpacing: 12,
                                    borderColor: Colors.red,
                                    fontWeight: CommonFontWeight.semiBold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            ),
    );
  }
}
