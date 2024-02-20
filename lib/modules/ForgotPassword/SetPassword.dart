// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/ForgotPassword/ForgotPasswordController.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

import 'package:responsive_sizer/responsive_sizer.dart';

class SetPassword extends StatefulWidget {
  SetPassword({super.key, required this.accesstoken});

  String accesstoken;

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _setPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return GetX<ForgotPasswordController>(
      init: ForgotPasswordController(),
      builder: (myController) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Stack(
                children: [
                  Positioned(
                    top: 0.h,
                    right: 0.w,
                    child: Image.asset(
                      AppImages.sheild,
                      height: 18.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    left: 1.w,
                    child: Container(
                      height: 18.h,
                      width: 18.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                AppImages.lock,
                              ),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 4.h),
                            Center(
                              child: Container(
                                height: 10.h,
                                width: 45.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.splashLogo),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      height: 10.h,
                                      width: 10.w,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(AppImages.arrow),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 20,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      Constants.Resetpass,
                                      style: CommonTextStyles.poppinsBoldStyle
                                          .copyWith(
                                              fontSize: CommonFontSizes.sp22.sp,
                                              color: AppColors.primaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: 2.h),
                            Center(
                              child: Text(
                                Constants.Resetpasstext,
                                softWrap: true,
                                style: CommonTextStyles.poppinsRegularStyle
                                    .copyWith(
                                        fontSize: CommonFontSizes.sp18.sp,
                                        color: AppColors.primaryBlackColor),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                            Constants.setnewPassword)),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),

                                  //Enter new password
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.disabled,
                                    validator: (value) {
                                      if (!common.validateStructure(value!)) {
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
                                    cursorColor: AppColors.primaryBlackColor,
                                    maxLength: 20,
                                    obscureText: forgotPasswordController
                                        .passwordVisible.value,
                                    controller: _setPasswordController,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintText: Constants.setnewPassword,
                                      filled: true,
                                      fillColor: AppColors.primaryWhiteColor,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        borderSide: const BorderSide(
                                            color: AppColors.primaryBlackColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.w),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.primaryBlackColor)),
                                      hintStyle: CommonTextStyles
                                          .poppinsMediumStyle
                                          .copyWith(
                                              color: AppColors.placeholdercolor,
                                              fontSize:
                                                  CommonFontSizes.sp16.sp),
                                      contentPadding:
                                          const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    ),
                                    onChanged: (value) {
                                      if (_formKey.currentState!.validate()) {
                                        forgotPasswordController
                                            .isActiveButton.value = true;
                                      } else {
                                        forgotPasswordController
                                            .isActiveButton.value = false;
                                      }
                                    },
                                    onFieldSubmitted: (value) {
                                      if (_formKey.currentState!.validate()) {
                                        forgotPasswordController
                                            .isActiveButton.value = true;
                                      } else {
                                        forgotPasswordController
                                            .isActiveButton.value = false;
                                      }
                                    },
                                    style: CommonTextStyles.poppinsMediumStyle
                                        .copyWith(
                                            color: AppColors.primaryBlackColor,
                                            fontSize: CommonFontSizes.sp16.sp),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: 2.h),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        child:
                                            const Text(Constants.setconfirmpassword)),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),

                                  //Confirm new password
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: forgotPasswordController
                                        .passwordVisible.value,
                                    validator: (value) {
                                      if (value == "") {
                                        return Constants.passwordError;
                                      } else if (_setPasswordController.text !=
                                          _confirmPasswordController.text) {
                                        return "New password and confirm new password\nmust be same";
                                      }
                                      //For Password Requirements:
                                      // if (!RegExp(Constants.passwordRegex).hasMatch(value)) {
                                      //   return Constants.passwordError;
                                      // }
                                      return null;
                                    },
                                    cursorColor: AppColors.primaryBlackColor,
                                    controller: _confirmPasswordController,
                                    decoration: InputDecoration(
                                      hintText: Constants.setconfirmpassword,
                                      filled: true,
                                      fillColor: AppColors.primaryWhiteColor,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        borderSide: const BorderSide(
                                            color: AppColors.primaryBlackColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.w),
                                          borderSide: const BorderSide(
                                              color:
                                                  AppColors.primaryBlackColor)),
                                      hintStyle: CommonTextStyles
                                          .poppinsMediumStyle
                                          .copyWith(
                                              color: AppColors.placeholdercolor,
                                              fontSize:
                                                  CommonFontSizes.sp16.sp),
                                      contentPadding:
                                          const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    ),
                                    onChanged: (value) {
                                      forgotPasswordController
                                              .setPasswordVisible.value =
                                          !forgotPasswordController
                                              .setPasswordVisible.value;
                                    },
                                    onFieldSubmitted: (value) {},
                                    style: CommonTextStyles.poppinsMediumStyle
                                        .copyWith(
                                            color: AppColors.primaryBlackColor,
                                            fontSize: CommonFontSizes.sp16.sp),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  CommonButton(
                                    width: 100.w,
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        forgotPasswordController.setPassword(
                                            widget.accesstoken,
                                            _confirmPasswordController.text);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
