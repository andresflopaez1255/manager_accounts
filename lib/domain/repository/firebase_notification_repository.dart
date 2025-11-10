import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel expiracionesChannel = AndroidNotificationChannel(
  'expiraciones_channel', // id
  'Notificaciones de expiraciones', // nombre visible
  description: 'Canal usado para notificar sobre cuentas próximas a vencer.',
  importance: Importance.max,
);

class FirebaseNotificationRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // 🔹 Solicitar permisos (iOS y Android 13+)
    await _firebaseMessaging.requestPermission();
   await _firebaseMessaging.subscribeToTopic("expiraciones");
    // 🔹 Crear el canal para Android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(expiracionesChannel);

    // 🔹 Configurar inicialización local
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.actionId == 'whatsapp') {
          final data = jsonDecode(response.payload!);
          final service = data['service'];
          final cellphone = data['cellphone_user'];
          final email = data['email'];

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
            await launchUrl(link, mode: LaunchMode.externalApplication);
          } catch (e) {
            debugPrint("Error al abrir WhatsApp: $e");
          }
        }
      },
    );

    // 🔹 Listeners de Firebase
    FirebaseMessaging.onMessage.listen(_showLocalNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_showLocalNotification);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final androidDetails = AndroidNotificationDetails(
      expiracionesChannel.id,
      expiracionesChannel.name,
      channelDescription: expiracionesChannel.description,
      importance: Importance.high,
      priority: Priority.high,
      actions: const [
        AndroidNotificationAction(
          'whatsapp',
          '💬 Contactar por WhatsApp',
          showsUserInterface: true,
        ),
      ],
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    final data = message.data;

    await flutterLocalNotificationsPlugin.show(
      0,
      data['title'] ?? 'Cuenta por vencer',
      data['body'] ?? 'Haz clic para contactar al cliente',
      notificationDetails,
      payload: jsonEncode({
        'service': data["service"],
        'cellphone_user': data["cellphone_user"],
        'email': data["email_account"],
      }),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 🔹 Inicializa Firebase en segundo plano
  await Firebase.initializeApp();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(expiracionesChannel);

  await FirebaseNotificationRepository()._showLocalNotification(message);
}
