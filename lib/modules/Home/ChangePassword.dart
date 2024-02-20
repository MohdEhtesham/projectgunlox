import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Home/HomeController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _oldPasswordController = TextEditingController();
  final _setPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var homeController = Get.put(HomeController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0.h,
                right: 0.w,
                child: Container(
                  alignment: Alignment.centerRight,
                  width: 100.w,
                  height: 15.h,
                  // Adjusted from left to right
                  child: Image.asset(
                    AppImages.wave,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(30.0),
                          topEnd: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondaryColor,
                            // Set the color of the shadow
                            offset:
                                Offset(0, 0.0), // Set the offset of the shadow
                            blurRadius:
                                10.0, // Set the blur radius of the shadow
                            spreadRadius:
                                -2.0, // Set a negative spread radius for an inner shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        height: 8.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AppImages.arrow),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Container(
                                      height: 10.h,
                                      alignment: Alignment.center,
                                      child: Text(
                                        Constants.changePass,
                                        style: CommonTextStyles.poppinsBoldStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp22.sp,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            Constants.changePasswordText,
                                            style: CommonTextStyles
                                                .poppinsRegularStyle
                                                .copyWith(
                                              fontSize: CommonFontSizes.sp18.sp,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            Constants.setnewOldPassword,
                                            style: CommonTextStyles
                                                .poppinsRegularStyle
                                                .copyWith(
                                              fontSize: CommonFontSizes.sp18.sp,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        obscureText: true,
                                        validator: (value) {
                                          // if (!common
                                          //     .validateStructure(value!)) {
                                          //   return Constants.passwordRegExError;
                                          // }
                                          if (value == "") {
                                            return Constants
                                                .currentPasswordError;
                                          }
                                          if (value!.length > 20) {
                                            return "Password can not be more than 20 characters.";
                                          }

                                          //For Password Requirements:
                                          // if (!RegExp(Constants.passwordRegex).hasMatch(value)) {
                                          //   return Constants.passwordError;
                                          // }
                                          return null;
                                        },
                                        cursorColor:
                                            AppColors.primaryBlackColor,
                                        maxLength: 20,
                                        //  obscureText: homeController
                                        //      .passwordVisible.value,
                                        controller: _oldPasswordController,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: Constants.oldPassword,
                                          filled: true,
                                          fillColor:
                                              AppColors.primaryWhiteColor,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .primaryBlackColor),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.w),
                                              borderSide: const BorderSide(
                                                  color: AppColors
                                                      .primaryBlackColor)),
                                          hintStyle: CommonTextStyles
                                              .poppinsMediumStyle
                                              .copyWith(
                                                  color: AppColors
                                                      .placeholdercolor,
                                                  fontSize:
                                                      CommonFontSizes.sp16.sp),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        ),

                                        onChanged: (value) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            homeController
                                                .isActiveButton.value = true;
                                          } else {
                                            homeController
                                                .isActiveButton.value = false;
                                          }
                                        },
                                        onFieldSubmitted: (value) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            homeController
                                                .isActiveButton.value = true;
                                          } else {
                                            homeController
                                                .isActiveButton.value = false;
                                          }
                                        },
                                        style: CommonTextStyles
                                            .poppinsMediumStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryBlackColor,
                                                fontSize:
                                                    CommonFontSizes.sp16.sp),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      SizedBox(height: 2.h),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            Constants.setnewPassword,
                                            style: CommonTextStyles
                                                .poppinsRegularStyle
                                                .copyWith(
                                              fontSize: CommonFontSizes.sp18.sp,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        obscureText: true,

                                        validator: (value) {
                                          if (!common
                                              .validateStructure(value!)) {
                                            return Constants.passwordRegExError;
                                          }
                                          if (value.length > 20) {
                                            return "Password can not be more than 20 characters.";
                                          }
                                          if (value == "") {
                                            return Constants.passwordError;
                                          }
                                          //For Password Requirements:
                                          // if (!RegExp(Constants.passwordRegex).hasMatch(value)) {
                                          //   return Constants.passwordError;
                                          // }
                                          return null;
                                        },
                                        cursorColor:
                                            AppColors.primaryBlackColor,
                                        maxLength: 20,
                                        //  obscureText: homeController
                                        //      .passwordVisible.value,
                                        controller: _setPasswordController,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: Constants.enterNewPassword,
                                          filled: true,
                                          fillColor:
                                              AppColors.primaryWhiteColor,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .primaryBlackColor),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.w),
                                              borderSide: const BorderSide(
                                                  color: AppColors
                                                      .primaryBlackColor)),
                                          hintStyle: CommonTextStyles
                                              .poppinsMediumStyle
                                              .copyWith(
                                                  color: AppColors
                                                      .placeholdercolor,
                                                  fontSize:
                                                      CommonFontSizes.sp16.sp),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        ),

                                        onChanged: (value) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            homeController
                                                .isActiveButton.value = true;
                                          } else {
                                            homeController
                                                .isActiveButton.value = false;
                                          }
                                        },
                                        onFieldSubmitted: (value) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            homeController
                                                .isActiveButton.value = true;
                                          } else {
                                            homeController
                                                .isActiveButton.value = false;
                                          }
                                        },
                                        style: CommonTextStyles
                                            .poppinsMediumStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryBlackColor,
                                                fontSize:
                                                    CommonFontSizes.sp16.sp),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      SizedBox(height: 2.h),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            Constants.setconfirmpassword,
                                            style: CommonTextStyles
                                                .poppinsRegularStyle
                                                .copyWith(
                                              fontSize: CommonFontSizes.sp18.sp,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        obscureText: true,
                                        //  obscureText: homeController
                                        //      .passwordVisible.value,
                                        validator: (value) {
                                          if (value == "") {
                                            return Constants.passwordError;
                                          } else if (_setPasswordController
                                                  .text !=
                                              _confirmPasswordController.text) {
                                            return "New password and confirm new password\nmust be same";
                                          }
                                          //For Password Requirements:
                                          // if (!RegExp(Constants.passwordRegex).hasMatch(value)) {
                                          //   return Constants.passwordError;
                                          // }
                                          return null;
                                        },
                                        cursorColor:
                                            AppColors.primaryBlackColor,
                                        controller: _confirmPasswordController,
                                        decoration: InputDecoration(
                                          hintText:
                                              Constants.confirmYourPassword,
                                          filled: true,
                                          fillColor:
                                              AppColors.primaryWhiteColor,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .primaryBlackColor),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.w),
                                              borderSide: const BorderSide(
                                                  color: AppColors
                                                      .primaryBlackColor)),
                                          hintStyle: CommonTextStyles
                                              .poppinsMediumStyle
                                              .copyWith(
                                                  color: AppColors
                                                      .placeholdercolor,
                                                  fontSize:
                                                      CommonFontSizes.sp16.sp),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        ),
                                        onChanged: (value) {
                                        
                                        },
                                        onFieldSubmitted: (value) {},
                                        style: CommonTextStyles
                                            .poppinsMediumStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryBlackColor,
                                                fontSize:
                                                    CommonFontSizes.sp16.sp),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CommonButton(
                                        width: 100.w,
                                        onPressed: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            homeController.changePassword(
                                                _oldPasswordController.text,
                                                _setPasswordController.text);
                                          }
                                        },
                                        buttonText: Constants.save,
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 8.h,
                          width: 45.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.splashLogo),
                            ),
                          ),
                        ),
                        Container(
                          height: 8.h,
                          width: 10.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppImages.useracc),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
