// // ignore_for_file: avoid_function_literals_in_foreach_calls
//
// import 'dart:developer';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
// class PushNotificationService {
//   Future<void> setupInteractedMessage() async {
//     await Firebase.initializeApp();
//
//     await FirebaseMessaging.instance.requestPermission();
//     FirebaseMessaging.onMessageOpenedApp
//         .listen((RemoteMessage? remoteMessage) async {});
//
//     await _enableIOSNotifications();
//     await _registerNotificationListeners();
//   }
//
//   _enableIOSNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);
//   }
//
//   androidNotificationChannel() => const AndroidNotificationChannel(
//       'high_importance_channel', 'High Importance Notifications',
//       importance: Importance.high);
//
//   _registerNotificationListeners() async {
//     AndroidNotificationChannel channel = androidNotificationChannel();
//
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     flutterLocalNotificationsPlugin
//         .getNotificationAppLaunchDetails()
//         .then((notificationAppLaunchDetail) {});
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     var androidSettings =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     // var iOSSettings = const IOSInitializationSettings(
//     //     requestSoundPermission: true,
//     //     requestAlertPermission: true,
//     //     requestBadgePermission: true);
//
//     var initSettings =
//         InitializationSettings(android: androidSettings, iOS: iOSSettings);
//
//     flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//
//     flutterLocalNotificationsPlugin.initialize(initSettings,
//         onSelectNotification: (message) async {
//       log("onDidReceiveBackgroundNotificationResponse = $message");
//
//       if (message != null) {
//         log("STATUS = onDidReceiveBackgroundNotificationResponse. Received");
//         // log(message.payload.toString());
//         // FlutterLocalNotificationsPlugin()
//         //     .getNotificationAppLaunchDetails()
//         //     .then((value) {
//         //   showDialog(
//         //       context: navigatorKey.currentState!.context,
//         //       builder: (_) => AlertBox(title: "App forground state"));
//         //   // Map data =
//         //   //     jsonDecode(value?.notificationResponse?.payload.toString() ?? "");
//         //   log("${convertToJSON(value?.notificationResponse?.notificationResponseType?.name)}");
//         // });
//         // CustomnavigatorKey.currentState!.pushReplacement(
//         //     context: navigatorKey.currentState!.context,
//         //     screen: const NotificationScreen(from: 'notification')
//         // );
//
// /*  navigatorKey.currentState! */
//         // navigatorKey.currentState!.push(
//         //     MaterialPageRoute(builder: (context) => NotificationScreen()));
//       } else {
//         log("STATUS = onDidReceiveBackgroundNotificationResponse Received");
//       }
//     });
//
//     /** called when app is in foreground state */
//     FirebaseMessaging.onMessage.listen((remoteMessage) {
//       RemoteNotification? remoteNotification = remoteMessage.notification;
//       AndroidNotification? androidNotification =
//           remoteMessage.notification?.android;
//       // ignore: unused_local_variable
//       AppleNotification? appleNotification = remoteMessage.notification?.apple;
//
//       log("STATUS = ${remoteMessage.data}");
//
//       if (remoteNotification != null && androidNotification != null) {
//         log("NOTIFICATION_DATA = $remoteMessage");
//         String setdata = "remoteNotification.title=>${remoteMessage.data}";
//
//         /** shows the notification on device */
//         flutterLocalNotificationsPlugin.show(
//             remoteNotification.hashCode,
//             remoteNotification.title,
//             remoteNotification.body,
//             payload: setdata,
//             NotificationDetails(
//                 android: AndroidNotificationDetails(channel.id, channel.name,
//                     icon: androidNotification.smallIcon,
//                     playSound: true,
//                     fullScreenIntent: true,
//                     importance: Importance.high),
//                 // iOS: const IOSNotificationDetails(
//                 //     presentAlert: true,
//                 //     presentBadge: true,
//                 //     presentSound: true)
//             ));
//       }
//     });
//   }
// }
//
// Map<String, String> convertToJSON(String data) {
//   // Remove curly braces and split the string into key-value pairs
//   List data1 = data.replaceAll("{", "").replaceAll("}", "").split(",");
//
//   Map<String, String> json = {};
//   data1.forEach((element) {
//     final gasGiants = <String, String>{
//       element.toString().split(":")[0].toString().trim():
//           element.toString().split(":")[1].toString().trim()
//     };
//     json.addEntries(gasGiants.entries);
//   });
//
//   return json;
// }
 /// mmmmmmmm
// // import 'dart:async';
// // import 'dart:developer';
//
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// // var globalCheckNavitaion = 0;
//
// // class PushNotificationService {
// //   Future<void> setupInteractedMessage() async {
// //     await Firebase.initializeApp();
//
// //     FirebaseMessaging.instance.getInitialMessage().then((value) => {
// //           if (value != null)
// //             {
// //               log("ContentAvailable : " + value.contentAvailable.toString()),
// //               globalCheckNavitaion = 1
// //             }
// //         });
//
// //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// //       // Navigator.push(navigatorKey.currentContext!,
// //       //     MaterialPageRoute(builder: (_) => const User_Notification()));
// //     });
//
// //     await enableIOSNotifications();
// //     await registerNotificationListeners();
// //   }
//
// //   registerNotificationListeners() async {
// //     AndroidNotificationChannel channel = androidNotificationChannel();
// //     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //         FlutterLocalNotificationsPlugin();
// //     await flutterLocalNotificationsPlugin
// //         .resolvePlatformSpecificImplementation<
// //             AndroidFlutterLocalNotificationsPlugin>()
// //         ?.createNotificationChannel(channel);
// //     var androidSettings =
// //         const AndroidInitializationSettings('@mipmap/ic_launcher');
// //     var iOSSettings = const IOSInitializationSettings(
// //       requestSoundPermission: false,
// //       requestBadgePermission: false,
// //       requestAlertPermission: false,
// //     );
// //     var initSetttings = InitializationSettings(
// //       android: androidSettings,
// //       iOS: iOSSettings,
// //     );
// //     flutterLocalNotificationsPlugin.initialize(initSetttings,
// //         onSelectNotification: onSelectNotification);
//
// //     FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
// //       log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
// //       log(message!.data.toString());
// //       log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
// //       RemoteNotification? notification = message.notification;
// //       AndroidNotification? android = message.notification?.android;
// //       String dataSet =
// //           "${notification?.body}=>${notification?.title}=>${message.data}";
// //       if (notification != null && android != null) {
// //         flutterLocalNotificationsPlugin.show(
// //           notification.hashCode,
// //           notification.title,
// //           notification.body,
// //           payload: dataSet,
// //           NotificationDetails(
// //             android: AndroidNotificationDetails(
// //               channel.id,
// //               channel.name,
// //               icon: android.smallIcon,
// //               playSound: true,
// //             ),
// //           ),
// //         );
// //       }
// //     });
// //   }
//
// //   enableIOSNotifications() async {
// //     await FirebaseMessaging.instance
// //         .setForegroundNotificationPresentationOptions(
// //       alert: true,
// //       badge: true,
// //       sound: true,
// //     );
// //   }
//
// //   androidNotificationChannel() => const AndroidNotificationChannel(
// //         'high_importance_channel', // id
// //         'High Importance Notifications', // title
//
// //         importance: Importance.max,
// //       );
// //   Future<void> invokeTimer() async {
// //     Timer(const Duration(seconds: 3), () async {});
// //   }
//
// //   Future<void> onSelectNotification(String? payload) async {
// //     if (payload != null) {
// //       print('Notification payload: $payload');
// //       // Handle the notification payload
// //     }
// //   }
// // }
//
// // // import 'dart:async';
// // // import 'dart:developer';
// // // import 'package:datingapp/feature/dashboard/dashboardonpage/settingnavigations/notification.dart';
// // // import 'package:firebase_core/firebase_core.dart';
// // // import 'package:firebase_messaging/firebase_messaging.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// // // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
// // // var globalCheckNavitaion = 0;
//
// // // class PushNotificationService {
// // //   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
// // //       FlutterLocalNotificationsPlugin();
// // //   static void initialize() {
// // //     // initializationSettings  for Android
// // //     const InitializationSettings initializationSettings =
// // //         InitializationSettings(
// // //       android: AndroidInitializationSettings("@mipmap/ic_launcher"),
// // //     );
// // //     // enableIOSNotifications();
// // //     _notificationsPlugin.initialize(
// // //       initializationSettings,
// // //       onSelectNotification: (String? type) async {
// // //         log("onSelectNotification");
// // //         if (type!.isNotEmpty) {
// // //           log("Router Value1234 $type");
//
// // //           // Navigator.of(context).push(
// // //           //   MaterialPageRoute(
// // //           //     builder: (context) => DemoScreen(
// // //           //       id: id,
// // //           //     ),
// // //           //   ),
// // //           // );
//
// // //         }
// // //       },
// // //     );
// // //   }
//
// // //   static void createanddisplaynotification(RemoteMessage message) async {
// // //     try {
// // //       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
// // //       const NotificationDetails notificationDetails = NotificationDetails(
// // //         android: AndroidNotificationDetails(
// // //           "vadoreapp",
// // //           "vadorechannel",
// // //           importance: Importance.max,
// // //           priority: Priority.high,
// // //         ),
// // //       );
//
// // //       await _notificationsPlugin.show(
// // //         id,
// // //         message.notification!.title,
// // //         message.notification!.body,
// // //         notificationDetails,
// // //         payload: message.data['type'],
// // //       );
// // //     } on Exception catch (e) {
// // //       log(e);
// // //     }
// // //   }
//
// // //   Future<void> setupInteractedMessage() async {
// // //     await Firebase.initializeApp();
//
// // //     FirebaseMessaging.instance
// // //         .getInitialMessage()
// // //         .then((value) => {if (value != null) {}});
//
// // //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// // //       log(message.data.toString());
// // //       // Navigator.push(navigatorKey.currentContext!,
// // //       //     MaterialPageRoute(builder: (_) => const NotificationPage()));
// // //     });
//
// // //     await enableIOSNotifications();
// // //     await registerNotificationListeners();
// // //   }
//
// // //   registerNotificationListeners() async {
// // //     AndroidNotificationChannel channel = androidNotificationChannel();
// // //     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// // //         FlutterLocalNotificationsPlugin();
// // //     await flutterLocalNotificationsPlugin
// // //         .resolvePlatformSpecificImplementation<
// // //             AndroidFlutterLocalNotificationsPlugin>()
// // //         ?.createNotificationChannel(channel);
// // //     var androidSettings =
// // //         const AndroidInitializationSettings('@mipmap/ic_launcher');
// // //     var iOSSettings = const IOSInitializationSettings(
// // //       requestSoundPermission: false,
// // //       requestBadgePermission: false,
// // //       requestAlertPermission: false,
// // //     );
// // //     var initSetttings =
// // //         InitializationSettings(android: androidSettings, iOS: iOSSettings);
//
// // //     flutterLocalNotificationsPlugin.initialize(initSetttings,
// // //         onSelectNotification: (message) async {
// // //       // Navigator.push(navigatorKey.currentContext!,
// // //       //     MaterialPageRoute(builder: (_) => const NotificationPage()));
// // //     });
//
// // //     FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
// // //       log(message!.data.toString());
// // //       RemoteNotification? notification = message.notification;
// // //       AndroidNotification? android = message.notification?.android;
//
// // //       if (notification != null && android != null) {
// // //         flutterLocalNotificationsPlugin.show(
// // //           notification.hashCode,
// // //           notification.title,
// // //           notification.body,
// // //           NotificationDetails(
// // //             android: AndroidNotificationDetails(
// // //               channel.id,
// // //               channel.name,
// // //               icon: android.smallIcon,
// // //               playSound: true,
// // //             ),
// // //           ),
// // //         );
// // //       }
// // //     });
// // //   }
//
// // //   enableIOSNotifications() async {
// // //     await FirebaseMessaging.instance
// // //         .setForegroundNotificationPresentationOptions(
// // //       alert: true,
// // //       badge: true,
// // //       sound: false,
// // //     );
// // //   }
//
// // //   androidNotificationChannel() => const AndroidNotificationChannel(
// // //         'high_importance_channel', // id
// // //         'High Importance Notifications', // title
// // //         importance: Importance.max,
// // //       );
// // //   Future<void> invokeTimer() async {
// // //     Timer(const Duration(seconds: 3), () async {
// // //       // Navigator.push(navigatorKey.currentContext!,
// // //       //     MaterialPageRoute(builder: (_) => const NotificationPage(isnotify: null,)));
// // //     });
// // //   }
// // // }
