import 'package:flutter_contas/model/payment.dart';
import 'package:mobx/mobx.dart';

part 'paymentCtrlMobX.g.dart';

// singleton (vai sempre ter uma única estancia) utilizaremos o get_it
class PaymentController = PaymentControllerBase with _$PaymentController;

abstract class PaymentControllerBase with Store {
 @observable
 var payments = ObservableList();

 @action
 void add(Payment payment) {
   payments.add(payment);
 }

 @action
 void update(int index, Payment payment){
   payments.removeAt(index);
   payments.insert(index, payment);
 }
}