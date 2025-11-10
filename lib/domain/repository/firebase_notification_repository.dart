import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseNotificationRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // 🔹 Solicitar permisos (iOS y Android 13+)
    await _firebaseMessaging.requestPermission();
   await _firebaseMessaging.subscribeToTopic("expiraciones");
  

  }

 
}


