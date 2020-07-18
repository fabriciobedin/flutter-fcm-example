import 'package:flutter/material.dart';
import 'package:flutter_contas/listAccounts.dart';
import 'package:flutter_contas/provider/paymentController.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       home: ChangeNotifierProvider(
        create: (context) => PaymentController(),
        child: ListAccountsPage(), //ListAccounts tornase um consumer de PaymentController
      ),

    );
  }
}
