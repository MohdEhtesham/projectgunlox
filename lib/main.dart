import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gunlox/components/Constants/AppImages.dart';
import 'package:gunlox/services/PushNotificationService.dart';
// import 'package:home_widget/home_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'components/strings/Constants.dart';
import 'modules/Splash/splashScreen.dart';

Future<dynamic> _backgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Background Message notification: ${message.notification?.title}');
    print('Background Message notification: ${message.notification?.body}');
    print('Background Message notificationdata : ${message.data}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await HomeWidget.setAppGroupId(Constants.appGroupId);
  print("interactiveCallback");
  int iosVersion = await getiOSVersion();
  // if (Platform.isAndroid || iosVersion >= 17) {
  //   // await HomeWidget.registerInteractivityCallback(interactiveCallback);
  // }
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  await PushNotificationService().setupInteractedMessage();
  await Permission.notification.isDenied.then(
    (bool value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );

  // App received a notification when it was killed
  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  if (message != null && message.data["appointment_data"] != null) {
    print("initial Message $message");
    //Move to navigation handler
  }
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  runApp(const MyApp());
}

Future<int> getiOSVersion() async {
  if (Platform.isIOS) {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    String? version = iosInfo.systemVersion;
    final str = version.indexOf(".");
    print("ios version $version");
    return int.parse(version.substring(0, str));
  } else {
    return 17;
  }
}

/// Callback invoked by HomeWidget Plugin when performing interactive actions
/// The @pragma('vm:entry-point') Notification is required so that the Plugin can find it
// @pragma('vm:entry-point')
// Future<void> interactiveCallback(Uri? uri) async {
// // Set AppGroup Id. This is needed for iOS Apps to talk to their WidgetExtensions
//   await HomeWidget.setAppGroupId(Constants.appGroupId);
//   print("interactiveCallback ${uri?.host}");
// // We check the host of the uri to determine which action should be triggered.
//   if (uri?.host == 'increment') {
//     await _increment();
//   } else if (uri?.host == 'clear') {
//     await _clear();
//   }
// }

const _countKey = 'counter';

/// Gets the currently stored Value
// Future<int> get _value async {
//   print("get _value ");

//   final value = await HomeWidget.getWidgetData<int>(_countKey, defaultValue: 0);
//   return value!;
// }

// /// @returns the new saved value
// Future<int> _increment() async {
//   final oldValue = await _value;
//   final newValue = oldValue + 1;
//   await _sendAndUpdate(newValue);
//   return newValue;
// }

/// Clears the saved Counter Value
// Future<void> _clear() async {
//   await _sendAndUpdate(null);
// }

/// Stores [value] in the Widget Configuration
// Future<void> _sendAndUpdate([int? value]) async {
//   await HomeWidget.saveWidgetData(_countKey, value);
//   await HomeWidget.renderFlutterWidget(
//     DashWithSign(count: value ?? 0),
//     key: 'dash_counter',
//     logicalSize: const Size(100, 100),
//   );
//   await HomeWidget.updateWidget(
//     iOSName: Constants.iOSWidgetName,
//     androidName: Constants.androidWidgetName,
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gun-Lox',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      );
    });
  }
}

class DashWithSign extends StatelessWidget {
  const DashWithSign({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: 300,
        height: 300,
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset(AppImages.signal),
                ),
              ),
              Transform.rotate(
                angle: 5 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(58, 29),
                  child: SizedBox(
                    height: 100,
                    width: 134,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Center(
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 70,
                              //color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
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
