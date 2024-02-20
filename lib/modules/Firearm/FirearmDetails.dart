import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Firearm/FirearmDetailsController.dart';
import 'package:gunlox/modules/Firearm/FirearmDetailsOptaions.dart';
import 'package:gunlox/modules/Home/MyAccount.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FirearmDetails extends StatefulWidget {
  FirearmDetails({super.key, required this.device});
  // String lockId;
  BluetoothDevice device;

  @override
  State<FirearmDetails> createState() => _FirearmDetailsState();
}

class _FirearmDetailsState extends State<FirearmDetails> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _gaugeController = TextEditingController();
  final _serialController = TextEditingController();
  var firearmController = Get.put(FirearmdetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          color: AppColors.blackColor.withOpacity(.5),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                  fontSize: CommonFontSizes.sp16.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Text(
                                "${widget.device.remoteId}",
                                softWrap: true,
                                style: CommonTextStyles.poppinsRegularStyle
                                    .copyWith(
                                        fontSize: CommonFontSizes.sp15.sp,
                                        color: AppColors.primaryBlackColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            cursorColor: AppColors.primaryBlackColor,
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nick name is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: Constants.nickName,
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
                                  color: AppColors.primaryBlackColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryBlackColor)),
                              filled: true,
                              fillColor: AppColors.primaryWhiteColor,
                              contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            ),
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            style: CommonTextStyles.poppinsMediumStyle.copyWith(
                                color: AppColors.primaryBlackColor,
                                fontSize: CommonFontSizes.sp16.sp),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 3.h),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            cursorColor: AppColors.primaryBlackColor,
                            controller: _brandController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Brand name is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: Constants.brand,
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
                              filled: true,
                              fillColor: AppColors.primaryWhiteColor,
                              contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            ),
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            style: CommonTextStyles.poppinsMediumStyle.copyWith(
                                color: AppColors.primaryBlackColor,
                                fontSize: CommonFontSizes.sp16.sp),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 3.h),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            cursorColor: AppColors.primaryBlackColor,
                            controller: _modelController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Model number is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: Constants.model,
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
                              filled: true,
                              fillColor: AppColors.primaryWhiteColor,
                              contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            ),
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            style: CommonTextStyles.poppinsMediumStyle.copyWith(
                                color: AppColors.primaryBlackColor,
                                fontSize: CommonFontSizes.sp16.sp),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 3.h),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            cursorColor: AppColors.primaryBlackColor,
                            controller: _gaugeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Caliber or Gauge is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: Constants.gauge,
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
                              filled: true,
                              fillColor: AppColors.primaryWhiteColor,
                              contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            ),
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            style: CommonTextStyles.poppinsMediumStyle.copyWith(
                                color: AppColors.primaryBlackColor,
                                fontSize: CommonFontSizes.sp16.sp),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 3.h),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            cursorColor: AppColors.primaryBlackColor,
                            controller: _serialController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Serial number is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: Constants.serialnumber,
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
                              filled: true,
                              fillColor: AppColors.primaryWhiteColor,
                              contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            ),
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (_formKey.currentState!.validate()) {
                                firearmController.isActiveButton.value = true;
                              } else {
                                firearmController.isActiveButton.value = false;
                              }
                            },
                            style: CommonTextStyles.poppinsMediumStyle.copyWith(
                                color: AppColors.primaryBlackColor,
                                fontSize: CommonFontSizes.sp16.sp),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 3.h),
                          CommonButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                Get.to(() => FirearmDetailsOptions(
                                      name: _nameController.text,
                                      brand: _brandController.text,
                                      model: _modelController.text,
                                      caliber: _gaugeController.text,
                                      serialNumber: _serialController.text,
                                    ));
                              }
                            },
                            buttonText: Constants.nex,
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
