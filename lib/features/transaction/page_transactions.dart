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
  double _orderValue = 0.0;
  String _clientLabel = 'Informe o cliente';
  String _productsLabel = 'Selecione o(s) produto(s)';

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
          backgroundColor: Colors.transparent.withOpacity(.1),
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
                        child: transactionTypeRow()),
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
                    orderButtonState
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ui.iconButtom(() async {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return bottomModalProducts();
                                    });
                              }, _productsLabel, Icons.shopping_bag_outlined,
                                  context),
                            ),
                          )
                        : const SizedBox(),
                    orderButtonState
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ui.iconButtom(() async {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return bottomModalClients();
                                    });
                              }, _clientLabel, Icons.person_2_outlined,
                                  context),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: orderButtonState
                            ? TextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                controller: _valueTextController,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                enabled: false,
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 3,
                                    color: gbl.secondaryLight),
                                decoration: InputDecoration(
                                    icon:
                                        const Icon(Icons.attach_money_outlined),
                                    iconColor: gbl.primaryLight,
                                    prefixText: 'R\$',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 12),
                                    border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'R\$ ${_orderValue.toString()}',
                                    labelStyle: TextStyle(
                                        fontSize: 15,
                                        color: gbl.secondaryLight,
                                        letterSpacing: 3),
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: gbl.secondaryLight,
                                        letterSpacing: 3),
                                    filled: true,
                                    fillColor:
                                        Colors.transparent.withOpacity(.4)),
                              )
                            : ui.basicNumberForm(
                                'Informe o valor',
                                Icons.attach_money_outlined,
                                _valueTextController,
                                TextInputType.number),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: orderButtonState
                          ? const SizedBox()
                          : ui.basicTextForm(
                              'Descreva a transação',
                              Icons.text_snippet_outlined,
                              _descriptionTextController,
                              TextInputType.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ui.basicMaterialButtom(() {
                        if (formCheckInputs()) {}
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

  bool formCheckInputs() {
    if (!incomeButtonState && !outcomeButtonState && !orderButtonState) {
      ui.showMessage('Selecione um tipo de transação', context);
      return false;
    } else {
      if (orderButtonState) {
        if (_clientLabel != 'Informe o cliente' && _orderValue != 0.0) {
          return true;
        } else {
          ui.showMessage('Campo(s) vazio(s)', context);
          return false;
        }
      } else {
        if (_valueTextController.text.isNotEmpty &&
            _descriptionTextController.text.isNotEmpty) {
          return true;
        } else {
          ui.showMessage('Campo(s) vazio(s)', context);
          return false;
        }
      }
    }
  }

  Widget bottomModalProducts() {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('assets/brown_gradient.jpeg'), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Column(children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 35,
            child: Divider(color: gbl.secondaryDark),
          ),
        ),
      ]),
    );
  }

  Widget bottomModalClients() {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('assets/brown_gradient.jpeg'), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Column(children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 35,
            child: Divider(color: gbl.secondaryDark),
          ),
        ),
      ]),
    );
  }

  Widget transactionTypeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
            onPressed: incomeButtonStateChange,
            elevation: 4,
            color: incomeButtonBackColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            onLongPress: null,
            minWidth: MediaQuery.of(context).size.width * .3,
            child: Text(
              'Entrada',
              style: TextStyle(
                  color: incomeButtonTextColor, fontSize: 15, letterSpacing: 3),
            )),
        MaterialButton(
            onPressed: outcomeButtonStateChange,
            elevation: 4,
            color: outcomeButtonBackColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            onLongPress: null,
            minWidth: MediaQuery.of(context).size.width * .3,
            child: Text(
              'Pedido',
              style: TextStyle(
                  color: orderButtonTextColor, fontSize: 15, letterSpacing: 3),
            )),
      ],
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
      _orderValue = 0.0;
      _clientLabel = 'Informe o cliente';
      _productsLabel = 'Selecione o(s) produto(s)';
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: gbl.primaryDark,
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: gbl.baseGreen,
                    size: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'Transação salva.',
                      style: TextStyle(
                          color: gbl.primaryLight,
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
  }
}
