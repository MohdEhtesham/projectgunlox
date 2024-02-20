// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gunlox/components/Constants/AppColors.dart';
// import 'package:gunlox/components/Constants/AppFontFamily.dart';
// import 'package:gunlox/components/Constants/AppImages.dart';
// import 'package:gunlox/components/strings/Constants.dart';
// import 'package:gunlox/modules/DeleteAccount/DeleteAccount.dart';
// import 'package:gunlox/modules/Login/LoginScreen.dart';
// import 'package:gunlox/utils/SharedPreference.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// // ignore: must_be_immutable
// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   showDeleteAccountPanel(context) {
//     showModalBottomSheet<void>(
//         // context and builder are
//         // required properties in this widget
//         context: context,
//         isScrollControlled: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
//         ),
//         builder: (BuildContext context) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: DeleteAccountPanel(),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//         canPop: false,
//         child: Scaffold(
//           appBar: AppBar(
//             // centerTitle: true,
//             title: Container(
//               height: 40.w,
//               width: 40.w,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(AppImages.splashLogo),
//                 ),
//               ),
//             ),
//           ),
//           body: SizedBox(
//             width: 100.w,
//             height: 100.h,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ListTile(
//                   title: Text(
//                     Constants.deleteAccount,
//                     style: CommonTextStyles.poppinsRegularStyle.copyWith(
//                         color: AppColors.primaryBlackColor,
//                         fontSize: CommonFontSizes.sp20.sp),
//                   ),
//                   leading: Image(
//                     image: const AssetImage(AppImages.deleteAccount),
//                     color: AppColors.primaryColor,
//                     width: 6.w,
//                     height: 6.w,
//                   ),
//                   onTap: () {
//                     showDeleteAccountPanel(context);
//                   },
//                 ),
//                 ListTile(
//                   title: Text(
//                     Constants.logout,
//                     style: CommonTextStyles.poppinsRegularStyle.copyWith(
//                         color: AppColors.primaryBlackColor,
//                         fontSize: CommonFontSizes.sp20.sp),
//                   ),
//                   leading: Image(
//                     image: const AssetImage(AppImages.logout),
//                     color: AppColors.primaryColor,
//                     width: 6.w,
//                     height: 6.w,
//                   ),
//                   onTap: () async {
//                     await GunLoxPrefs.clearPrefs();
//                     Get.offAll(() => const LoginScreen());
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
