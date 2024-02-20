// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/CommonExt/Components.dart';
import 'package:gunlox/components/Constants/AppColors.dart';
import 'package:gunlox/components/Constants/AppFontFamily.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/components/strings/Constants.dart';
import 'package:gunlox/models/UpdateExistngFirearmEmergemcy.dart';
import 'package:gunlox/modules/Firearm/FirearmAddUsers.dart';
import 'package:gunlox/modules/Firearm/FirearmDeatilsUpdateController.dart';
import 'package:gunlox/modules/Firearm/FirearmDetailsController.dart';
import 'package:gunlox/modules/Firearm/FirearmDetailsGetController.dart';
import 'package:gunlox/modules/Firearm/FirearmDetailsModal.dart';
import 'package:gunlox/modules/Firearm/RemoveAccountUser.dart';
import 'package:gunlox/modules/Home/MyAccount.dart';
import 'package:intl/intl.dart';
// import 'package:gunlox/network/endpoints.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:local_auth/local_auth.dart';
import '../../../components/CommonFunctions/CommonFunctions.dart' as common;

class FirearmDetails2 extends StatefulWidget {
  FirearmDetails2({super.key, required this.firearmId});
  String firearmId;

  @override
  State<FirearmDetails2> createState() => _FirearmDetails2State();
}

class _FirearmDetails2State extends State<FirearmDetails2> {
  var firearmGetController = Get.put(FirearmDetailsGetController());
  var firearmUpdateController = Get.put(FirearmDetailsUpdateController());
  var firearmDetailsController = Get.put(FirearmdetailsController());

  bool editMode = false;
  bool loading = true;
  late final _nameController = TextEditingController();
  late final _brandController = TextEditingController();
  late final _modelController = TextEditingController();
  late final _gaugeController = TextEditingController();
  late final _serialController = TextEditingController();

  @override
  void initState() {
    super.initState();

    firearmGetController.getFirearmDetails(widget.firearmId).then((_) {
      _nameController.text =
          firearmGetController.firearmDetails!['name']! ?? "";
      _brandController.text = firearmGetController.firearmDetails!['brand']!;
      _modelController.text = firearmGetController.firearmDetails!['model']!;
      _gaugeController.text = firearmGetController.firearmDetails!['caliber']!;
      _serialController.text =
          firearmGetController.firearmDetails!['serialNumber']!;
      isChecked = firearmGetController.firearmDetails!['emergency']!;
      setState(() {
        loading = false;
      });
    });

    firearmGetController.getUserAuthorized(widget.firearmId);
  }

  bool isChecked = false;

  bool isExpanded = false;
  bool isExpanded2 = false;
  final _formKey = GlobalKey<FormState>();

  final List<String> dataList = [
    'hello@gmail.com',
    'wass@gmail.com',
    'nighty@gmail.com',
    'nighty@gmail.com',
  ];
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

  void _handleAddUser() async {
    if (_authorized == 'Authorized') {
      showAddAccountPanel(context);
      print(" addUsers Successfully");
    } else {
      print("Authentication required to addUsers");
    }
  }

  showDeleteFirearm(
    context,
  ) {
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
          child: FirearmdetailsModal(firearmId: widget.firearmId),
        );
      },
    );
  }

  showAddAccountPanel(context) {
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
          child: FirearmAddUsers(firearmId: widget.firearmId),
        );
      },
    );
  }

  showDeleteAccountPanel(context, id) {
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
          child: RemoveAccountUser(id: id),
        );
      },
    );
  }

  showUpdateModelOfEmergency() {
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
        print("jhdsjkhhfjkdsfkdsfkd: $isChecked");
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: UpdateExistngFirearmEmergemcy(
              name: firearmGetController.firearmDetails!['name']!,
              brand: firearmGetController.firearmDetails!['brand']!,
              model: firearmGetController.firearmDetails!['model']!,
              caliber: firearmGetController.firearmDetails!['caliber']!,
              serialNumber:
                  firearmGetController.firearmDetails!['serialNumber']!,
              isChecked: isChecked,
              isChecked2: firearmGetController.firearmDetails!['storage']!,
              isChecked3: firearmGetController.firearmDetails!['concealed']!,
              userId: firearmGetController.firearmDetails!['userId']!,
              id: firearmGetController.firearmDetails!['id']!,
            ));
      },
    );
  }

  // Future<void> _handleRefresh() async {
  //   // Simulate a network request or any asynchronous operation
  //   firearmGetController.getFirearmDetails(widget.firearmId);
  //   getUserAuthorized();
  //   await Future.delayed(const Duration(seconds: 2));
  // }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                isExpanded2
                    ? Container(
                        height: 10.h,
                        alignment: Alignment.center,
                        child: Text(
                          Constants.events,
                          style: CommonTextStyles.poppinsBoldStyle.copyWith(
                            fontSize: CommonFontSizes.sp22.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    : Container(
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
                isExpanded || isExpanded2
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          showDeleteFirearm(context);
                        },
                        child: Container(
                          height: 8.h,
                          width: 8.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.deleteAccount),
                            ),
                          ),
                        ),
                      )
              ],
            ),
            firearmGetController.isLoading.value
                ? SizedBox(
                    height: 60.h,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.primaryWhiteColor,
                                border: Border.all(
                                  color: AppColors.blackColor.withOpacity(0.2),
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.blackColor.withOpacity(0.1),
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      width: 70.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${firearmGetController.firearmDetails!['name']!}',
                                            softWrap: true,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: CommonFontSizes.sp16.sp,
                                              color:
                                                  AppColors.primaryBlackColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${firearmGetController.firearmDetails!['model']!}',
                                            softWrap: true,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: CommonFontSizes.sp16.sp,
                                              color:
                                                  AppColors.primaryBlackColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: Constants.serial,
                                              style: CommonTextStyles
                                                  .poppinsRegularStyle
                                                  .copyWith(
                                                color:
                                                    AppColors.primaryBlackColor,
                                                fontSize:
                                                    CommonFontSizes.sp16.sp,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${firearmGetController.firearmDetails!['serialNumber']!}',
                                                  style: CommonTextStyles
                                                      .poppinsRegularStyle
                                                      .copyWith(
                                                    color: AppColors.blackColor,
                                                    fontSize:
                                                        CommonFontSizes.sp16.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        AppImages.signal,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2.0,
                            child: Container(
                              // height: isExpanded ? 80.0.h : 7.0.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.primaryWhiteColor,
                                border: Border.all(
                                  color: AppColors.blackColor.withOpacity(0.2),
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.blackColor.withOpacity(0.1),
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Constants.details,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                            color: AppColors.primaryBlackColor,
                                          ),
                                        ),
                                        isExpanded
                                            ? Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        editMode = !editMode;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 5.h,
                                                      width: 10.w,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Image.asset(
                                                        AppImages.editicon,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isExpanded =
                                                            !isExpanded;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 5.h,
                                                      width: 10.w,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Image.asset(
                                                        AppImages.uparrow,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isExpanded =
                                                            !isExpanded;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 5.h,
                                                      width: 10.w,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Image.asset(
                                                        AppImages.dropdownarrow,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                    if (isExpanded) ...[
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.disabled,
                                              cursorColor:
                                                  AppColors.primaryBlackColor,
                                              controller: _nameController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Nick name is required';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: Constants.nickName,
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
                                                fillColor:
                                                    AppColors.primaryWhiteColor,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 15, 0),
                                              ),
                                              onChanged: (value) {},
                                              onFieldSubmitted: (value) {},
                                              style: CommonTextStyles
                                                  .poppinsMediumStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryBlackColor,
                                                      fontSize: CommonFontSizes
                                                          .sp16.sp),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              enabled: editMode,
                                            ),
                                            SizedBox(height: 3.h),
                                            TextFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.disabled,
                                              cursorColor:
                                                  AppColors.primaryBlackColor,
                                              controller: _brandController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Brand name is required';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: Constants.brand,
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
                                                fillColor:
                                                    AppColors.primaryWhiteColor,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 15, 0),
                                              ),
                                              onChanged: (value) {},
                                              onFieldSubmitted: (value) {},
                                              style: CommonTextStyles
                                                  .poppinsMediumStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryBlackColor,
                                                      fontSize: CommonFontSizes
                                                          .sp16.sp),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              enabled: editMode,
                                            ),
                                            SizedBox(height: 3.h),
                                            TextFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.disabled,
                                              cursorColor:
                                                  AppColors.primaryBlackColor,
                                              controller: _modelController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Model number is required';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: Constants.model,
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
                                                fillColor:
                                                    AppColors.primaryWhiteColor,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 15, 0),
                                              ),
                                              onChanged: (value) {},
                                              onFieldSubmitted: (value) {},
                                              style: CommonTextStyles
                                                  .poppinsMediumStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryBlackColor,
                                                      fontSize: CommonFontSizes
                                                          .sp16.sp),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              enabled: editMode,
                                            ),
                                            SizedBox(height: 3.h),
                                            TextFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.disabled,
                                              cursorColor:
                                                  AppColors.primaryBlackColor,
                                              controller: _gaugeController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Caliber or Gauge is required';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: Constants.gauge,
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
                                                fillColor:
                                                    AppColors.primaryWhiteColor,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 15, 0),
                                              ),
                                              onChanged: (value) {},
                                              onFieldSubmitted: (value) {},
                                              style: CommonTextStyles
                                                  .poppinsMediumStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryBlackColor,
                                                      fontSize: CommonFontSizes
                                                          .sp16.sp),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              enabled: editMode,
                                            ),
                                            SizedBox(height: 3.h),
                                            TextFormField(
                                              autovalidateMode:
                                                  AutovalidateMode.disabled,
                                              cursorColor:
                                                  AppColors.primaryBlackColor,
                                              controller: _serialController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Serial number is required';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    Constants.serialnumber,
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
                                                fillColor:
                                                    AppColors.primaryWhiteColor,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 0, 15, 0),
                                              ),
                                              onChanged: (value) {},
                                              onFieldSubmitted: (value) {},
                                              style: CommonTextStyles
                                                  .poppinsMediumStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryBlackColor,
                                                      fontSize: CommonFontSizes
                                                          .sp16.sp),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              enabled: editMode,
                                            ),
                                            SizedBox(height: 5.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 35.w,
                                                  child: CommonButton(
                                                    onPressed: () {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      setState(() {
                                                        isExpanded =
                                                            !isExpanded;
                                                        editMode = false;
                                                      });
                                                    },
                                                    buttonText:
                                                        Constants.cancel,
                                                    fontSize: 20,
                                                    fontFamily: "Poppins",
                                                    buttonColor: AppColors
                                                        .primaryWhiteColor,
                                                    textColor:
                                                        AppColors.primaryColor,
                                                    horizontalPadding: 20,
                                                    verticalPadding: 10,
                                                    borderRadius: 25,
                                                    iconSpacing: 12,
                                                    borderColor: Colors.red,
                                                    width: 90.w,
                                                    fontWeight: CommonFontWeight
                                                        .regular,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 35.w,
                                                  child: CommonButton(
                                                    onPressed: () {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      if (editMode == false) {}
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        if (editMode != true) {
                                                          common.showCustomSnackBar(
                                                              Constants
                                                                  .firearmUpdatesave);
                                                        } else {
                                                          firearmUpdateController.firearmDeatlsUpdate(
                                                              _nameController
                                                                  .text,
                                                              _brandController
                                                                  .text,
                                                              _modelController
                                                                  .text,
                                                              _serialController
                                                                  .text,
                                                              _gaugeController
                                                                  .text,
                                                              isChecked,
                                                              firearmGetController
                                                                      .firearmDetails![
                                                                  'storage']!,
                                                              firearmGetController
                                                                      .firearmDetails![
                                                                  'concealed']!,
                                                              widget.firearmId);
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            setState(() {
                                                              isExpanded =
                                                                  !isExpanded;
                                                              editMode =
                                                                  !editMode;
                                                            });
                                                          }
                                                          firearmGetController
                                                              .getFirearmDetails(
                                                                  widget.firearmId);
                                                        }
                                                      }
                                                    },
                                                    buttonText: Constants.save,
                                                    fontSize: 20,
                                                    fontFamily: "Poppins",
                                                    buttonColor: AppColors
                                                        .secondaryColor,
                                                    textColor: AppColors
                                                        .primaryWhiteColor,
                                                    horizontalPadding: 20,
                                                    verticalPadding: 10,
                                                    borderRadius: 25,
                                                    iconSpacing: 12,
                                                    borderColor: Colors.red,
                                                    width: 90.w,
                                                    fontWeight: CommonFontWeight
                                                        .regular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),

                          //Add authorized user panel
                          Card(
                            elevation: 2.0,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.primaryWhiteColor,
                                border: Border.all(
                                  color: AppColors.blackColor.withOpacity(0.2),
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.blackColor.withOpacity(0.1),
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Constants.authorizedusers,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          color: AppColors.primaryBlackColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _authenticate().then((_) {
                                            _handleAddUser();
                                          });
                                        },
                                        child: Container(
                                          height: 5.h,
                                          width: 10.w,
                                          padding: EdgeInsets.only(right: 4.w),
                                          alignment: Alignment.centerRight,
                                          child: Image.asset(
                                            AppImages.plusicon,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: firearmGetController
                                        .authorizedUser.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(0),
                                    itemBuilder: (context, index) {
                                      // var users = usersAuthorized[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            // height: 10.h,
                                            color: AppColors.primaryWhiteColor,
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // width: 60.w,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              // users!['firstName'] +
                                                              //     " " +
                                                              //     users![
                                                              //         'lastName'],
                                                              '${firearmGetController.authorizedUser[index].firstName!} ${firearmGetController.authorizedUser[index].lastName!}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .black, // You can replace with your color
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // width: 60.w,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              firearmGetController
                                                                  .authorizedUser[
                                                                      index]
                                                                  .email!,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .black, // You can replace with your color
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDeleteAccountPanel(
                                                        context,
                                                        firearmGetController
                                                            .authorizedUser[
                                                                index]
                                                            .id!);
                                                  },
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Text(
                                                      Constants.remove,
                                                      style: CommonTextStyles
                                                          .poppinsRegularStyle
                                                          .copyWith(
                                                        fontSize:
                                                            CommonFontSizes
                                                                .sp16.sp,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return CustomPaint(
                                        painter: DashedLinePainter(),
                                        child: Container(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Card(
                            elevation: 2.0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.primaryWhiteColor,
                                border: Border.all(
                                  color: AppColors.blackColor.withOpacity(0.2),
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.blackColor.withOpacity(0.1),
                                    spreadRadius: 2.0,
                                    blurRadius: 4.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Constants.emergency,
                                          style: CommonTextStyles
                                              .poppinsSemiBoldStyle
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                            color: AppColors.primaryBlackColor,
                                          ),
                                        ),
                                        Checkbox(
                                          value: isChecked,
                                          onChanged: (value) {
                                            setState(() {
                                              isChecked = value!;
                                            });
                                            print("hhhhhhhhhsd: $isChecked");
                                            firearmDetailsController
                                                .checkEmergencyList()
                                                .then((_) {
                                              if (isChecked == true) {
                                                if (firearmDetailsController
                                                    .emergencyListofFirearm
                                                    .isEmpty) {
                                                  firearmUpdateController
                                                      .UpdateFirearmEmergency(
                                                    firearmGetController
                                                            .firearmDetails![
                                                        'userId']!,
                                                    firearmGetController
                                                        .firearmDetails!['id']!,
                                                    isChecked,
                                                  );
                                                } else {
                                                  showUpdateModelOfEmergency();
                                                }
                                              } else {
                                                showUpdateModelOfEmergency();
                                              }
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            side: const BorderSide(
                                              color: AppColors.blackColor,
                                              width: .0,
                                            ),
                                          ),
                                          activeColor: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Constants.storage2,
                                          style: CommonTextStyles
                                              .poppinsSemiBoldStyle
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                            color: AppColors.primaryBlackColor,
                                          ),
                                        ),
                                        Container(
                                          child: Checkbox(
                                            value: firearmGetController
                                                .firearmDetails!['storage']!,
                                            onChanged: (value) {
                                              // setState(() {
                                              //   isChecked2 = value!;
                                              // });
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            activeColor: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Constants.concealed2,
                                          style: CommonTextStyles
                                              .poppinsSemiBoldStyle
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                            color: AppColors.primaryBlackColor,
                                          ),
                                        ),
                                        Container(
                                          child: Checkbox(
                                            value: firearmGetController
                                                .firearmDetails!['concealed']!,
                                            onChanged: (value) {
                                              // setState(() {
                                              //   isChecked3 = value!;
                                              // });
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            activeColor: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          //Events
                          Card(
                              elevation: 2.0,
                              child: Container(
                                // height: isExpanded2 ? 80.0.h : 7.0.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColors.primaryWhiteColor,
                                  border: Border.all(
                                    color:
                                        AppColors.blackColor.withOpacity(0.2),
                                    width: 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColors.blackColor.withOpacity(0.1),
                                      spreadRadius: 2.0,
                                      blurRadius: 4.0,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Constants.events,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp,
                                              color:
                                                  AppColors.primaryBlackColor,
                                            ),
                                          ),
                                          isExpanded2
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isExpanded2 =
                                                          !isExpanded2;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 5.h,
                                                    width: 10.w,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Image.asset(
                                                      AppImages.uparrow,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isExpanded2 =
                                                          !isExpanded2;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 5.h,
                                                    width: 10.w,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Image.asset(
                                                      AppImages.dropdownarrow,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      if (isExpanded2) ...[
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(
                                                  width: 70.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${firearmGetController.firearmDetails!['name']!}',
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              CommonFontSizes
                                                                  .sp16.sp,
                                                          color: AppColors
                                                              .primaryBlackColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        '${firearmGetController.firearmDetails!['model']!}',
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize:
                                                              CommonFontSizes
                                                                  .sp16.sp,
                                                          color: AppColors
                                                              .primaryBlackColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              Constants.serial,
                                                          style: CommonTextStyles
                                                              .poppinsRegularStyle
                                                              .copyWith(
                                                            color: AppColors
                                                                .primaryBlackColor,
                                                            fontSize:
                                                                CommonFontSizes
                                                                    .sp16.sp,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '${firearmGetController.firearmDetails!['serialNumber']!}',
                                                              style: CommonTextStyles
                                                                  .poppinsRegularStyle
                                                                  .copyWith(
                                                                color: AppColors
                                                                    .blackColor,
                                                                fontSize:
                                                                    CommonFontSizes
                                                                        .sp16
                                                                        .sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Image.asset(
                                                    AppImages.signal,
                                                    fit: BoxFit.contain,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: Constants.serial,
                                                style: CommonTextStyles
                                                    .poppinsRegularStyle
                                                    .copyWith(
                                                  color: AppColors
                                                      .primaryBlackColor,
                                                  fontSize:
                                                      CommonFontSizes.sp16.sp,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${firearmGetController.firearmDetails!['serialNumber']!}',
                                                    style: CommonTextStyles
                                                        .poppinsRegularStyle
                                                        .copyWith(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontSize: CommonFontSizes
                                                          .sp16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: Constants.firearmadded,
                                                style: CommonTextStyles
                                                    .poppinsRegularStyle
                                                    .copyWith(
                                                  color: AppColors
                                                      .primaryBlackColor,
                                                  fontSize:
                                                      CommonFontSizes.sp16.sp,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: DateFormat.yMd()
                                                        .format(DateTime.parse(
                                                            firearmGetController
                                                                    .firearmDetails![
                                                                'createdAt']!)),
                                                    style: CommonTextStyles
                                                        .poppinsRegularStyle
                                                        .copyWith(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontSize: CommonFontSizes
                                                          .sp16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            CustomPaint(
                                              painter: DashedLinePainter(),
                                              child: Container(
                                                height: 1.h,
                                              ),
                                            ),
                                            ListView.builder(
                                              itemCount: dataList.length,
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.all(0),
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              Constants.locked,
                                                              style: CommonTextStyles
                                                                  .poppinsBoldStyle
                                                                  .copyWith(
                                                                fontSize:
                                                                    CommonFontSizes
                                                                        .sp16
                                                                        .sp,
                                                                color: AppColors
                                                                    .primaryBlackColor,
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Text(
                                                                "10/14/2023",
                                                                style: CommonTextStyles
                                                                    .poppinsRegularStyle
                                                                    .copyWith(
                                                                  fontSize:
                                                                      CommonFontSizes
                                                                          .sp16
                                                                          .sp,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "By: Jeremy VanWinkle",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 16.sp,
                                                                color: AppColors
                                                                    .primaryBlackColor,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Container(
                                                                child: Text(
                                                                  "15:45",
                                                                  style: CommonTextStyles
                                                                      .poppinsRegularStyle
                                                                      .copyWith(
                                                                    fontSize:
                                                                        CommonFontSizes
                                                                            .sp16
                                                                            .sp,
                                                                    color: AppColors
                                                                        .blackColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    CustomPaint(
                                                      painter:
                                                          DashedLinePainter(),
                                                      child: Container(
                                                        height: 1.h,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              )),
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

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.silver
      ..strokeWidth = 2.0
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
