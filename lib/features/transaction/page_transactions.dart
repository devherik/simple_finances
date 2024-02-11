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
  Color outcomeButtonBackColor = Colors.transparent.withOpacity(.1);
  Color outcomeButtonTextColor = gbl.primaryLight;

  bool orderButtonState = false;
  Color orderButtonBackColor = Colors.transparent.withOpacity(.1);
  Color orderButtonTextColor = gbl.primaryLight;

  @override
  Widget build(BuildContext context) {
    final _daoTransaction = DaoTransactions(context: context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Nova transação',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: gbl.primaryLight,
                letterSpacing: 3),
          ),
          centerTitle: true),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/brown_gradient.jpeg'),
              fit: BoxFit.cover),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                              onPressed: incomeButtonStateChange,
                              elevation: 4,
                              color: incomeButtonBackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              onLongPress: null,
                              minWidth: MediaQuery.of(context).size.width * .3,
                              child: Text(
                                'Entrada',
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
                                  horizontal: 12, vertical: 12),
                              onLongPress: null,
                              minWidth: MediaQuery.of(context).size.width * .3,
                              child: Text(
                                'Saída',
                                style: TextStyle(
                                    color: outcomeButtonTextColor,
                                    fontSize: 15,
                                    letterSpacing: 3),
                              )),
                          MaterialButton(
                              onPressed: orderButtonStateChange,
                              elevation: 4,
                              color: orderButtonBackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              onLongPress: null,
                              minWidth: MediaQuery.of(context).size.width * .3,
                              child: Text(
                                'Pedido',
                                style: TextStyle(
                                    color: orderButtonTextColor,
                                    fontSize: 15,
                                    letterSpacing: 3),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ui.iconButtom(() async {
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
                        }, '${_dataLabel.day}/${_dataLabel.month}/${_dataLabel.year}',
                            Icons.edit_calendar_outlined, context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ui.basicNumberForm(
                            'Valor',
                            Icons.attach_money_outlined,
                            _valueTextController,
                            TextInputType.number),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ui.basicTextForm(
                          'Descrição',
                          Icons.text_snippet_outlined,
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
        outcomeButtonBackColor = Colors.transparent.withOpacity(.1);
        outcomeButtonTextColor = gbl.primaryLight;
        orderButtonState = false;
        orderButtonBackColor = Colors.transparent.withOpacity(.1);
        orderButtonTextColor = gbl.primaryLight;
      });
    } else {
      setState(() {
        incomeButtonState = false;
        incomeButtonBackColor = Colors.transparent.withOpacity(.1);
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
        incomeButtonBackColor = Colors.transparent.withOpacity(.1);
        incomeButtonTextColor = gbl.primaryLight;
        orderButtonState = false;
        orderButtonBackColor = Colors.transparent.withOpacity(.1);
        orderButtonTextColor = gbl.primaryLight;
      });
    } else {
      setState(() {
        outcomeButtonState = false;
        outcomeButtonBackColor = Colors.transparent.withOpacity(.1);
        outcomeButtonTextColor = gbl.primaryLight;
      });
    }
  }

  void orderButtonStateChange() {
    if (!orderButtonState) {
      setState(() {
        orderButtonState = true;
        orderButtonBackColor = gbl.primaryLight;
        orderButtonTextColor = gbl.primaryDark;
        incomeButtonState = false;
        incomeButtonBackColor = Colors.transparent.withOpacity(.1);
        incomeButtonTextColor = gbl.primaryLight;
        outcomeButtonState = false;
        outcomeButtonBackColor = Colors.transparent.withOpacity(.1);
        outcomeButtonTextColor = gbl.primaryLight;
      });
    } else {
      setState(() {
        orderButtonState = false;
        orderButtonBackColor = Colors.transparent.withOpacity(.1);
        orderButtonTextColor = gbl.primaryLight;
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
    });
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
                          color: gbl.baseGreen, fontSize: 12, letterSpacing: 3),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
