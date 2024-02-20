// Removed the screen and added to Home Screen

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gunlox/modules/Firearm/FirearmDetails.dart';
// import 'package:gunlox/modules/Firearm/FirearmDetails2.dart';
// import 'package:gunlox/modules/Home/FindLock.dart';

// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:gunlox/components/CommonExt/Components.dart';
// import 'package:gunlox/components/Constants/AppColors.dart';
// import 'package:gunlox/components/Constants/AppImages.dart';
// import 'package:gunlox/components/strings/Constants.dart';
// import 'package:flutter/gestures.dart';

// class RangeScreen extends StatefulWidget {
//   const RangeScreen({Key? key}) : super(key: key);

//   @override
//   State<RangeScreen> createState() => _RangeScreenState();
// }

// class _RangeScreenState extends State<RangeScreen> {
//   List<String> deviceId = [
//     '6784-8574-g574-42e1',
//     '6784-8574-g574-42e2',
//     '6784-8574-g574-42e3',
//     '6784-8574-g574-42e4',
//   ];
//   List<Map<String, int>> dataList = [
//     {'6784-8574-g574-42e1': 0},
//     {'6784-8574-g574-42e2': 0},
//     {'6784-8574-g574-42e3': 0},
//     {'6784-8574-g574-42e4': 0}
//   ];

//   buttonPressed(item, index) {
//     print("buttonPressed: $item, $index");
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   backgroundColor: AppColors.backgroundColor,
//     //   body: Padding(
//     // padding: const EdgeInsets.all(15.0),
//     return ListView(
//       physics: ClampingScrollPhysics(),
//       shrinkWrap: true,
//       children: [
//         // SizedBox(height: 2.h),
//         // Row(
//         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //   children: [
//         //     Container(
//         //       height: 10.h,
//         //       width: 45.w,
//         //       decoration: const BoxDecoration(
//         //         image: DecorationImage(
//         //           image: AssetImage(AppImages.splashLogo),
//         //         ),
//         //       ),
//         //     ),
//         //     Container(
//         //       height: 10.h,
//         //       width: 10.w,
//         //       decoration: const BoxDecoration(
//         //         image: DecorationImage(
//         //           image: AssetImage(AppImages.useracc),
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             GestureDetector(
//               onTap: () {},
//               child: Container(
//                 height: 10.h,
//                 width: 10.w,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(AppImages.refresh),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 5.w,
//             ),
//             SizedBox(
//               width: 40.w,
//               child: CommonButton(
//                 onPressed: () {
//                   FocusManager.instance.primaryFocus?.unfocus();
//                   Get.to(() => const FindLock());
//                 },
//                 buttonText: Constants.addnew,
//                 fontSize: 16,
//                 imagePath: AppImages.plus,
//                 fontFamily: "Poppins",
//                 buttonColor: AppColors.secondaryColor,
//                 textColor: AppColors.primaryWhiteColor,
//                 horizontalPadding: 20,
//                 verticalPadding: 10,
//                 borderRadius: 25,
//                 iconSpacing: 12,
//                 borderColor: Colors.red,
//                 width: 90.w,
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//         ListView(
//           shrinkWrap: true,
//           children: [
//             Container(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 Constants.inrange,
//                 style: TextStyle(
//                   fontFamily: "Poppins",
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.sp,
//                   color: AppColors.primaryBlackColor,
//                 ),
//               ),
//             ),

//             //In range BT widgets
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: dataList.length,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryWhiteColor,
//                         borderRadius: BorderRadius.circular(15.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.1),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                         border: Border.all(
//                           color: AppColors.blackColor.withOpacity(0.2),
//                           width: 1.0,
//                         ),
//                       ),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(10),
//                         title: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Get.to(() => const FirearmDetails2());
//                               },
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         Constants.myHunting,
//                                         style: TextStyle(
//                                           fontFamily: "Poppins",
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18.sp,
//                                           color: AppColors.primaryBlackColor,
//                                         ),
//                                       ),
//                                       Container(
//                                         alignment: Alignment.centerRight,
//                                         child: Image.asset(
//                                           AppImages.signal,
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                     Constants.huntingtext,
//                                     style: TextStyle(
//                                       fontFamily: "Poppins",
//                                       fontSize: 18.sp,
//                                       color: AppColors.primaryBlackColor,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 2.h,
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             //Swipe Gesture -- Lock/Unlock devices
//                             Container(
//                               // width: 100.w,
//                               height: 8.h,
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       width: 1.0, color: AppColors.blue),
//                                   borderRadius: BorderRadius.circular(30.0),
//                                   color: AppColors.softerBlue),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 10.0, right: 10.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     // Wrap the first image container with GestureDetector
//                                     GestureDetector(
//                                       onTap: () {
//                                         buttonPressed(dataList[index], index);
//                                         // dataList[index]
//                                         //     ["6784-8574-g574-42e5"] = 0;
//                                       },
//                                       child: Container(
//                                         height: 10.w,
//                                         width: 10.w,
//                                         decoration: const BoxDecoration(
//                                           color: AppColors.blue,
//                                           shape: BoxShape.circle,
//                                           image: DecorationImage(
//                                             image:
//                                                 AssetImage(AppImages.closeLock),
//                                             fit: BoxFit.none,
//                                             alignment: Alignment.center,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: CustomPaint(
//                                         painter: DashedLinePainter(),
//                                         child: Container(
//                                           height: 2.0,
//                                         ),
//                                       ),
//                                     ),
//                                     // Wrap the second image container with GestureDetector
//                                     GestureDetector(
//                                       onTap: () {
//                                         // dataList[index]deviceId[index] = 1;
//                                         buttonPressed(dataList[index], index);
//                                       },
//                                       child: Container(
//                                         height: 10.w,
//                                         width: 10.w,
//                                         decoration: const BoxDecoration(
//                                           // shape: BoxShape.circle,
//                                           image: DecorationImage(
//                                             image: AssetImage(AppImages.unlock),
//                                             fit: BoxFit.contain,
//                                             alignment: Alignment.center,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: CustomPaint(
//                                         painter: DashedLinePainter(),
//                                         child: Container(
//                                           height: 2.0,
//                                         ),
//                                       ),
//                                     ),
//                                     // Wrap the third image container with GestureDetector
//                                     GestureDetector(
//                                       onTap: () {
//                                         buttonPressed(dataList[index], index);
//                                       },
//                                       child: Container(
//                                         height: 10.w,
//                                         width: 10.w,
//                                         decoration: const BoxDecoration(
//                                           image: DecorationImage(
//                                             image: AssetImage(AppImages
//                                                 .removeShankUnselected),
//                                             fit: BoxFit.contain,
//                                             alignment: Alignment.center,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),

//             SizedBox(
//               height: 2.h,
//             ),

//             Container(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 Constants.outrange,
//                 style: TextStyle(
//                   fontFamily: "Poppins",
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.sp,
//                   color: AppColors.primaryBlackColor,
//                 ),
//               ),
//             ),

//             //Out of Range list
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: dataList.length,
//               physics: ClampingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.outback.withOpacity(.5),
//                         borderRadius: BorderRadius.circular(15.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.1),
//                             spreadRadius: 5,
//                             blurRadius: 10,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   Constants.myHunting,
//                                   style: TextStyle(
//                                     fontFamily: "Poppins",
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18.sp,
//                                     color: AppColors.primaryWhiteColor,
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.centerRight,
//                                   child: Image.asset(
//                                     AppImages.cross,
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               Constants.huntingtext,
//                               style: TextStyle(
//                                 fontFamily: "Poppins",
//                                 fontSize: 18.sp,
//                                 color: AppColors.primaryWhiteColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

// class DashedLinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = AppColors.blue
//       ..strokeWidth = 1.0
//       ..strokeCap = StrokeCap.round;

//     const double dashWidth = 4.0;
//     const double dashSpace = 4.0;
//     double currentX = 0.0;

//     while (currentX < size.width) {
//       canvas.drawLine(
//         Offset(currentX, 0.0),
//         Offset(currentX + dashWidth, 0.0),
//         paint,
//       );
//       currentX += dashWidth + dashSpace;
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
