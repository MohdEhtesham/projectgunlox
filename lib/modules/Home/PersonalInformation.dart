import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Home/HomeController.dart';
import 'package:gunlox/network/api_client.dart';
import 'package:gunlox/network/endpoints.dart';
import 'package:gunlox/utils/SharedPreference.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _MyAccountState();
}

class _MyAccountState extends State<PersonalInformation> {
  late final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  bool isLoading = false;
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var homeController = Get.put(HomeController());
  late Map userData;
  var userId;
  @override
  void initState() {
    super.initState();
    getUserById();
  }

  getUserDetails() async {
    String userString;
    userString = await GunLoxPrefs.getString('user');
    print("user string $userString");
    if (userString.isNotEmpty) {
      userData = jsonDecode(userString);
    }
  }

  getUserById() async {
    isLoading = true;
    await getUserDetails();
    print(
        "-- deleteAccount userData  $userData && ${userData["user"]["id"]} && ${userData["id"]}");

    var response = await ApiClient().commonGetAPIMethod(
      "${Endpoints.GET_USER}/${userData["user"]["id"]}?access_token=${userData["id"]}",
      {
        'Content-Type': 'application/json',
      },
    );
    if (response != null && response.containsKey("fullName")) {
      setState(() {
        _userNameController.text = response["fullName"] ?? "";
        _emailController.text = response["email"] ?? "";
        _phoneController.text = response["phone"] ?? "";
      });
    }

    print(" details: $response");
    print(" details: $_userNameController");

    // print("education  ${education}");
    isLoading = false;
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
                              offset: Offset(
                                  0, 0.0), // Set the offset of the shadow
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
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              image:
                                                  AssetImage(AppImages.arrow),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Container(
                                        height: 10.h,
                                        width: 70.w,
                                        alignment: Alignment.center,
                                        child: Text(
                                          Constants.PersonalInformation,
                                          style: CommonTextStyles
                                              .poppinsBoldStyle
                                              .copyWith(
                                            fontSize: CommonFontSizes.sp20.sp,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        )
                                      : Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    Constants.name,
                                                    style: CommonTextStyles
                                                        .poppinsRegularStyle
                                                        .copyWith(
                                                      fontSize: CommonFontSizes
                                                          .sp18.sp,
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode.disabled,
                                                cursorColor:
                                                    AppColors.primaryBlackColor,
                                                controller: _userNameController,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Name is required";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  hintStyle: CommonTextStyles
                                                      .poppinsMediumStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .placeholdercolor,
                                                          fontSize:
                                                              CommonFontSizes
                                                                  .sp16.sp),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.w),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.w),
                                                    borderSide: const BorderSide(
                                                        color: AppColors
                                                            .primaryBlackColor),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.w),
                                                      borderSide: const BorderSide(
                                                          color: AppColors
                                                              .primaryBlackColor)),
                                                  filled: true,
                                                  fillColor: AppColors
                                                      .primaryWhiteColor,
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 0, 15, 0),
                                                ),
                                                onChanged: (value) {
                                                  // if (_formKey.currentState!.validate()) {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = true;
                                                  // } else {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = false;
                                                  // }
                                                },
                                                onFieldSubmitted: (value) {
                                                  // if (_formKey.currentState!.validate()) {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = true;
                                                  // } else {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = false;
                                                  // }
                                                },
                                                style: CommonTextStyles
                                                    .poppinsMediumStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryBlackColor,
                                                        fontSize:
                                                            CommonFontSizes
                                                                .sp16.sp),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                              ),
                                              SizedBox(height: 3.h),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    Constants.email,
                                                    style: CommonTextStyles
                                                        .poppinsRegularStyle
                                                        .copyWith(
                                                      fontSize: CommonFontSizes
                                                          .sp18.sp,
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),

                                              //EMAIL FIELD
                                              TextFormField(
                                                enabled: false,
                                                autovalidateMode:
                                                    AutovalidateMode.disabled,
                                                validator: (value) {
                                                  // if (isSignupButtonActive) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Email id is required';
                                                  }
                                                  if (!RegExp(
                                                          Constants.emailRegex)
                                                      .hasMatch(value)) {
                                                    return Constants.emailError;
                                                  }
                                                  return null;
                                                  // }
                                                },
                                                cursorColor:
                                                    AppColors.primaryBlackColor,
                                                controller: _emailController,
                                                decoration: InputDecoration(
                                                  hintStyle: CommonTextStyles
                                                      .poppinsMediumStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .placeholdercolor,
                                                          fontSize:
                                                              CommonFontSizes
                                                                  .sp16.sp),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.w),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.w),
                                                    borderSide: const BorderSide(
                                                        color: AppColors
                                                            .primaryBlackColor),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.w),
                                                      borderSide: const BorderSide(
                                                          color: AppColors
                                                              .primaryBlackColor)),
                                                  filled: true,
                                                  fillColor: AppColors
                                                      .primaryWhiteColor,
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 0, 15, 0),
                                                ),
                                                onChanged: (value) {
                                                  // if (_formKey.currentState!.validate()) {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = true;
                                                  // } else {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = false;
                                                  // }
                                                },
                                                onFieldSubmitted: (value) {
                                                  // if (_formKey.currentState!.validate()) {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = true;
                                                  // } else {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = false;
                                                  // }
                                                },
                                                style: CommonTextStyles
                                                    .poppinsMediumStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .slightGrey,
                                                        fontSize:
                                                            CommonFontSizes
                                                                .sp16.sp),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                              ),
                                              SizedBox(height: 3.h),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    Constants.phoneNo,
                                                    style: CommonTextStyles
                                                        .poppinsRegularStyle
                                                        .copyWith(
                                                      fontSize: CommonFontSizes
                                                          .sp18.sp,
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),

                                              //PHONE-NO FIELD
                                              TextFormField(
                                                enabled: false,
                                                autovalidateMode:
                                                    AutovalidateMode.disabled,
                                                validator: (value) {
                                                  // if (isSignupButtonActive) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Phone number is required';
                                                  }
                                                  if (value.length < 10) {
                                                    return 'Must be atleast 10 characters';
                                                  }
                                                  return null;
                                                  // }
                                                },
                                                cursorColor:
                                                    AppColors.primaryBlackColor,
                                                controller: _phoneController,
                                                maxLength: 10,
                                                decoration: InputDecoration(
                                                    hintStyle: CommonTextStyles
                                                        .poppinsMediumStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .placeholdercolor,
                                                            fontSize:
                                                                CommonFontSizes
                                                                    .sp16.sp),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.w),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.w),
                                                      borderSide: const BorderSide(
                                                          color: AppColors
                                                              .primaryBlackColor),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.w),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .primaryBlackColor)),
                                                    filled: true,
                                                    fillColor: AppColors
                                                        .primaryWhiteColor,
                                                    contentPadding:
                                                        const EdgeInsets.fromLTRB(
                                                            15, 0, 15, 0),
                                                    counterText: ''),
                                                onChanged: (value) {
                                                  // if (_formKey.currentState!.validate()) {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = true;
                                                  // } else {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = false;
                                                  // }
                                                },
                                                onFieldSubmitted: (value) {
                                                  // if (_formKey.currentState!.validate()) {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = true;
                                                  // } else {
                                                  //   signupController
                                                  //       .isRegisterButtonActive.value = false;
                                                  // }
                                                },
                                                style: CommonTextStyles
                                                    .poppinsMediumStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .slightGrey,
                                                        fontSize:
                                                            CommonFontSizes
                                                                .sp16.sp),
                                                keyboardType:
                                                    TextInputType.phone,
                                              ),
                                              SizedBox(height: 20.h),
                                              CommonButton(
                                                onPressed: () {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    homeController.updateUser(
                                                      _userNameController.text,
                                                    );
                                                  }
                                                },
                                                buttonText: Constants.save,
                                                fontSize: 20,
                                                fontFamily: "Poppins",
                                                buttonColor:
                                                    AppColors.secondaryColor,
                                                textColor:
                                                    AppColors.primaryWhiteColor,
                                                horizontalPadding: 20,
                                                verticalPadding: 10,
                                                borderRadius: 25,
                                                iconSpacing: 12,
                                                borderColor: Colors.red,
                                                width: 90.w,
                                                fontWeight:
                                                    CommonFontWeight.semiBold,
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
      ),
    );
  }
}
