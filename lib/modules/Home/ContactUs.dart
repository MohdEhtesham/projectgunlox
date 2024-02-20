import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Home/HomeController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                            blurRadius:
                                10.0, // Set the blur radius of the shadow
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
                                        Constants.contactUs,
                                        style: CommonTextStyles.poppinsBoldStyle
                                            .copyWith(
                                          fontSize: CommonFontSizes.sp22.sp,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          Constants.contactUsText,
                                          style: CommonTextStyles
                                              .poppinsRegularStyle
                                              .copyWith(
                                            fontSize: CommonFontSizes.sp18.sp,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        validator: (value) {
                                          if (value == "") {
                                            return Constants.subjectError;
                                          }

                                          return null;
                                        },
                                        cursorColor:
                                            AppColors.primaryBlackColor,
                                        controller: _subjectController,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: Constants.entersub,
                                          filled: true,
                                          fillColor:
                                              AppColors.primaryWhiteColor,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.w),
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .primaryBlackColor),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.w),
                                              borderSide: const BorderSide(
                                                  color: AppColors
                                                      .primaryBlackColor)),
                                          hintStyle: CommonTextStyles
                                              .poppinsMediumStyle
                                              .copyWith(
                                                  color: AppColors
                                                      .placeholdercolor,
                                                  fontSize:
                                                      CommonFontSizes.sp16.sp),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        ),
                                        onChanged: (value) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            homeController
                                                .isActiveButton.value = true;
                                          } else {
                                            homeController
                                                .isActiveButton.value = false;
                                          }
                                        },
                                        onFieldSubmitted: (value) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            homeController
                                                .isActiveButton.value = true;
                                          } else {
                                            homeController
                                                .isActiveButton.value = false;
                                          }
                                        },
                                        style: CommonTextStyles
                                            .poppinsMediumStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryBlackColor,
                                                fontSize:
                                                    CommonFontSizes.sp16.sp),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      SizedBox(height: 2.h),
                                      SizedBox(
                                        height: 30.h,
                                        child: TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.disabled,
                                          validator: (value) {
                                            if (value == "") {
                                              return Constants.messageError;
                                            }

                                            return null;
                                          },
                                          cursorColor:
                                              AppColors.primaryBlackColor,
                                          maxLines: 30,
                                          controller: _messageController,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            hintText: Constants.writemessage,
                                            filled: true,
                                            fillColor:
                                                AppColors.primaryWhiteColor,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.w),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.w),
                                              borderSide: const BorderSide(
                                                  color: AppColors
                                                      .primaryBlackColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(2.w),
                                                borderSide: const BorderSide(
                                                    color: AppColors
                                                        .primaryBlackColor)),
                                            hintStyle: CommonTextStyles
                                                .poppinsMediumStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .placeholdercolor,
                                                    fontSize: CommonFontSizes
                                                        .sp16.sp),
                                          ),
                                          textAlign: TextAlign.start,
                                          onChanged: (value) {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              homeController
                                                  .isActiveButton.value = true;
                                            } else {
                                              homeController
                                                  .isActiveButton.value = false;
                                            }
                                          },
                                          onFieldSubmitted: (value) {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              homeController
                                                  .isActiveButton.value = true;
                                            } else {
                                              homeController
                                                  .isActiveButton.value = false;
                                            }
                                          },
                                          style: CommonTextStyles
                                              .poppinsMediumStyle
                                              .copyWith(
                                                  color: AppColors
                                                      .primaryBlackColor,
                                                  fontSize:
                                                      CommonFontSizes.sp16.sp),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CommonButton(
                                        width: 100.w,
                                        onPressed: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            homeController.contactUs(
                                                _subjectController.text,
                                                _messageController.text);
                                          }
                                        },
                                        buttonText: Constants.submit,
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
      ),
    );
  }
}
