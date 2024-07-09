import 'package:laroch/app.dart';
import 'package:flutter/material.dart';
import 'package:laroch/di/di.dart';
import 'package:laroch/notificationService.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

      options: FirebaseOptions(
        apiKey: "AIzaSyDNTjsplKBHMsV-iL1kZpTiOSCLXLTgtq0",
        appId: '1:631248288347:android:f9188c849d657658119d7e',
        messagingSenderId: '631248288347',
        projectId: 'laroch-a0857',
        storageBucket: 'laroch-a0857.appspot.com',
      ));
  PushNotificationService().initialize();
  await initializeServices();

  runApp(const MyApp());
}

initializeServices() async {
  await StorageUtil.init();
  setUp();
}
