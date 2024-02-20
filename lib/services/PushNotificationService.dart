import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as flutter_local_notifications;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../general_exports.dart';

class PushNotificationService {
  RemoteMessage? newNotification;
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
// This function is called when ios app is opened, for android case `onDidReceiveNotificationResponse` function is called
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        // print(
        //     '******A new onMessageOpenedApp event was published!  ${message.data["appointment_data"]} &  ${message.data["appointment_data"] != null}');
        // if (message.data["appointment_data"] != null) {
        //   Get.to(() => NotificationNavigationHandler(
        //         message: message,
        //         messageData: message.data,
        //       ));
        // }
        // notificationRedirect(message.data[keyTypeValue], message.data[keyType]);
      },
    );
    enableIOSNotifications();
    await registerNotificationListeners();
  }

  Future<void> registerNotificationListeners() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@drawable/ic_launcher');
    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        // We're receiving the payload as string that looks like this
        // {buttontext: Button Text, subtitle: Subtitle, imageurl: , typevalue: 14, type: course_details}
        // So the code below is used to convert string to map and read whatever property you want
        // Dont ever try this code: Rohan
        // print("onDidReceiveNotificationResponse ${details.payload!}");
        // var payloadData = jsonDecode(details.payload!);
        // print("payload $payloadData");
        // // final List<String> str =
        // //     details.payload!.replaceAll('{', '').replaceAll('}', '').split(',');
        // final List<String> str =
        //     details.payload!.replaceAll('{', '').replaceAll('}', '').split(',');
        // final Map<String, dynamic> result = <String, dynamic>{};
        // for (int i = 0; i < str.length; i++) {
        //   final List<String> s = str[i].split(':');
        //   result.putIfAbsent(s[0].trim(), () => s[1].trim());
        // }

        // if (newNotification!.data["appointment_data"] != null) {
        //   Get.to(() => NotificationNavigationHandler(
        //         message: newNotification!,
        //         messageData: newNotification!.data,
        //       ));
        // }
      },
    );
    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      print("$message, key: 'firebase_message'");
      final RemoteNotification? notification = message!.notification;
      final AndroidNotification? android = message.notification?.android;
      newNotification = message;
      print("newNotification $newNotification");
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          flutter_local_notifications.NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            ),
          ),
          payload: message.data.toString(),
        );
      }
    });
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );
}
