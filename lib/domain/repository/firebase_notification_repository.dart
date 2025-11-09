import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FirebaseNotificationRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // 🔹 Solicita permisos (especialmente necesario en iOS)
    await _firebaseMessaging.requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        const InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      if (response.actionId == 'whatsapp') {
        final data = jsonDecode(response.payload!);
        final service = data['service'];
        final cellphone = data['cellphone_user'];
        final email = data["email"];
        final message =
            '🚨 ¡Atención! Tu servicio de *$service* vence *mañana* 😱\n\n'
            '📧 Cuenta: $email\n\n'
            '¡Renueva hoy y evita interrupciones! 💪\n\n'
            '🛍️ Escríbenos para renovar al instante 🔁';

        final link = Uri(
          scheme: 'https',
          host: 'wa.me',
          path: cellphone,
          queryParameters: {'text': message},
        );

        try {
          if (Platform.isIOS) {
            await launchUrl(link);
          } else {
            await launchUrl(link);
          }
        } on Exception {
          debugPrint("error..");
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'expiraciones_channel',
      'Notificaciones de expiraciones',
      importance: Importance.high,
      priority: Priority.high,
      actions: [
        AndroidNotificationAction(
          'whatsapp',
          '💬 Contactar por WhatsApp',
          showsUserInterface: true,
        )
      ],
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    final title = message.data['title'] ?? 'Cuenta por vencer';
    final body = message.data['body'] ?? 'Haz clic para contactar al cliente';
    final data = message.data;

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: jsonEncode({
        'service': data["service"],
        'cellphone_user': data["cellphone_user"],
        'email': data["email_account"]
      }),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  FirebaseNotificationRepository()._showLocalNotification(message);
}
