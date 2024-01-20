import 'package:flutter/material.dart';
import 'package:simple_finances/config/usecases/dao_transactions.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  DateTime _dataLabel = DateTime.now();
  String? _transactionSelected;

  final _daoTransaction = DaoTransactions();
  final _transactionTypesList = const [
    DropdownMenuItem(
      value: 'income',
      child: Text('Entrada'),
    ),
    DropdownMenuItem(
      value: 'outcome',
      child: Text('Saída'),
    ),
  ];

  final _meioQtdTextControll = TextEditingController();
  final _inteiroQtdTextControll = TextEditingController();
  final _volumeTextControll = TextEditingController();
  final _notaFiscalTextControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      appBar: AppBar(
          backgroundColor: gbl.primaryDark,
          title: Text(
            '${_dataLabel.day}/${_dataLabel.month}/${_dataLabel.year}',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: gbl.primaryLight),
          ),
          actions: [
            IconButton(
              disabledColor: Colors.blueGrey,
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: _dataLabel,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (newDate == null) {
                  return;
                } else {
                  setState(() => _dataLabel = newDate);
                  // Tthis date will be used to create an event, at the day the user wants
                }
              },
              icon: Icon(
                Icons.edit_calendar_rounded,
                color: gbl.primaryLight,
              ),
            )
          ],
          centerTitle: true),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                iconDisabledColor: Colors.blueGrey,
                iconEnabledColor: Colors.black,
                isExpanded: false,
                dropdownColor: gbl.primaryDark,
                borderRadius: BorderRadius.circular(15),
                padding: const EdgeInsets.symmetric(vertical: 16),
                value: _transactionSelected,
                hint: Text(
                  'Selecione o tipo de transação',
                  style: TextStyle(color: gbl.primaryLight),
                ),
                icon: Icon(
                  Icons.arrow_downward,
                  color: gbl.primaryLight,
                ),
                elevation: 16,
                style: TextStyle(
                  color: gbl.primaryLight,
                  fontSize: 15,
                  letterSpacing: 3,
                ),
                alignment: Alignment.center,
                underline: Container(
                  height: 1,
                  color: gbl.secondaryLight,
                ),
                onChanged: (String? value) {
                  setState(() {
                    _transactionSelected = value!;
                  });
                },
                items: _transactionTypesList,
              ),
              _transactionSelected == 'income'
                  ? Container(
                      child: Text(
                        'Tá entrando dinheiro!!!!!!',
                        style: TextStyle(color: gbl.secondaryLight),
                      ),
                    )
                  : Container(
                      child: Text(
                        'Não deixa o dinheiro sair!!!!!',
                        style: TextStyle(color: gbl.secondaryLight),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
