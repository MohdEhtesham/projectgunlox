import 'package:flutter/material.dart';

class AppFontFamily {
  static const String poppins = "Poppins";
}

class CommonFontWeight {
  CommonFontWeight._();
  static const FontWeight regular = FontWeight.w200;
  static const FontWeight medium = FontWeight.w400;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w900;
}

class CommonFontSizes {
  CommonFontSizes._();
  static const sp10 = 10.0;
  static const sp12 = 12.0;
  static const sp14 = 14.0;
  static const sp15 = 15.0;
  static const sp16 = 16.0;
  static const sp18 = 18.0;
  static const sp20 = 20.0;
  static const sp22 = 22.0;
  static const sp24 = 24.0;
  static const sp26 = 26.0;
  static const sp28 = 28.0;
  static const sp30 = 30.0;
  static const sp36 = 36.0;
}

class CommonTextStyles {
  CommonTextStyles._();

  static const poppinsRegularStyle = TextStyle(
    fontFamily: AppFontFamily.poppins,
    fontWeight: CommonFontWeight.regular,
    fontSize: CommonFontSizes.sp14,
  );

  static const poppinsMediumStyle = TextStyle(
    fontFamily: AppFontFamily.poppins,
    fontWeight: CommonFontWeight.medium,
    fontSize: CommonFontSizes.sp14,
  );

  static const poppinsSemiBoldStyle = TextStyle(
    fontFamily: AppFontFamily.poppins,
    fontWeight: CommonFontWeight.semiBold,
    fontSize: CommonFontSizes.sp14,
  );

  static const poppinsBoldStyle = TextStyle(
    fontFamily: AppFontFamily.poppins,
    fontWeight: CommonFontWeight.bold,
    fontSize: CommonFontSizes.sp14,
  );
}
