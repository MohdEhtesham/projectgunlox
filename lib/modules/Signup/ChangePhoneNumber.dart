import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/CommonExt/Components.dart';
import '../../components/Constants/AppColors.dart';
import '../../components/Constants/AppDimensions.dart';
import '../../components/Constants/AppFontFamily.dart';
import '../../components/Constants/AppImages.dart';
import '../../components/strings/Constants.dart';
import 'ChangePhoneNumberController.dart';

// ignore: must_be_immutable
class ChangePhoneNumber extends StatefulWidget {
  ChangePhoneNumber(
      {super.key, required this.phoneNumber, required this.email});
  String phoneNumber;
  String email;

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  bool showResend = true;
  int countdown = 30;
  var changePhoneNumberController = Get.put(ChangePhoneNumberController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  top: 12.h,
                  right: 0.w,
                  child: Image.asset(
                    AppImages.sheildcut,
                    height: 16.h,
                    width: 25.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0.h,
                  left: 3.w,
                  child: Image.asset(
                    AppImages.lock,
                    height: 20.h,
                    // width: 25.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // SizedBox(height: 4.h),
                          Container(
                            height: 10.h,
                            width: 50.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.splashLogo),
                              ),
                            ),
                          ),

                          SizedBox(height: 2.h),

                          Container(
                            height: 30.h,
                            width: 60.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.pvp),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Center(
                            child: Text(
                              Constants.phoneverification,
                              style: CommonTextStyles.poppinsBoldStyle.copyWith(
                                fontSize: CommonFontSizes.sp20.sp,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),

                          Text(
                            Constants.enterNewPhone,
                            textAlign: TextAlign.center,
                            style:
                                CommonTextStyles.poppinsRegularStyle.copyWith(
                              fontSize: CommonFontSizes.sp18.sp,
                              color: AppColors.primaryBlackColor,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),

                          //showEnterNumberField

                          TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                            ],
                            validator: (value) {
                              if (value == "") {
                                return 'Phone number is required';
                              }
                              if (!RegExp("[0-9]").hasMatch(value!)) {
                                return Constants.phoneNumberError;
                              }
                              if (value.length < 10) {
                                setState(() {
                                  changePhoneNumberController
                                      .showVerificationSection.value = false;
                                  // _otpController.text = '';
                                  changePhoneNumberController
                                      .isOTPEntered.value = false;
                                });
                                return Constants.phoneNumberError;
                              }
                              FocusManager.instance.primaryFocus?.unfocus();
                              return null;
                            },
                            cursorColor: AppColors.primaryBlackColor,
                            controller: _phoneController,
                            maxLength: 10,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.primaryWhiteColor,
                              hintText: Constants.enterNewPhone,
                              hintStyle: CommonTextStyles.poppinsRegularStyle
                                  .copyWith(
                                      color: AppColors.placeholdercolor,
                                      fontSize: CommonFontSizes.sp16.sp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.w),
                                borderSide: const BorderSide(
                                    color: AppColors.primaryBorderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryBlackColor)),
                              prefixIcon: Image.asset(
                                AppImages.phone,
                              ),
                              suffixIcon: changePhoneNumberController
                                      .showVerificationSection.value
                                  ? Image.asset(AppImages.check)
                                  : null,
                              counterText: "",
                              contentPadding:
                                  const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            ),
                            onChanged: (value) {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                return;
                              }
                            },
                            onFieldSubmitted: (value) {
                              // if (_formKey.currentState!.validate()) {
                              //   print("yes");
                              // }
                            },
                            style: CommonTextStyles.poppinsMediumStyle.copyWith(
                                color: AppColors.primaryBlackColor,
                                fontSize: CommonFontSizes.sp16.sp),
                            keyboardType: TextInputType.phone,
                          ),

                          SizedBox(
                            height: 6.h,
                          ),

                          //Enter verification code section
                          changePhoneNumberController
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
                                                    .primaryBlackColor),
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
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
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
                                        activeColor:
                                            AppColors.primaryBorderColor,
                                        activeFillColor:
                                            AppColors.primaryBorderColor,
                                        selectedColor:
                                            AppColors.primaryBorderColor,
                                        inactiveColor:
                                            AppColors.primaryBorderColor,
                                        disabledColor:
                                            AppColors.primaryBorderColor,
                                        selectedFillColor:
                                            AppColors.primaryBorderColor,
                                        inactiveFillColor:
                                            AppColors.primaryBorderColor,
                                        errorBorderColor:
                                            AppColors.primaryBorderColor,
                                        shape: PinCodeFieldShape.box,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        fieldHeight:
                                            (1.h * AppDimensions.dp0_5) + 40,
                                      ),
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      controller: _otpController,
                                      keyboardType: TextInputType.number,
                                      onCompleted: (v) {
                                        changePhoneNumberController
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
                                                  color: AppColors.recolor,
                                                ),
                                              ),
                                              Text(
                                                "$countdown sec",
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  color: AppColors
                                                      .secondaryColor, // Adjust color as needed
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  showResend = true;
                                                  countdown = 30;
                                                });
                                                Timer.periodic(
                                                    const Duration(seconds: 1),
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
                                                changePhoneNumberController
                                                    .resendPhoneCode(
                                                        _phoneController.text);
                                              },
                                              child: Text(
                                                Constants.resend,
                                                style: CommonTextStyles
                                                    .poppinsRegularStyle
                                                    .copyWith(
                                                  fontSize:
                                                      CommonFontSizes.sp18.sp,
                                                  color: AppColors.recolor,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: 6.h,
                          ),
                          //Send verification|| Next
                          CommonButton(
                            width: 85.w,
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                if (changePhoneNumberController
                                    .isOTPEntered.value) {
                                  print("verifying OTP");
                                  changePhoneNumberController
                                      .verifyPhoneCode(_otpController.text);
                                } else {
                                  print("sharing OTP");
                                  changePhoneNumberController.changePhone(
                                      widget.email, _phoneController.text);
                                  Timer.periodic(const Duration(seconds: 1),
                                      (Timer timer) {
                                    if (countdown == 0) {
                                      // After 30 seconds, switch to another section
                                      timer.cancel();
                                      if (mounted) {
                                        setState(() {
                                          showResend = false;
                                        });
                                      }
                                    } else {
                                      if (mounted) {
                                        setState(() {
                                          countdown--;
                                        });
                                      }
                                    }
                                  });
                                }
                              }
                            },
                            buttonText: changePhoneNumberController
                                    .showVerificationSection.value
                                ? Constants.next
                                : Constants.sendVerificationCode,
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
                          SizedBox(
                            height: 2.h,
                          ),

                          //Cancel button
                          !changePhoneNumberController
                                  .showVerificationSection.value
                              ? CommonButton(
                                  width: 85.w,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  buttonText: Constants.cancel,
                                  buttonColor: AppColors.primaryWhiteColor,
                                  textColor: AppColors.borderColor,
                                  horizontalPadding: 20,
                                  verticalPadding: 10,
                                  borderRadius: 25,
                                  iconSpacing: 12,
                                  fontSize: 18,
                                  fontFamily: "Poppins",
                                  fontWeight: CommonFontWeight.medium,
                                  borderColor: AppColors.borderColor,
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
