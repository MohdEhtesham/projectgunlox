// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import '../../components/CommonFunctions/CommonFunctions.dart' as common;
// import '../components/strings/Constants.dart';
// import '../models/NotificationsListModel.dart';
// import '../modules/Splash/SplashScreen.dart';
// import '../network/api_client.dart';
// import '../network/endpoints.dart';

// class NotificationController extends GetxController {
//   RxBool isLoading = false.obs;
//   RxBool isConfirming = false.obs;
//   Map<String, dynamic> appointmentData = {};
//   String? therapistId;
//   String? time;
//   String? date;
//   String? appointmentId;

//   RxList<NotificationsListModel> notificationList =
//       <NotificationsListModel>[].obs;

//   getNotificationList() async {
//     isLoading.value = true;
//     try {
//       var response = await ApiClient().commonGetListAPIMethod(
//         Endpoints.GET_NOTIFICATION_LIST,
//         {
//           'Authorization': common.getToken,
//           'Content-Type': 'application/json',
//         },
//       );
//       if (response.isNotEmpty) {
//         notificationList.clear();
//         for (var element in response) {
//           notificationList.add(NotificationsListModel.fromJson(element));
//         }
//         print("notificationList: $notificationList");
//       } else {
//         common.showCustomSnackBar(Constants.somethingWentWrong);
//       }
//     } catch (e) {
//       Get.back();
//       common.showCustomSnackBar(Constants.somethingWentWrong);
//     }

//     // print("notificationList resp: $response");

//     isLoading.value = false;
//   }

//   checkNotification(RemoteMessage message, var messageData) async {
//     isLoading.value = true;
//     // appointmentData = await jsonDecode(messageData);
//     // var temp = messageData["appointment_data"];
//     var notificationData = jsonDecode(messageData["appointment_data"]);
//     print(" notificationData: $notificationData");
//     print("----checkNotification1 ${notificationData["appointmentId"]}, ");
//     appointmentId = notificationData["appointmentId"];
//     time = notificationData["time"];
//     date = notificationData["date"];
//     therapistId = notificationData["therapistId"];

//     print("----checkNotification2 appointmentData $appointmentId }");
//     Future.delayed(Duration(seconds: 3), () {
//       isLoading.value = false;
//     });
//   }

// //For User to confirm the Rescheduled Appointment!
//   confirmRescheduledAppointment(String status) async {
//     isConfirming.value = true;
//     Map<String, dynamic> confirmRescheduledAppointmentPayload = {
//       "date": date,
//       "time": time,
//       "therapistId": therapistId,
//       "appointmentId": appointmentId,
//       "status": status
//     };
//     print(
//         "----confirmRescheduledAppointmentPayload::: $confirmRescheduledAppointmentPayload");
//     var response = await ApiClient().commonPostAPIMethod(
//         Endpoints.CONFIRM_RESCHEDULE_APPOINTMENT,
//         {
//           'Authorization': common.getToken,
//           'Content-Type': 'application/json',
//         },
//         jsonEncode(confirmRescheduledAppointmentPayload));

//     print("----confirmRescheduledAppointment response: $response");
//     if (response!["error"] != null) {
//       Get.offAll(() => SplashScreen());
//       common.showCustomSnackBar(
//           response["error"]["message"] ?? Constants.somethingWentWrongContact);
//     } else if (response["message"] == "Appointment rescheduled successfully!") {
//       Get.offAll(() => SplashScreen());
//       common.showCustomSnackBar(response["message"]);
//     } else if (response["message"] == "Appointment cancelled successfully!") {
//       Get.offAll(() => SplashScreen());
//       Future.delayed(Duration.zero, () {
//         common.showCustomSnackBar(response["message"]);
//       });
//     } else {
//       Get.offAll(() => SplashScreen());
//       common.showCustomSnackBar(Constants.somethingWentWrongContact);
//     }
//     isConfirming.value = false;
//   }
// }
