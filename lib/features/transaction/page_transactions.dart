import 'package:flutter/material.dart';
import 'package:simple_finances/config/usecases/dao_transactions.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;
import 'package:simple_finances/config/util/app_ui_widgets.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  DateTime _dataLabel = DateTime.now();

  final ui = UiWidgets();

  final _descriptionTextController = TextEditingController();
  final _valueTextController = TextEditingController();

  bool incomeButtonState = true;
  Color incomeButtonBackColor = gbl.primaryLight;
  Color incomeButtonTextColor = gbl.primaryDark;

  bool outcomeButtonState = false;
  Color outcomeButtonBackColor = gbl.primaryDark;
  Color outcomeButtonTextColor = gbl.primaryLight;

  @override
  Widget build(BuildContext context) {
    final _daoTransaction = DaoTransactions(context: context);
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
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
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/brown_gradient.jpeg'),
              fit: BoxFit.cover),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                              onPressed: incomeButtonStateChange,
                              elevation: 4,
                              color: incomeButtonBackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 18),
                              onLongPress: null,
                              minWidth: MediaQuery.of(context).size.width * .4,
                              child: Text(
                                'Income',
                                style: TextStyle(
                                    color: incomeButtonTextColor,
                                    fontSize: 15,
                                    letterSpacing: 3),
                              )),
                          MaterialButton(
                              onPressed: outcomeButtonStateChange,
                              elevation: 4,
                              color: outcomeButtonBackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 18),
                              onLongPress: null,
                              minWidth: MediaQuery.of(context).size.width * .4,
                              child: Text(
                                'Outcome',
                                style: TextStyle(
                                    color: outcomeButtonTextColor,
                                    fontSize: 15,
                                    letterSpacing: 3),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: ui.basicNumberForm('Valor', "Informe o valor",
                            _valueTextController, TextInputType.number),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ui.basicTextForm(
                          'Descrição',
                          'Informe os detalhes',
                          _descriptionTextController,
                          TextInputType.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ui.basicMaterialButtom(() {
                        if (_valueTextController.text.isNotEmpty &&
                            _descriptionTextController.text.isNotEmpty) {
                          if (incomeButtonState) {
                            onSave();
                            // _daoTransaction.persistTransaction(
                            //     _dataLabel,
                            //     'income',
                            //     double.parse(_valueTextController.text),
                            //     _descriptionTextController.text.trim());
                          } else if (outcomeButtonState) {
                            // _daoTransaction.persistTransaction(
                            //     _dataLabel,
                            //     'outcome',
                            //     double.parse(_valueTextController.text),
                            //     _descriptionTextController.text.trim());
                          } else {
                            ui.showMessage(
                                'Selecione o tipo de transação.', context);
                          }
                        } else {
                          ui.showMessage('Campo(s) vazio(s).', context);
                        }
                      }, 'Salvar', gbl.primaryLight, gbl.primaryDark, context,
                          MediaQuery.of(context).size.width),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void incomeButtonStateChange() {
    if (!incomeButtonState) {
      setState(() {
        incomeButtonState = true;
        incomeButtonBackColor = gbl.primaryLight;
        incomeButtonTextColor = gbl.primaryDark;
        outcomeButtonState = false;
        outcomeButtonBackColor = gbl.primaryDark;
        outcomeButtonTextColor = gbl.primaryLight;
      });
    } else {
      setState(() {
        incomeButtonState = false;
        incomeButtonBackColor = gbl.primaryDark;
        incomeButtonTextColor = gbl.primaryLight;
      });
    }
  }

  void outcomeButtonStateChange() {
    if (!outcomeButtonState) {
      setState(() {
        outcomeButtonState = true;
        outcomeButtonBackColor = gbl.primaryLight;
        outcomeButtonTextColor = gbl.primaryDark;
        incomeButtonState = false;
        incomeButtonBackColor = gbl.primaryDark;
        incomeButtonTextColor = gbl.primaryLight;
      });
    } else {
      setState(() {
        outcomeButtonState = false;
        outcomeButtonBackColor = gbl.primaryDark;
        outcomeButtonTextColor = gbl.primaryLight;
      });
    }
  }

  void onSave() {
    setState(() {
      _descriptionTextController.value = _descriptionTextController.value
          .copyWith(
              text: '', selection: const TextSelection.collapsed(offset: 0));
      _valueTextController.value.copyWith(
          text: '', selection: const TextSelection.collapsed(offset: 0));
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: gbl.primaryDark,
            content: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: gbl.baseGreen,
                      size: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        'Transação salva.',
                        style: TextStyle(
                            color: gbl.baseGreen,
                            fontSize: 12,
                            letterSpacing: 3),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
