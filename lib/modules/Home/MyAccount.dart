
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/DeleteAccount/DeleteAccount.dart';
import 'package:gunlox/modules/Home/ChangePassword.dart';
import 'package:gunlox/modules/Home/ContactUs.dart';
import 'package:gunlox/modules/Home/HomeController.dart';
import 'package:gunlox/modules/Home/LogoutAccountPannel.dart';
import 'package:gunlox/modules/Home/PersonalInformation.dart';
import 'package:gunlox/modules/WelcomePage/WelcomeScreen.dart';
import 'package:gunlox/utils/SharedPreference.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../network/endpoints.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  showDeleteAccountPanel(context) {
    showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const DeleteAccountPanel(),
        );
      },
    );
  }

  showlogoutAccountPanel(context) {
    showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const LogoutAccountPannel(),
        );
      },
    );
  }

  final LocalAuthentication auth = LocalAuthentication();
  var homeController = Get.put(HomeController());

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _launchUrl() async {
    var uri = Uri.parse(Endpoints.SHOP_NOW_URL);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

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
            Get.offAll(const WelcomeScreen());
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

  void _handleLogout() async {
    if (_authorized == 'Authorized') {
      // If authorized, proceed with the logout
      // Perform logout actions here (e.g., navigate to login screen)
      print("Logging out...");
      await GunLoxPrefs.clearPrefs();
      // Example: Navigating to the WelcomeScreen
      Get.offAll(() => const WelcomeScreen());
    } else {
      // If not authorized, you can show a message or handle it accordingly
      print("Authentication required to logout");
      // You might want to show a message to the user or handle it differently
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          blurRadius: 10.0, // Set the blur radius of the shadow
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
                                    width: 15.w,
                                  ),
                                  Container(
                                    height: 10.h,
                                    alignment: Alignment.center,
                                    child: Text(
                                      Constants.MyAccount,
                                      style: CommonTextStyles.poppinsBoldStyle
                                          .copyWith(
                                        fontSize: CommonFontSizes.sp20.sp,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const PersonalInformation());
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 5.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage(AppImages.userinfo),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 5
                                              .w), // Adjust the width as per your requirement
                                      Text(
                                        Constants.personalinfo,
                                        style: CommonTextStyles
                                            .poppinsRegularStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp18.sp,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2.h,
                                color: AppColors.secondaryColor.withOpacity(.5),
                                // Set the color of the underline
                              ),
                              GestureDetector(
                                onTap: () {
                                  _launchUrl();
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 5.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage(AppImages.shopnow),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 5
                                              .w), // Adjust the width as per your requirement
                                      Text(
                                        Constants.shopNow,
                                        style: CommonTextStyles
                                            .poppinsRegularStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp18.sp,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2.h,
                                color: AppColors.secondaryColor.withOpacity(
                                    .5), // Set the color of the underline
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const ChangePassword());
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 5.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage(AppImages.keypass),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 5
                                              .w), // Adjust the width as per your requirement
                                      Text(
                                        Constants.changePass,
                                        style: CommonTextStyles
                                            .poppinsRegularStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp18.sp,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2.h,
                                color: AppColors.secondaryColor.withOpacity(
                                    .5), // Set the color of the underline
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const ContactUs());
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 5.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage(AppImages.contactus),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 5
                                              .w), // Adjust the width as per your requirement
                                      Text(
                                        Constants.contactUs,
                                        style: CommonTextStyles
                                            .poppinsRegularStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp18.sp,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2.h,
                                color: AppColors.secondaryColor.withOpacity(
                                    .5), // Set the color of the underline
                              ),
                              GestureDetector(
                                onTap: () {
                                  //To uncomment when secured urls are used.
                                  // Get.to(() => const Safety());
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 6.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AppImages.safety),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 5
                                              .w), // Adjust the width as per your requirement
                                      Text(
                                        Constants.safety,
                                        style: CommonTextStyles
                                            .poppinsRegularStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp18.sp,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2.h,
                                color: AppColors.secondaryColor.withOpacity(
                                    .5), // Set the color of the underline
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDeleteAccountPanel(context);
                                  print("Deleting account");
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 5.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                AppImages.deleteAccount),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 5
                                              .w), // Adjust the width as per your requirement
                                      Text(
                                        Constants.deleteAccount,
                                        style: CommonTextStyles
                                            .poppinsRegularStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp18.sp,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2.h,
                                color: AppColors.secondaryColor.withOpacity(
                                    .5), // Set the color of the underline
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Logging account");

                                  showlogoutAccountPanel(context);
                                  // _authenticate().then((_) {
                                  //   // After authentication, handle the logout
                                  //   _handleLogout();
                                  // });
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  width: 100.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 5.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AppImages.logout),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 5
                                              .w), // Adjust the width as per your requirement
                                      Text(
                                        Constants.logout,
                                        style: CommonTextStyles
                                            .poppinsRegularStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp18.sp,
                                          color: AppColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
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
    );
  }
}
