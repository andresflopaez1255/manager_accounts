import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  initNotification() async {
    final fcmToken = await _firebaseMessaging.getToken();

    print(fcmToken);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// handler if the app has been opened from a background state
    FirebaseMessaging.onMessageOpenedApp
        .listen(_firebaseMessagingBackgroundHandler);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message}");
}
