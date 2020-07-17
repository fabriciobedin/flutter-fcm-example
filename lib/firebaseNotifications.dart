import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_contas/model/payment.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;

  final void Function(Payment) callback;

  FirebaseNotifications(this.callback);

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();

    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {}

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
