import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Firearm/FirearmDeatilsUpdateController.dart';
import 'package:gunlox/modules/Firearm/FirearmDetailsController.dart';
import 'package:local_auth/local_auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class UpdateExistngFirearmEmergemcy extends StatefulWidget {
  UpdateExistngFirearmEmergemcy({
    super.key,
    required this.name,
    required this.brand,
    required this.model,
    required this.caliber,
    required this.serialNumber,
    required this.isChecked,
    required this.isChecked2,
    required this.isChecked3,
    required this.userId,
    required this.id,

  });

  String name;
  String brand;
  String model;
  String caliber;
  String serialNumber;
  bool isChecked;
  bool isChecked2;
  bool isChecked3;
  String userId;
  String id;

  @override
  State<UpdateExistngFirearmEmergemcy> createState() =>
      _UpdateExistngFirearmEmergemcyState();
}

class _UpdateExistngFirearmEmergemcyState
    extends State<UpdateExistngFirearmEmergemcy> {
  var firearmUpdate = Get.put(FirearmDetailsUpdateController());
  var firearmDetailsController = Get.put(FirearmdetailsController());

  bool isNextPressed = false;
  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
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
          if (authenticated) {}
        });
      } else {
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

  void _handleUpdateEmergency() async {
    if (_authorized == 'Authorized') {
      print("Logging out...");
      updateEmergency(
       widget.userId,
       widget.id,
       widget.isChecked,
        
        );

    } else {
      print("Authentication required to delete Account");
    }
  }

  updateEmergency(userId, id,status) async {
    await firearmUpdate.UpdateFirearmEmergency(
      userId,
      id,
      status
    );
       Get.back();

  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => firearmUpdate.isLoading.value
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
                            Text(
                              Constants.emergencyFirearmUpdate,
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
                                  Row(
                                    children: [
                                      Text(
                                        "Firearm Name: ",
                                        style: CommonTextStyles
                                            .poppinsMediumStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryBlackColor,
                                                fontSize:
                                                    CommonFontSizes.sp18.sp),
                                      ),
                                      Text(
                                        firearmDetailsController
                                            .emergencyListofFirearm[0].name!,
                                        style: CommonTextStyles
                                            .poppinsMediumStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryBlackColor,
                                                fontSize:
                                                    CommonFontSizes.sp18.sp),
                                      ),
                                    ],
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
                                      _authenticate().then((_) {
                                        // After authentication, handle the logout
                                        _handleUpdateEmergency();
                                      });
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
