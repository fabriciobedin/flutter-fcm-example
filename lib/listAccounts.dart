import 'package:flutter/material.dart';
import 'package:flutter_contas/firebaseNotifications.dart';
import 'package:flutter_contas/provider/paymentController.dart';
import 'package:provider/provider.dart';

class ListAccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    new FirebaseNotifications(context).setUpFirebase();

    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
      ),
      body: Consumer<PaymentController>(builder: (context, controller, child) {
        return controller.items.length == 0
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
                rows: getRows(controller),
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

  List<DataRow> getRows(PaymentController controller) {
    List<DataRow> rows = List();

    controller.items.forEach((element) {
      rows.add(DataRow(
        selected: element.selected,
        cells: <DataCell>[
          DataCell(Text(element.type)),
          DataCell(Text(element.place)),
          DataCell(Text("${element.value}")),
        ],
        onSelectChanged: (value) {
          element.selected = value;
          controller.update();
        },
      ));
    });
    return rows;
  }
}
