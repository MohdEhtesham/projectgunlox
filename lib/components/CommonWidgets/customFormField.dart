import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Constants/AppColors.dart';
import '../Constants/AppDimensions.dart';
import '../Constants/AppFontFamily.dart';
import '../strings/Constants.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.isKeyBoardTypeNumber,
    this.isPasswordField,
    this.isEmailField,
    this.isMobileField,
    this.initialValue,
    required this.readonly,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final int? maxLength;
  final bool? isKeyBoardTypeNumber;
  final bool? isPasswordField;
  final bool? isEmailField;
  final bool? isMobileField;
  final bool readonly;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;
    return TextFormField(
      readOnly: readonly,
      maxLength: maxLength,
      keyboardType: isKeyBoardTypeNumber == true
          ? TextInputType.number
          : TextInputType.emailAddress,
      initialValue: initialValue,
      onEditingComplete: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (RegExp(Constants.emailRegex).hasMatch(textEditingController.text)) {
          //will use Getx afterwards
          // setState(() {
          //   isSendCodeButtonActive = true;
          // });
        }
      },
      onChanged: (value) {
        if (RegExp(Constants.emailRegex).hasMatch(value)) {
          //will use Getx afterwards
          // setState(() {
          //   isSendCodeButtonActive = true;
          // });
        } else {
          // setState(() {
          //   isSendCodeButtonActive = false;
          // });
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == "") {
          return 'Required Field';
        }
        if (isEmailField == true &&
            !RegExp(Constants.emailRegex).hasMatch(value!)) {
          return Constants.emailError;
        }
        if (isPasswordField == true && value!.length < 8) {
          return 'Password must be atleast 8 characters';
        }
        if (isMobileField == true && value!.length < 10) {
          return 'Must be atleast 10 characters';
        }
        if (value!.length < 4) {
          return 'Must be atleast 4 characters';
        }

        return null;
      },
      cursorColor: AppColors.backgroundColor,
      controller: textEditingController,
      decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          suffixIconConstraints: BoxConstraints(
            minHeight: (screenHeight * AppDimensions.dp0_08),
            minWidth: (screenWidth * AppDimensions.dp0_08),
            // maxHeight: (screenHeight * AppDimensions.dp0_05),
            // maxWidth: (screenWidth * AppDimensions.dp0_05),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.w),
            borderSide: const BorderSide(color: AppColors.primaryBlackColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.w),
              borderSide: const BorderSide(color: AppColors.primaryBlackColor)),
          hintText: hintText,
          hintStyle: CommonTextStyles.poppinsMediumStyle.copyWith(
              color: AppColors.primaryBlackColor,
              fontSize: CommonFontSizes.sp14.sp),
          counterText: "",
          helperText: ""),
      style: CommonTextStyles.poppinsMediumStyle.copyWith(
          color: AppColors.primaryBlackColor,
          fontSize: CommonFontSizes.sp16.sp),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class CustomTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final IconData? prefixIcon;
//   final IconData? suffixIcon;
//   final bool obscureText;
//   final bool showSuffixIcon;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;

//   CustomTextField({
//     required this.controller,
//     required this.hintText,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.obscureText = false,
//     this.showSuffixIcon = true,
//     this.keyboardType,
//     this.textInputAction,
//   });

//   @override
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   bool _obscurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     IconData currentSuffixIcon = _obscurePassword ? Icons.visibility_off : Icons.visibility;

//     return TextField(
//       controller: widget.controller,
//       obscureText: widget.obscureText && _obscurePassword,
//       keyboardType: widget.keyboardType,
//       textInputAction: widget.textInputAction,
//       decoration: InputDecoration(
//         hintText: widget.hintText,
//         prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
//         suffixIcon: widget.showSuffixIcon
//             ? (widget.suffixIcon != null
//                 ? IconButton(
//                     icon: Icon(currentSuffixIcon),
//                     onPressed: () {
//                       setState(() {
//                         _obscurePassword = !_obscurePassword;
//                       });
//                     },
//                   )
//                 : null)
//             : null,
//         contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.w),
        // ),
//       ),
//     );
//   }
// }
