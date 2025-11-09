import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    debugPrint("notiii ${notification?.title ?? notification?.toString() ?? 'null'}");

     const android = AndroidNotificationDetails(
      'expiraciones_channel',
      'Expiraciones',
      channelDescription: 'Notificaciones de cuentas por vencer',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      actions: [
        AndroidNotificationAction(
          'whatsapp',
          'Abrir WhatsApp',
          showsUserInterface: true,
        ),
      ],
    );

    const platform = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification?.title ?? 'Cuenta por vencer',
      notification?.body ?? 'Haz clic para contactar al cliente',
      platform,
      payload: data['telefono'] ?? '', // número del cliente
    ); 
  }

  initNotification() async {
    _firebaseMessaging.subscribeToTopic("expiraciones");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp
        .listen(_firebaseMessagingBackgroundHandler);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  FirebaseNotificationRepository()._showNotification(message);
}
