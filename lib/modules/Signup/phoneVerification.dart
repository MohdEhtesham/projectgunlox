// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppDimensions.dart';

import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Home/HomeScreen.dart.dart';
import 'package:gunlox/modules/Signup/PhoneVerificationController.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:local_auth/local_auth.dart';

import '../../components/Constants/AppFontFamily.dart';
import 'ChangePhoneNumber.dart';

// ignore: must_be_immutable
class PhoneVerification extends StatefulWidget {
  PhoneVerification(
      {super.key,
      required this.phoneNumber,
      required this.accessToken,
      required this.userId,
      required this.email,
      required this.user,
      this.route});
  String phoneNumber;
  String accessToken;
  String userId;
  String email;
  String user;
  String? route;

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final _otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var phoneVerificationController = Get.put(PhoneVerificationController());
  bool showResend = true;
  int countdown = 30;
  @override
  void initState() {
    super.initState();
    // Start the countdown timer when the widget is created
    if (widget.route == "Login Screen") {
      phoneVerificationController.sendPhoneCode(widget.phoneNumber);
    }
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (countdown == 0) {
        // After 30 seconds, switch to another section
        timer.cancel();
        setState(() {
          showResend = false;
        });
      } else {
        if (mounted) {
          setState(() {
            countdown--;
          });
        }
      }
    });
  }

  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  // Future<void> _authenticate() async {
  //   bool authenticated = false;

  //   try {
  //     setState(() {
  //       _isAuthenticating = true;
  //       _authorized = 'Authenticating';
  //     });
  //     authenticated = await auth.authenticate(
  //       localizedReason: 'Let OS determine authentication method',
  //       options: const AuthenticationOptions(
  //         useErrorDialogs: true,
  //         stickyAuth: true,
  //       ),
  //     );
  //     setState(() {
  //       _isAuthenticating = false;
  //     });
  //   } on PlatformException catch (e) {
  //     debugPrint('$e');
  //     setState(() {
  //       _isAuthenticating = false;
  //       _authorized = "Error - ${e.message}";
  //     });
  //     return;
  //   }
  //   if (!mounted) return;

  //   setState(
  //       () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  // }
  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      if (await auth.canCheckBiometrics) {
        setState(() {
          _isAuthenticating = true;
          _authorized = 'Authenticating';
        });

        authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );

        setState(() {
          _isAuthenticating = false;
          if (authenticated) {
            // Navigate to HomeScreen when authenticated
            Get.off(const HomeScreen());
          }
        });
      } else {
        // Biometric authentication is not available on this device
        // You can handle this case, show an alternative authentication method, or inform the user.
        setState(() {
          _authorized = 'Biometric authentication not available';
        });
      }
    } on PlatformException catch (e) {
      debugPrint('$e');
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }

    if (!mounted) return;

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
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
                            "${Constants.pleaseenterphonecode} ******${widget.phoneNumber.substring(widget.phoneNumber.length - 4)}",
                            textAlign: TextAlign.center,
                            style:
                                CommonTextStyles.poppinsRegularStyle.copyWith(
                              fontSize: CommonFontSizes.sp18.sp,
                              color: AppColors.primaryBlackColor,
                            ),
                          ),
                          // : Text(
                          //     Constants.enterNewPhone,
                          //     textAlign: TextAlign.center,
                          //     style: CommonTextStyles.poppinsRegularStyle
                          //         .copyWith(
                          //       fontSize: CommonFontSizes.sp18.sp,
                          //       color: AppColors.primaryBlackColor,
                          //     ),
                          //   ),
                          SizedBox(
                            height: 2.h,
                          ),

                          // OTP verification section
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
                                phoneVerificationController.isOTPEntered.value =
                                    true;
                                return "Please enter complete code";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              activeColor: AppColors.primaryBorderColor,
                              activeFillColor: AppColors.primaryBorderColor,
                              selectedColor: AppColors.primaryBorderColor,
                              inactiveColor: AppColors.primaryBorderColor,
                              disabledColor: AppColors.primaryBorderColor,
                              selectedFillColor: AppColors.primaryBorderColor,
                              inactiveFillColor: AppColors.primaryBorderColor,
                              errorBorderColor: AppColors.primaryBorderColor,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10.0),
                              fieldHeight: (1.h * AppDimensions.dp0_5) + 40,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            onCompleted: (v) {
                              phoneVerificationController.isOTPEntered.value =
                                  true;
                            },
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),

                          // SizedBox(
                          //   height: 6.h,
                          // ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Change phone number button
                              Container(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => ChangePhoneNumber(
                                          email: widget.email,
                                          phoneNumber: widget.phoneNumber,
                                        ));
                                  },
                                  child: Text(
                                    Constants.changeNumber,
                                    style: CommonTextStyles.poppinsRegularStyle
                                        .copyWith(
                                      fontSize: CommonFontSizes.sp18.sp,
                                      color: AppColors.recolor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),

                              //Resend Code Button
                              showResend
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Resend in ",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: AppColors.recolor,
                                            // decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        Text(
                                          "$countdown sec",
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: AppColors
                                                .primaryColor, // Adjust color as needed
                                            // decoration: TextDecoration.underline,
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

                                          phoneVerificationController
                                              .resendPhoneCode(
                                                  widget.phoneNumber,
                                                  widget.accessToken,
                                                  widget.email);
                                        },
                                        child: Text(
                                          Constants.resend,
                                          style: CommonTextStyles
                                              .poppinsRegularStyle
                                              .copyWith(
                                            fontSize: CommonFontSizes.sp18.sp,
                                            color: AppColors.recolor,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),

                          SizedBox(
                            height: 4.h,
                          ),
                          Center(
                            child: CommonButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  if (phoneVerificationController
                                      .isOTPEntered.value) {
                                    print("verifying OTP");

                                    phoneVerificationController.verifyPhoneCode(
                                      _otpController.text,
                                      widget.phoneNumber,
                                      widget.email,
                                      widget.user,
                                    );

                                    if (phoneVerificationController
                                        .isActiveButton) {
                                      _authenticate();
                                    } else {
                                      _cancelAuthentication();
                                    }
                                  }
                                }
                              },
                              buttonText: Constants.next,
                              fontSize: 18,
                              fontFamily: "Poppins",
                              buttonColor: AppColors.secondaryColor,
                              textColor: AppColors.primaryWhiteColor,
                              horizontalPadding: 20,
                              verticalPadding: 10,
                              borderRadius: 25,
                              iconSpacing: 12,
                              borderColor: Colors.red,
                              width: 95.w,
                            ),
                          ),
                          // Text('Current State: $_authorized\n'),
                          //          (_isAuthenticating)
                          // ? ElevatedButton(
                          //     onPressed: _cancelAuthentication,
                          //     child: const Row(
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: [
                          //         Text("Cancel Authentication"),
                          //         Icon(Icons.cancel),
                          //       ],
                          //     ),
                          //   )
                          // : Column(
                          //     children: [
                          //       ElevatedButton(
                          //         onPressed: _authenticate,
                          //         child: const Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             Text('Authenticate'),
                          //             Icon(Icons.fingerprint),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),

                          ///Do not have an account
                        ],
                      ),
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
