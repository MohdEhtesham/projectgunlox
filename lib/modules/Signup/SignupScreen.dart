// ignore_for_file: file_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Login/LoginScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;
import 'SignupController.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _setPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 1.h),
                        Center(
                          child: Container(
                            height: 10.h,
                            width: 50.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.splashLogo),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  // Handle the touch event here
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
                                  Constants.createAccount,
                                  style: CommonTextStyles.poppinsBoldStyle
                                      .copyWith(
                                    fontSize: CommonFontSizes.sp20.sp,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                cursorColor: AppColors.primaryBlackColor,
                                controller: _userNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Full name is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: Constants.username,
                                  hintStyle: CommonTextStyles.poppinsMediumStyle
                                      .copyWith(
                                          color: AppColors.placeholdercolor,
                                          fontSize: CommonFontSizes.sp16.sp),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.w),
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryBlackColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.w),
                                      borderSide: const BorderSide(
                                          color: AppColors.primaryBlackColor)),
                                  prefixIcon: Image.asset(
                                    AppImages.user,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.primaryWhiteColor,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                ),
                                onChanged: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    signupController
                                        .isRegisterButtonActive.value = true;
                                  } else {
                                    signupController
                                        .isRegisterButtonActive.value = false;
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    signupController
                                        .isRegisterButtonActive.value = true;
                                  } else {
                                    signupController
                                        .isRegisterButtonActive.value = false;
                                  }
                                },
                                style: CommonTextStyles.poppinsMediumStyle
                                    .copyWith(
                                        color: AppColors.primaryBlackColor,
                                        fontSize: CommonFontSizes.sp16.sp),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 3.h),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                validator: (value) {
                                  // if (isSignupButtonActive) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email id is required';
                                  }
                                  if (!RegExp(Constants.emailRegex)
                                      .hasMatch(value)) {
                                    return Constants.emailError;
                                  }
                                  return null;
                                  // }
                                },
                                cursorColor: AppColors.primaryBlackColor,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: Constants.enterEmail,
                                  hintStyle: CommonTextStyles.poppinsMediumStyle
                                      .copyWith(
                                          color: AppColors.placeholdercolor,
                                          fontSize: CommonFontSizes.sp16.sp),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.w),
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryBlackColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.w),
                                      borderSide: const BorderSide(
                                          color: AppColors.primaryBlackColor)),
                                  prefixIcon: Image.asset(
                                    AppImages.mail,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.primaryWhiteColor,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                ),
                                onChanged: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    signupController
                                        .isRegisterButtonActive.value = true;
                                  } else {
                                    signupController
                                        .isRegisterButtonActive.value = false;
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    signupController
                                        .isRegisterButtonActive.value = true;
                                  } else {
                                    signupController
                                        .isRegisterButtonActive.value = false;
                                  }
                                },
                                style: CommonTextStyles.poppinsMediumStyle
                                    .copyWith(
                                        color: AppColors.primaryBlackColor,
                                        fontSize: CommonFontSizes.sp16.sp),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 3.h),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                validator: (value) {
                                  // if (isSignupButtonActive) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone number is required';
                                  }
                                  if (value.length < 10) {
                                    return 'Must be atleast 10 characters';
                                  }
                                  return null;
                                  // }
                                },
                                cursorColor: AppColors.primaryBlackColor,
                                controller: _phoneController,
                                maxLength: 10,
                                decoration: InputDecoration(
                                    hintText: Constants.phonumber,
                                    hintStyle: CommonTextStyles
                                        .poppinsMediumStyle
                                        .copyWith(
                                            color: AppColors.placeholdercolor,
                                            fontSize: CommonFontSizes.sp16.sp),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.w),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.w),
                                      borderSide: const BorderSide(
                                          color: AppColors.primaryBlackColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        borderSide: const BorderSide(
                                            color:
                                                AppColors.primaryBlackColor)),
                                    prefixIcon: Image.asset(
                                      AppImages.phone,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.primaryWhiteColor,
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    counterText: ''),
                                onChanged: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    signupController
                                        .isRegisterButtonActive.value = true;
                                  } else {
                                    signupController
                                        .isRegisterButtonActive.value = false;
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    signupController
                                        .isRegisterButtonActive.value = true;
                                  } else {
                                    signupController
                                        .isRegisterButtonActive.value = false;
                                  }
                                },
                                style: CommonTextStyles.poppinsMediumStyle
                                    .copyWith(
                                        color: AppColors.primaryBlackColor,
                                        fontSize: CommonFontSizes.sp16.sp),
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(height: 3.h),
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
                                obscureText:
                                    signupController.passwordVisible.value,
                                controller: _setPasswordController,
                                decoration: InputDecoration(
                                  hintText: Constants.enterPassword,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.w),
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryBlackColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.w),
                                      borderSide: const BorderSide(
                                          color: AppColors.primaryBlackColor)),
                                  hintStyle: CommonTextStyles.poppinsMediumStyle
                                      .copyWith(
                                          color: AppColors.placeholdercolor,
                                          fontSize: CommonFontSizes.sp16.sp),
                                  prefixIcon: Image.asset(
                                    AppImages.key,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.primaryWhiteColor,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      signupController.passwordVisible.value
                                          ? Icons.visibility_off
                                          : Icons.remove_red_eye_outlined,
                                      color: AppColors.silver,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        signupController.passwordVisible.value =
                                            !signupController
                                                .passwordVisible.value;
                                      });
                                    },
                                  ),
                                ),
                                onChanged: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    signupController
                                        .isRegisterButtonActive.value = true;
                                  } else {
                                    signupController
                                        .isRegisterButtonActive.value = false;
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    signupController
                                        .isRegisterButtonActive.value = true;
                                  } else {
                                    signupController
                                        .isRegisterButtonActive.value = false;
                                  }
                                },
                                style: CommonTextStyles.poppinsMediumStyle
                                    .copyWith(
                                        color: AppColors.primaryBlackColor,
                                        fontSize: CommonFontSizes.sp16.sp),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 3.h),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
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
                                obscureText:
                                    signupController.passwordVisible2.value,
                                controller: _confirmPasswordController,
                                decoration: InputDecoration(
                                  hintText: Constants.confirmYourPassword,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.w),
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryBlackColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.w),
                                      borderSide: const BorderSide(
                                          color: AppColors.primaryBlackColor)),
                                  hintStyle: CommonTextStyles.poppinsMediumStyle
                                      .copyWith(
                                          color: AppColors.placeholdercolor,
                                          fontSize: CommonFontSizes.sp16.sp),
                                  prefixIcon: Image.asset(
                                    AppImages.key,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.primaryWhiteColor,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      signupController.passwordVisible2.value
                                          ? Icons.visibility_off
                                          : Icons.remove_red_eye_outlined,
                                      color: AppColors.silver,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        signupController
                                                .passwordVisible2.value =
                                            !signupController
                                                .passwordVisible2.value;
                                      });
                                    },
                                  ),
                                ),
                                onChanged: (value) {
                                  if (_formKey.currentState!.validate()) {}
                                },
                                onFieldSubmitted: (value) {},
                                style: CommonTextStyles.poppinsMediumStyle
                                    .copyWith(
                                        color: AppColors.primaryBlackColor,
                                        fontSize: CommonFontSizes.sp16.sp),
                                keyboardType: TextInputType.emailAddress,
                              ),

                              ///CheckBox and TAndC link
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTileTheme(
                                      horizontalTitleGap: 0.0,
                                      child: CheckboxListTile(
                                        value: signupController
                                            .checkBoxValue.value,
                                        onChanged: (value) {
                                          setState(() {
                                            signupController
                                                .checkBoxValue.value = value!;
                                          });
                                        },
                                        activeColor: AppColors.primaryColor,
                                        side: const BorderSide(
                                            color: AppColors.blacktext),
                                        title: GestureDetector(
                                          onTap: () {
                                            //To uncomment when secured urls are used.
                                            // Get.to(() =>
                                            //     const TermsAndCondition());
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                                text: Constants.iAgree,
                                                style: CommonTextStyles
                                                    .poppinsRegularStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontSize:
                                                            CommonFontSizes
                                                                .sp18.sp),
                                                children: [
                                                  TextSpan(
                                                    text: Constants.tAndC,
                                                    style: CommonTextStyles
                                                        .poppinsRegularStyle
                                                        .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: CommonFontSizes
                                                          .sp18.sp,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              CommonButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    if (!signupController.checkBoxValue.value) {
                                      common.showCustomSnackBar(
                                          "Please accept terms & conditions");
                                    } else {
                                      signupController.isLoading.value = true;
                                      signupController.registerUser(
                                        _userNameController.text,
                                        _emailController.text,
                                        _phoneController.text,
                                        _setPasswordController.text,
                                        _confirmPasswordController.text,
                                      );
                                    }
                                  }
                                },
                                buttonText: Constants.register,
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
                        ),
                        const SizedBox(height: 20.0),

                        ///Do not have an account
                        RichText(
                          text: TextSpan(
                            text: Constants.already,
                            style:
                                CommonTextStyles.poppinsRegularStyle.copyWith(
                              color: AppColors.primaryBlackColor,
                              fontSize: CommonFontSizes.sp16.sp,
                            ),
                            children: [
                              TextSpan(
                                text: " ${Constants.login1}",
                                style: CommonTextStyles.poppinsSemiBoldStyle
                                    .copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: CommonFontSizes.sp18.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAll(() => const LoginScreen());
                                  },
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
    );
  }
}
