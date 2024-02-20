import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/modules/Firearm/AddAuthorizedUserController.dart';
import 'package:gunlox/modules/Firearm/FirearmDetailsController.dart';
import 'package:gunlox/utils/SharedPreference.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class FirearmAddUsers extends StatefulWidget {
  FirearmAddUsers({super.key, required this.firearmId});
  String firearmId;
  @override
  State<FirearmAddUsers> createState() => _FirearmAddUsersState();
}

class _FirearmAddUsersState extends State<FirearmAddUsers> {
  var addFirearmUserController = Get.put(FirearmdetailsController());
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  var addAuthorizedUser = Get.put(AddAuthorizedUserController());

  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isNextPressed = false;

  bool isLoading = false;
  late Map userData;
  late String name;
  late String email;
  late List<Map<String, dynamic>> usersAuthorized = [];

  @override
  void initState() {
    super.initState();
    getUserAuthorizedUser();
  }

  getUserDetails() async {
    String userString;
    userString = await GunLoxPrefs.getString('user');
    if (userString.isNotEmpty) {
      userData = jsonDecode(userString);
    }
  }

  getUserAuthorizedUser() async {
    isLoading = true;
    await getUserDetails();

    Map<String, dynamic> filterParams = {
      'where': {'firearmsId': widget.firearmId},
      'include': 'user',
    };
    String filter = jsonEncode(filterParams);

    // URL encoding the filter parameter
    String encodedFilter = Uri.encodeQueryComponent(filter);

    // Constructing the URL with the encoded filter parameter
    String url =
        "http://159.89.234.66:8912/api/firearm-mappings?filter=$encodedFilter";

    try {
      print("Request URL: $url");

      // Making the HTTP GET request with the Content-Type header
      final response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      print("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Response Body: ${response.body}");
        String jsonString = response.body;

        List<Map<String, dynamic>> userAuthorized2 =
            List<Map<String, dynamic>>.from(jsonDecode(jsonString));

        if (userAuthorized2.isNotEmpty) {
          // Extracting email and name for all users
          for (var item in userAuthorized2) {
            String emailValue = item['email'];
            String firstName = item['firstName'];
            String lastName = item['lastName'];

            print('Email: $emailValue');
            print('First Name: $firstName');
            print('Last Name: $lastName');
          }

          // Correct print statement
          print("User Authorized Length: ${userAuthorized2.length}");
          print("User Authorized Length: $userAuthorized2");
          setState(() {
            usersAuthorized = userAuthorized2;
          });
        } else {
          print('Response is empty.');
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    isLoading = false;
  }
void _showUserModal() {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      if (usersAuthorized.isNotEmpty) {
        return Container(
          child: ListView.builder(
            itemCount: usersAuthorized.length,
            itemBuilder: (context, index) {
              var users = usersAuthorized[index];

              return ListTile(
                title: Text(users['firstName'] + " " + users['lastName']),
                onTap: () {
                  setState(() {
                    _userNameController.text =
                        users['firstName'] + " " + users['lastName'];
                  });
                  Get.back();
                },
              );
            },
          ),
        );
      } else {
        return Container(
          child: ListTile(
            title: const Text("No user added"),
            onTap: () {
              setState(() {
                // Your logic when no user is added
              });
              Get.back();
            },
          ),
        );
      }
    },
  );
}

 

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => addFirearmUserController.isLoading.value
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
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 12.w,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryWhiteColor,
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 10.h,
                                          alignment: Alignment.center,
                                          child: Text(
                                            Constants.selectexisting,
                                            style: CommonTextStyles
                                                .poppinsRegularStyle
                                                .copyWith(
                                              fontSize: CommonFontSizes.sp18.sp,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: _showUserModal,
                                          child: Container(
                                            height: 8.h,
                                            width: 10.w,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    AppImages.userDropDown),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
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
                                      AppImages.user,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.primaryWhiteColor,
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  ),
                                  onChanged: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      addFirearmUserController
                                          .isActiveButton.value = true;
                                    } else {
                                      addFirearmUserController
                                          .isActiveButton.value = false;
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      addFirearmUserController
                                          .isActiveButton.value = true;
                                    } else {
                                      addFirearmUserController
                                          .isActiveButton.value = false;
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
                                      AppImages.mail,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.primaryWhiteColor,
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  ),
                                  onChanged: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      addFirearmUserController
                                          .isActiveButton.value = true;
                                    } else {
                                      addFirearmUserController
                                          .isActiveButton.value = false;
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      addFirearmUserController
                                          .isActiveButton.value = true;
                                    } else {
                                      addFirearmUserController
                                          .isActiveButton.value = false;
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
                                              fontSize:
                                                  CommonFontSizes.sp16.sp),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
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
                                      addFirearmUserController
                                          .isActiveButton.value = true;
                                    } else {
                                      addFirearmUserController
                                          .isActiveButton.value = false;
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      addFirearmUserController
                                          .isActiveButton.value = true;
                                    } else {
                                      addFirearmUserController
                                          .isActiveButton.value = false;
                                    }
                                  },
                                  style: CommonTextStyles.poppinsMediumStyle
                                      .copyWith(
                                          color: AppColors.primaryBlackColor,
                                          fontSize: CommonFontSizes.sp16.sp),
                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(height: 3.h),
                                CommonButton(
                                  onPressed: () {

                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                          FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                          
                                                      addAuthorizedUser.addAuthorizedUser(
                                          _userNameController.text,
                                          _emailController.text,
                                          _phoneController.text,
                                          widget.firearmId);
                                                      // if (_formKey.currentState!
                                                      //     .validate()) {
                                                      
                                                      // }
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
                        ),
                      ]),
                ),
              ],
            ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.silver
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 0.0;
    const double dashSpace = 0.0;
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
