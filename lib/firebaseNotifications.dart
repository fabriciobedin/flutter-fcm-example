import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_contas/model/payment.dart';
import 'package:flutter_contas/mobx/paymentCtrlMobX.dart' as MobX;
import 'package:get_it/get_it.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;
  MobX.PaymentController paymentController;

  FirebaseNotifications() {
    paymentController = GetIt.I.get<MobX.PaymentController>();
  }

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print("token: $token");
    });

    _firebaseMessaging.configure(
      //  ouve push somente com o app em foreground
      onMessage: (Map<String, dynamic> message) async {
        print("on message $message");
        Payment payment = Payment.fromJson(message);
        // enviamos pro changenotifier o novo pagamento, ele faz a comunicação com o restante do fluxo
        paymentController.add(payment);
      },
      onResume: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {},
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
