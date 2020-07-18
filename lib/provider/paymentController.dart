import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_contas/model/payment.dart';

class PaymentController extends ChangeNotifier {
  //  lista privada uso do underline
 final List<Payment> _payments = [];

  // criando lista pública não modificável
 UnmodifiableListView<Payment> get items => UnmodifiableListView(_payments);

 void add(Payment payment) {
   _payments.add(payment);
  //  manda o aviso pro change notifier provader que avisa todos os consumers
   notifyListeners();
 }

 void update(){
   notifyListeners();
 }
}