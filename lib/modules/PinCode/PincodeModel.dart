import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../components/Constants/AppColors.dart';
import '../../components/Constants/AppDimensions.dart';

// ignore: must_be_immutable
class PincodeModel extends StatefulWidget {
  const PincodeModel({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;
  @override
  State<PincodeModel> createState() => PincodeModelState();
}

class PincodeModelState extends State<PincodeModel> {
  double screenHeight = Get.height;
  bool isOTPEntered = false;
  double screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      autoDisposeControllers: false,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        if (v!.length < 6) {
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
        fieldHeight: (screenHeight * AppDimensions.dp0_05) + 5,
      ),
      animationDuration: const Duration(milliseconds: 300),
      controller: widget.controller,
      keyboardType: TextInputType.number,
      onCompleted: (v) {
        setState(() {
          isOTPEntered = true;
        });
      },
      onChanged: (value) {},
      beforeTextPaste: (text) {
        return true;
      },
    );
  }
}
