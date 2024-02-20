// import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:get/get.dart';
// import 'package:gunlox/modules/Notifications/NotificationController.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class NotificationNavigationHandler extends StatefulWidget {
//   const NotificationNavigationHandler(
//       {Key? key, required this.message, required this.messageData})
//       : super(key: key);
//   final RemoteMessage message;
//   final messageData;

//   @override
//   State<NotificationNavigationHandler> createState() =>
//       _NotificationNavigationHandlerState();
// }

// class _NotificationNavigationHandlerState
//     extends State<NotificationNavigationHandler> {
//   var notificationController = Get.put(NotificationController());

//   @override
//   void initState() {
//     print("----Init");
//     Future.delayed(Duration.zero, () {
//       notificationController.checkNotification(
//           widget.message, widget.messageData);
//     });
//     super.initState();
//   }

//   showConfirmationDialog() {
//     print("----InitshowDialog");
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       showDialog(
//           barrierDismissible: false,
//           context: Get.context!,
//           builder: (context) {
//             return notificationController.isConfirming.value
//                 ? SizedBox(
//                     height: 10.w,
//                     width: 10.w,
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   )
//                 : AlertDialog(
//                     title: Text(
//                       widget.message.notification!.title!,
//                       style: CommonTextStyles.interBoldStyle.copyWith(
//                         color: AppColors.slightBlack,
//                         fontSize: CommonFontSizes.sp16,
//                       ),
//                     ),
//                     content: Text(
//                       widget.message.notification!.body!,
//                       style: CommonTextStyles.interRegularStyle.copyWith(
//                         color: AppColors.slightBlack,
//                         fontSize: CommonFontSizes.sp14,
//                       ),
//                     ),
//                     actions: [
//                       CommonTextButton(
//                         onTap: () {
//                           notificationController
//                               .confirmRescheduledAppointment("no");
//                           Get.offAll(() => SplashScreen());
//                         },
//                         name: Constants.no,
//                         textStyle: CommonTextStyles.interRegularStyle.copyWith(
//                           color: AppColors.slightBlack,
//                           fontSize: CommonFontSizes.sp16.sp,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 2.w.sp),
//                         child: CommonButton(
//                             onTap: () {
//                               notificationController
//                                   .confirmRescheduledAppointment("yes");
//                             },
//                             name: Constants.yes,
//                             width: 20.w),
//                       )
//                     ],
//                   );
//           });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: AppColors.white,
//           centerTitle: true,
//           title: Text(
//             Constants.notifications,
//             style: CommonTextStyles.interBoldStyle.copyWith(
//                 color: AppColors.primaryColor, fontSize: CommonFontSizes.sp22),
//           ),
//         ),
//         backgroundColor: AppColors.white,
//         body: SizedBox(
//           height: 100.h,
//           width: 100.w,
//           child: notificationController.isLoading.value
//               ? Center(
//                   child: CircularProgressIndicator(
//                     color: AppColors.primaryColor,
//                   ),
//                 )
//               : showConfirmationDialog(),
//         ),
//       ),
//     );
//     // : Center(
//     //     child: Text("Child"),
//     //   )));
//   }
// }
