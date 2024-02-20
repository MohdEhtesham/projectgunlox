// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppDimensions.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/ForgotPassword/ForgotPasswordController.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  var forgotPasswordController = Get.put(ForgotPasswordController());

  bool showResend = true;
  int countdown = 30;
  @override
  void initState() {
    super.initState();
    // Start the countdown timer when the widget is created
  }

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
                      AppImages
                          .sheild, // Replace with your background image path
                      height: 18.h, // Adjust height according to your needs

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
                              height: 4.h,
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
                                      Constants.forgotPassword,
                                      style: CommonTextStyles.poppinsBoldStyle
                                          .copyWith(
                                        fontSize: CommonFontSizes.sp22.sp,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            SizedBox(
                              height: 10.h,
                              width: 90.w,
                              child: Center(
                                child: Text(
                                  forgotPasswordController
                                          .showVerificationSection.value
                                      ? Constants.forgototptext
                                      : Constants.forgotPasswordText,
                                  softWrap: true,
                                  style: CommonTextStyles.poppinsRegularStyle
                                      .copyWith(
                                    fontSize: CommonFontSizes.sp18.sp,
                                    color: AppColors.primaryBlackColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email id is required';
                                      }
                                      if (!RegExp(Constants.emailRegex)
                                          .hasMatch(value)) {
                                        return Constants.emailError;
                                      } else {
                                        // setState(() {
                                        //   forgotPasswordController
                                        //       .showVerificationSection
                                        //       .value = false;
                                        // });
                                        return null;
                                      }
                                    },
                                    cursorColor: AppColors.primaryBlackColor,
                                    decoration: InputDecoration(
                                      hintText: Constants.enterEmail,
                                      filled: true,
                                      fillColor: AppColors.primaryWhiteColor,
                                      hintStyle: CommonTextStyles
                                          .poppinsMediumStyle
                                          .copyWith(
                                        color: AppColors.placeholdercolor,
                                        fontSize: CommonFontSizes.sp16.sp,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        borderSide: const BorderSide(
                                            color: AppColors.fieldBorderColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        borderSide: const BorderSide(
                                            color: AppColors.fieldBorderColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        borderSide: const BorderSide(
                                            color: AppColors.fieldBorderColor),
                                      ),
                                      prefixIcon: Image.asset(
                                        AppImages.mail,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      suffixIcon: forgotPasswordController
                                              .showVerificationSection.value
                                          ? Image.asset(AppImages.check)
                                          : null,
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
                                      fontSize: CommonFontSizes.sp16.sp,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),

                                  // Enter verification code section
                                  forgotPasswordController
                                          .showVerificationSection.value
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              width: 90.w,
                                              child: Text(
                                                Constants.verificatioCode,
                                                softWrap: true,
                                                textAlign: TextAlign.left,
                                                style: CommonTextStyles
                                                    .poppinsRegularStyle
                                                    .copyWith(
                                                  fontSize:
                                                      CommonFontSizes.sp18.sp,
                                                  color: AppColors
                                                      .primaryBlackColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            PinCodeTextField(
                                              appContext: context,
                                              length: 6,
                                              autoDisposeControllers: false,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp("[0-9]")),
                                              ],
                                              blinkWhenObscuring: true,
                                              animationType: AnimationType.fade,
                                              validator: (v) {
                                                if (v!.length < 6) {
                                                  return "Please enter complete code";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              pinTheme: PinTheme(
                                                activeColor: AppColors
                                                    .primaryBorderColor,
                                                activeFillColor: AppColors
                                                    .primaryBorderColor,
                                                selectedColor: AppColors
                                                    .primaryBorderColor,
                                                inactiveColor: AppColors
                                                    .primaryBorderColor,
                                                disabledColor: AppColors
                                                    .primaryBorderColor,
                                                selectedFillColor: AppColors
                                                    .primaryBorderColor,
                                                inactiveFillColor: AppColors
                                                    .primaryBorderColor,
                                                errorBorderColor: AppColors
                                                    .primaryBorderColor,
                                                shape: PinCodeFieldShape.box,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                fieldHeight: (1.h *
                                                        AppDimensions.dp0_5) +
                                                    40,
                                              ),
                                              animationDuration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              controller: _otpController,
                                              keyboardType:
                                                  TextInputType.number,
                                              onCompleted: (v) {
                                                forgotPasswordController
                                                    .isOTPEntered.value = true;
                                              },
                                              onChanged: (value) {},
                                              beforeTextPaste: (text) {
                                                return true;
                                              },
                                            ),
                                            showResend
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      const Text(
                                                        "Resend in ",
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        "$countdown sec",
                                                        style: const TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors
                                                              .red, // Adjust color as needed
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          showResend = true;
                                                          countdown = 30;
                                                        });
                                                        Timer.periodic(
                                                            const Duration(
                                                                seconds: 1),
                                                            (Timer timer) {
                                                          if (countdown == 0) {
                                                            // After 30 seconds, switch to another section
                                                            timer.cancel();
                                                            setState(() {
                                                              showResend =
                                                                  false;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              countdown--;
                                                            });
                                                          }
                                                        });
                                                        forgotPasswordController
                                                            .sendForgotPasswordCode(
                                                                _emailController
                                                                    .text);
                                                      },
                                                      child: Text(
                                                        Constants.resend,
                                                        style: CommonTextStyles
                                                            .poppinsRegularStyle
                                                            .copyWith(
                                                          fontSize:
                                                              CommonFontSizes
                                                                  .sp18.sp,
                                                          color:
                                                              AppColors.recolor,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  CommonButton(
                                    width: 100.w,
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        if (forgotPasswordController
                                            .isOTPEntered.value) {
                                          print("verifying OTP");
                                          forgotPasswordController
                                              .verifyEmailCode(
                                                  _otpController.text,
                                                  _emailController.text);
                                        } else {
                                          print("sharing OTP");
                                          // Toggle the visibility of PinCodeTextField
                                          forgotPasswordController
                                              .sendForgotPasswordCode(
                                                  _emailController.text);

                                          Timer.periodic(const Duration(seconds: 1),
                                              (Timer timer) {
                                            if (countdown == 0) {
                                              // After 30 seconds, switch to another section
                                              timer.cancel();
                                              setState(() {
                                                showResend = false;
                                              });
                                            } else {
                                              setState(() {
                                                countdown--;
                                              });
                                            }
                                          });
                                        }
                                      }
                                    },
                                    buttonText: forgotPasswordController
                                            .showVerificationSection.value
                                        ? Constants.submit
                                        : Constants.sendCode,
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
