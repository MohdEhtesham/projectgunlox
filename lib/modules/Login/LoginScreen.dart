// ignore_for_file: file_names
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/ForgotPassword/ForgotPasswordScreen.dart';
import 'package:gunlox/modules/Login/LoginController.dart';
import 'package:gunlox/modules/Login/PhoneLogin/PhoneLogin.dart';
import 'package:gunlox/modules/Signup/SignupScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Stack(
            children: [
              Positioned(
                top: 12.h,
                right: 0.w,
                child: Image.asset(
                  AppImages
                      .sheildcut, // Replace with your background image path
                  height: 16.h, // Adjust height according to your needs
                  width: 25.w, // Adjust width according to your needs
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
                child: ListView(
                  children: [
                    SizedBox(height: 2.h),
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

                    SizedBox(height: 4.h),
                    Center(
                      child: Text(
                        Constants.login,
                        style: CommonTextStyles.poppinsBoldStyle.copyWith(
                            fontSize: CommonFontSizes.sp20.sp,
                            color: AppColors.primaryColor),
                      ),
                    ),

                    SizedBox(height: 4.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (value) {
                              // if (isLoginButtonActive) {
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
                            cursorColor: AppColors.fieldBorderColor,
                            controller: _emailController,
                            decoration: InputDecoration(
                                hintText: Constants.enterEmail,
                                hintStyle: CommonTextStyles.poppinsMediumStyle
                                    .copyWith(
                                        color: AppColors.placeholdercolor,
                                        fontSize: CommonFontSizes.sp16.sp),
                                filled: true,
                                fillColor: AppColors.primaryWhiteColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                      color: AppColors.fieldBorderColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                      color: AppColors.fieldBorderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.w),
                                    borderSide: const BorderSide(
                                        color: AppColors.fieldBorderColor)),
                                prefixIcon: Image.asset(
                                  AppImages.mail,
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0)),
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                loginController.isLoginButtonActive.value =
                                    true;
                              } else {
                                loginController.isLoginButtonActive.value =
                                    false;
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (_formKey.currentState!.validate()) {
                                loginController.isLoginButtonActive.value =
                                    true;
                              } else {
                                loginController.isLoginButtonActive.value =
                                    false;
                              }
                            },
                            style: CommonTextStyles.poppinsMediumStyle.copyWith(
                                color: AppColors.primaryBlackColor,
                                fontSize: CommonFontSizes.sp16.sp),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 2.h),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              }
                              //For Password Requirements:
                              // if (!RegExp(Constants.passwordRegex)
                              //     .hasMatch(value)) {
                              //   return Constants.passwordError;
                              // }
                              return null;
                              // }
                            },
                            cursorColor: AppColors.fieldBorderColor,
                            obscureText: loginController.passwordVisible.value,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: Constants.enterPassword,
                              filled: true,
                              fillColor: AppColors.primaryWhiteColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.w),
                                borderSide: const BorderSide(
                                    color: AppColors.fieldBorderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.w),
                                borderSide: const BorderSide(
                                    color: AppColors.fieldBorderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                      color: AppColors.fieldBorderColor)),
                              hintStyle: CommonTextStyles.poppinsMediumStyle
                                  .copyWith(
                                      color: AppColors.placeholdercolor,
                                      fontSize: CommonFontSizes.sp16.sp),
                              prefixIcon: Image.asset(
                                AppImages.key,
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  loginController.passwordVisible.value
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye_outlined,
                                  color: AppColors.silver,
                                ),
                                onPressed: () {
                                  setState(() {
                                    loginController.passwordVisible.value =
                                        !loginController.passwordVisible.value;
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                loginController.isLoginButtonActive.value =
                                    true;
                              } else {
                                loginController.isLoginButtonActive.value =
                                    false;
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (_formKey.currentState!.validate()) {
                                loginController.isLoginButtonActive.value =
                                    true;
                              } else {
                                loginController.isLoginButtonActive.value =
                                    false;
                              }
                            },
                            style: CommonTextStyles.poppinsMediumStyle.copyWith(
                                color: AppColors.primaryBlackColor,
                                fontSize: CommonFontSizes.sp16.sp),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 45.w,
                                child: ListTileTheme(
                                  horizontalTitleGap: 0.0,
                                  child: CheckboxListTile(
                                    value: loginController.rememberMe.value,
                                    onChanged: (value) {
                                      setState(() {
                                        loginController.rememberMe.value =
                                            value!;
                                      });
                                    },
                                    activeColor: AppColors.primaryColor,
                                    side: const BorderSide(
                                        color: AppColors.primaryColor),
                                    title: Text(
                                      Constants.rememberme,
                                      style: CommonTextStyles
                                          .poppinsRegularStyle
                                          .copyWith(
                                        color: AppColors.secondaryColor,
                                        fontSize: CommonFontSizes.sp16.sp,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(() => const ForgotPasswordScreen());
                                  },
                                  child: Text(
                                    "${Constants.forgotPassword} ?",
                                    style: CommonTextStyles.poppinsRegularStyle
                                        .copyWith(
                                      color: AppColors.secondaryColor,
                                      fontSize: CommonFontSizes.sp16.sp,
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          CommonButton(
                            width: 100.w,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                loginController.isLoading.value = true;
                                loginController.doLogin(_emailController.text,
                                    _passwordController.text);
                              }
                            },
                            buttonText: Constants.login,
                            fontSize: 20.sp,
                            fontFamily: "Poppins",
                            buttonColor: AppColors.secondaryColor,
                            textColor: AppColors.primaryWhiteColor,
                            horizontalPadding: 20,
                            borderRadius: 25,
                            iconSpacing: 12,
                            borderColor: Colors.red,
                            fontWeight: CommonFontWeight.semiBold,
                          ),
                        ],
                      ),
                    ),
                    //
                    SizedBox(height: 3.h),
                    Center(
                      child: CommonButton(
                        width: 100.w,
                        onPressed: () {
                          Get.to(() => const PhoneLogin());
                        },
                        buttonText: Constants.logInvia,
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
                      ),
                    ),
                    SizedBox(height: 3.h),
                    const Center(
                      child: DividerWithText(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    ///Do not have an account
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: Constants.dontHaveAccount,
                          style: CommonTextStyles.poppinsMediumStyle.copyWith(
                            color: AppColors.primaryBlackColor,
                            fontSize: CommonFontSizes.sp16.sp,
                          ),
                          children: [
                            TextSpan(
                              text: "${Constants.signUp}!",
                              style:
                                  CommonTextStyles.poppinsMediumStyle.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: CommonFontSizes.sp16.sp,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => const SignupScreen());
                                },
                            ),
                          ],
                        ),
                      ),
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

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.borderColor
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 4.0;
    const double dashSpace = 4.0;
    double currentX = 0.0;

    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0.0),
        Offset(currentX + dashWidth, 0.0),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomPaint(
            painter: DashedLinePainter(),
            child: Container(
              height: 2.0,
              
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            Constants.OR,
            style: CommonTextStyles.poppinsMediumStyle.copyWith(
                fontSize: CommonFontSizes.sp18.sp,
                color: AppColors.primaryBlackColor),
          ),
        ),
        Expanded(
          child: CustomPaint(
            painter: DashedLinePainter(),
            child: Container(
              height: 2.0,
            ),
          ),
        ),
      ],
    );
  }
}
