// ignore: file_names
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final String? imagePath; 
  final IconData? iconData;
  final Color buttonColor;
  final Color textColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final double iconSpacing;
  final double fontSize;
  final double width;
  final FontWeight fontWeight; // Added font weight
  final Color borderColor;
  final double borderWidth;
  final String fontFamily;

  const CommonButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.width,
    this.imagePath,
    this.iconData,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white,
    this.horizontalPadding = 16,
    this.verticalPadding = 8,
    this.borderRadius = 10,
    this.iconSpacing = 8,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal, // Default font weight is normal
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.fontFamily = 'YourFontFamily',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50.0,
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonColor,
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagePath != null ) ...[
               Image.asset(
                  imagePath!,
                  color: textColor,
                  // height: 10.h, // Adjust the height as needed
                  width: 5.w,  // Adjust the width as needed
                ),
                SizedBox(width: iconSpacing),
              ],
              Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
