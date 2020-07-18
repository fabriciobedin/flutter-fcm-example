import 'package:flutter/material.dart';
import 'package:flutter_contas/firebaseNotifications.dart';
import 'package:flutter_contas/model/payment.dart';

class ListAccounts extends StatefulWidget {
  @override
  _ListAccountsState createState() => _ListAccountsState();
}

class _ListAccountsState extends State<ListAccounts> {
  List<Payment> payments = List();

  @override
  void initState() {
    super.initState();
    new FirebaseNotifications(useMessage).setUpFirebase();
  }

  void useMessage(Payment payment) {
    setState(() {
      payments.add(payment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
      ),
      body: payments.length == 0
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
              rows: getRows(),
            ),
    );
  }

  DataColumn getColumn(String label) => DataColumn(
        label: Text(
          label,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      );

  List<DataRow> getRows() {
    List<DataRow> rows = List();

    payments.forEach((element) {
      rows.add(DataRow(
        selected: element.selected,
        cells: <DataCell>[
          DataCell(Text(element.type)),
          DataCell(Text(element.place)),
          DataCell(Text("${element.value}")),
        ],
        onSelectChanged: (value) {
          setState(() {
            element.selected = value;
          });
        },
      ));
    });
    return rows;
  }
}