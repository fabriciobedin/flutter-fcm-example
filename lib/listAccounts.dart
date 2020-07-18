import 'package:flutter/material.dart';
import 'package:flutter_contas/firebaseNotifications.dart';
import 'package:flutter_contas/mobx/paymentCtrlMobX.dart' as MobX;
import 'package:flutter_contas/model/payment.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class ListAccountsPage extends StatelessWidget {
  MobX.PaymentController paymentController;
  ListAccountsPage(){
    paymentController = GetIt.I.get<MobX.PaymentController>();
  }
  @override
  Widget build(BuildContext context) {
    new FirebaseNotifications().setUpFirebase();

    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
      ),
      body: Observer(builder: (_) {
        return paymentController.payments.length == 0
            ? Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Nenhuma conta recebida neste momento...",
                  style: TextStyle(fontSize: 25),
                ))
            : DataTable(
                columns: <DataColumn>[
                  getColumn('Tipo'),
                  getColumn('Local'),
                  getColumn('Valor')
                ],
                rows: getRows(paymentController),
              );
      }),
    );
  }

  DataColumn getColumn(String label) => DataColumn(
        label: Text(
          label,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      );

  List<DataRow> getRows(MobX.PaymentController paymentController) {
    List<DataRow> rows = List();

    for (int indice = 0; indice < paymentController.payments.length; indice++) {
      Payment element = paymentController.payments[indice];
      rows.add(DataRow(
        selected: element.selected,
        cells: <DataCell>[
          DataCell(Text(element.type)),
          DataCell(Text(element.place)),
          DataCell(Text("${element.value}")),
        ],
        onSelectChanged: (value) {
          // utilizado desta forma pq no mobx não dá pra utilizar passagem de parametro por referência
          element.selected = value;
          paymentController.update(indice, element);
        },
      ));
    }
    ;
    return rows;
  }
}
