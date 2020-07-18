import 'package:flutter/material.dart';
import 'package:flutter_contas/listAccounts.dart';
import 'package:flutter_contas/mobx/paymentCtrlMobX.dart' as MobX;

import 'package:get_it/get_it.dart';

void main() {
 GetIt getIt = GetIt.I;
 getIt.registerSingleton<MobX.PaymentController>(MobX.PaymentController());
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListAccountsPage(),
    );
  }
}
