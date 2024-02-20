// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Firearm/FirearmDetailsController.dart';
import 'package:gunlox/modules/Firearm/UpdateFirearmEmergencyModel.dart';
import 'package:gunlox/modules/Home/MyAccount.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class FirearmDetailsOptions extends StatefulWidget {
  FirearmDetailsOptions({
    super.key,
    required this.name,
    required this.brand,
    required this.model,
    required this.caliber,
    required this.serialNumber,
  });
  String name;
  String brand;
  String model;
  String caliber;
  String serialNumber;

  @override
  State<FirearmDetailsOptions> createState() => _FirearmDetailsOptionsState();
}

class _FirearmDetailsOptionsState extends State<FirearmDetailsOptions> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool isChecked = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool loading = false;
  var firearmDetalsController = Get.put(FirearmdetailsController());

  showUpdateModelOfEmergency(context) {
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
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: UpdateFirearmEmergencyModel(
              name: widget.name,
              brand: widget.brand,
              model: widget.model,
              caliber: widget.caliber,
              serialNumber: widget.serialNumber,
              isChecked: isChecked,
              isChecked2: isChecked2,
              isChecked3: isChecked3,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 10.h,
                  width: 45.w,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.splashLogo),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const MyAccount());
                  },
                  child: Container(
                    height: 10.h,
                    width: 10.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.useracc),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 10.h,
                    width: 5.w,
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
                    Constants.firearmDetails,
                    style: CommonTextStyles.poppinsBoldStyle.copyWith(
                      fontSize: CommonFontSizes.sp22.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhiteColor,
                        border: Border.all(
                          color: AppColors.blackColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              AppImages.lockIdImage,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Constants.lockId,
                                style:
                                    CommonTextStyles.poppinsBoldStyle.copyWith(
                                  fontSize: CommonFontSizes.sp18.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Text("6784-8574-g574-42e5",
                                  style: CommonTextStyles.poppinsRegularStyle
                                      .copyWith(
                                          fontSize: CommonFontSizes.sp18.sp,
                                          color: AppColors.primaryBlackColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 100.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhiteColor,
                              border: Border.all(
                                color: AppColors.blackColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          Constants.emergency,
                                          style: CommonTextStyles
                                              .poppinsSemiBoldStyle
                                              .copyWith(
                                            fontSize: CommonFontSizes.sp18.sp,
                                            color: AppColors.primaryBlackColor,
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        activeColor: AppColors.primaryColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 2),
                                    child: Text(
                                      Constants.emergencytext,
                                      style: CommonTextStyles
                                          .poppinsRegularStyle
                                          .copyWith(
                                        fontSize: CommonFontSizes.sp16.sp,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            width: 100.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhiteColor,
                              border: Border.all(
                                color: AppColors.blackColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          Constants.storage,
                                          style: CommonTextStyles
                                              .poppinsSemiBoldStyle
                                              .copyWith(
                                            fontSize: CommonFontSizes.sp18.sp,
                                            color: AppColors.primaryBlackColor,
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                        value: isChecked2,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked2 = value!;
                                          });
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        activeColor: AppColors.primaryColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 2),
                                    child: Text(
                                      Constants.storagetext,
                                      style: CommonTextStyles
                                          .poppinsRegularStyle
                                          .copyWith(
                                        fontSize: CommonFontSizes.sp16.sp,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            width: 100.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhiteColor,
                              border: Border.all(
                                color: AppColors.blackColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          Constants.concealed,
                                          style: CommonTextStyles
                                              .poppinsSemiBoldStyle
                                              .copyWith(
                                            fontSize: CommonFontSizes.sp18.sp,
                                            color: AppColors.primaryBlackColor,
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                        value: isChecked3,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked3 = value!;
                                          });
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        activeColor: AppColors.primaryColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 2),
                                    child: Text(
                                      Constants.concealedtext,
                                      style: CommonTextStyles
                                          .poppinsRegularStyle
                                          .copyWith(
                                        fontSize: CommonFontSizes.sp16.sp,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          CommonButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (isChecked2 && isChecked3) {
                                if (_formKey.currentState!.validate()) {
                                  firearmDetalsController
                                      .checkEmergencyList()
                                      .then((_) {
                                    if (isChecked == true) {
                                      if (firearmDetalsController
                                          .emergencyListofFirearm.isEmpty) {
                                        firearmDetalsController.addFirearm(
                                            widget.name,
                                            widget.brand,
                                            widget.model,
                                            widget.caliber,
                                            widget.serialNumber,
                                            isChecked,
                                            isChecked2,
                                            isChecked3);
                                      } else {
                                        showUpdateModelOfEmergency(context);
                                      }
                                    } else {
                                      firearmDetalsController.addFirearm(
                                          widget.name,
                                          widget.brand,
                                          widget.model,
                                          widget.caliber,
                                          widget.serialNumber,
                                          isChecked,
                                          isChecked2,
                                          isChecked3);
                                    }
                                  });
                                }
                              } else {
                                common.showCustomSnackBar(
                                    Constants.selectCheckbox);
                              }
                            },
                            buttonText: Constants.add,
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
