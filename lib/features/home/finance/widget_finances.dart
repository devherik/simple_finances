import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_finances/config/database/entities/entity_cashflow.dart';
import 'package:simple_finances/config/database/entities/transaction/entity_transaction.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class WidgetFinances {
  final BuildContext _context;

  WidgetFinances({required BuildContext context}) : _context = context;

  String currentDay =
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  Widget scrollAppBarCashflow(double scrollPosition, EntityCashflow cashflow) {
    // to create an adaptive appbar, this widget uses the scroll position to
    // resize the container and realocate the widgets inside of it
    double size = scrollPosition <= 100 ? 200 - scrollPosition : 100;
    if (size >= 150.0) {
      return SafeArea(
        top: false,
        child: Container(
          height: size,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Colors.transparent.withOpacity(0.1),
          child: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(_context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Caixa',
                        style: TextStyle(
                            color: gbl.primaryLight,
                            fontSize: 20,
                            letterSpacing: 3),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Share.share(cashflow.toString(),
                              subject: 'Cashflow Resume');
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        splashColor: gbl.primaryDark,
                        child: Icon(
                          Icons.share,
                          color: gbl.primaryLight,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: gbl.primaryLight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            cashflow.getInitTimeToString(),
                            style: TextStyle(
                                color: gbl.primaryLight,
                                fontSize: 14,
                                letterSpacing: 3),
                          ),
                          MaterialButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: _context,
                                  builder: (context) =>
                                      closeCashflowBottomSheet(cashflow));
                            },
                            padding: const EdgeInsets.all(0),
                            color: gbl.primaryLight,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            splashColor: gbl.primaryDark,
                            child: Text(
                              'Fechar',
                              style: TextStyle(
                                  color: gbl.primaryDark,
                                  fontSize: 14,
                                  letterSpacing: 3),
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: Text(
                          'R\$ ${cashflow.getCloseValue()}',
                          style: TextStyle(
                              color: gbl.primaryLight,
                              fontSize: 14,
                              letterSpacing: 3),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        top: false,
        child: Container(
          height: size,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          color: Colors.transparent.withOpacity(0.1),
          child: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(_context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'R\$ ${cashflow.getCloseValue()}',
                        style: TextStyle(
                            color: gbl.primaryLight,
                            fontSize: 20,
                            letterSpacing: 3),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        splashColor: gbl.primaryLight,
                        child: Icon(
                          Icons.share,
                          color: gbl.primaryLight,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget listTransactionsCashflow(List<EntityTransaction> transactions) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        if (transactions[index].getType() == 'order') {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: _context,
                  builder: (context) =>
                      transactionBottomSheet(transactions[index]));
            },
            child: Card(
              color: Colors.transparent.withOpacity(0.1),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: gbl.baseBlue,
                        ),
                        Text(
                          'pedido',
                          style: TextStyle(color: gbl.baseBlue, fontSize: 10),
                        ),
                      ],
                    ),
                    Text(
                      'R\$ ${transactions[index].getValue().toString()} - ${transactions[index].getInitTimeToString()}',
                      style: TextStyle(color: gbl.primaryLight, fontSize: 18),
                    ),
                    transactions[index].getPaymentState()
                        ? const Icon(
                            Icons.check,
                            color: gbl.baseGreen,
                            size: 20,
                          )
                        : const Icon(
                            Icons.close,
                            color: gbl.baseRed,
                            size: 20,
                          )
                  ],
                ),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {},
            child: Card(
              color: Colors.transparent.withOpacity(0.1),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    transactions[index].getType() == 'income'
                        ? const Row(
                            children: [
                              Icon(
                                Icons.arrow_downward,
                                color: gbl.baseGreen,
                              ),
                              Text(
                                'entrada',
                                style: TextStyle(
                                    color: gbl.baseGreen, fontSize: 10),
                              ),
                            ],
                          )
                        : const Row(
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                color: gbl.baseRed,
                              ),
                              Text(
                                'saída',
                                style:
                                    TextStyle(color: gbl.baseRed, fontSize: 10),
                              ),
                            ],
                          ),
                    Text(
                      'R\$ ${transactions[index].getValue().toString()} - ${transactions[index].getInitTimeToString()}',
                      style: TextStyle(color: gbl.primaryLight, fontSize: 18),
                    ),
                    transactions[index].getPaymentState()
                        ? const Icon(
                            Icons.check,
                            color: gbl.baseGreen,
                            size: 20,
                          )
                        : const Icon(
                            Icons.close,
                            color: gbl.baseRed,
                            size: 20,
                          )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget transactionBottomSheet(EntityTransaction transaction) {
    return Container(
      decoration: BoxDecoration(
          color: gbl.primaryDark, borderRadius: BorderRadius.circular(10)),
      height: 400,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 35,
              child: Divider(color: gbl.secondaryDark),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' R\$ ${transaction.getValue()}',
                  style: TextStyle(
                    color: gbl.primaryLight,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: gbl.primaryLight,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.date_range,
                  color: gbl.primaryLight,
                  size: 20,
                ),
                Text(
                  ' ${transaction.getInitTimeToString()}',
                  style: TextStyle(
                      color: gbl.primaryLight, fontSize: 16, letterSpacing: 3),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(_context).size.width * .9,
            child: Divider(
              color: gbl.primaryLight,
              thickness: .5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  color: gbl.primaryLight,
                  size: 20,
                ),
                Text(
                  ' Cliente',
                  style: TextStyle(
                      color: gbl.primaryLight, fontSize: 16, letterSpacing: 3),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(_context).size.width * .9,
            child: Divider(
              color: gbl.primaryLight,
              thickness: .5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.shopping_bag,
                  color: gbl.primaryLight,
                  size: 20,
                ),
                Text(
                  ' Produtos',
                  style: TextStyle(
                      color: gbl.primaryLight, fontSize: 16, letterSpacing: 3),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            // child: ListView(),
          ),
          SizedBox(
            width: MediaQuery.of(_context).size.width * .9,
            child: Divider(
              color: gbl.primaryLight,
              thickness: .5,
            ),
          ),
        ],
      ),
    );
  }

  Widget closeCashflowBottomSheet(EntityCashflow cashflow) {
    return Container(
      decoration: BoxDecoration(
          color: gbl.primaryDark, borderRadius: BorderRadius.circular(10)),
      height: 400,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 35,
              child: Divider(color: gbl.secondaryDark),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.business_center,
                  color: gbl.primaryLight,
                ),
                Text(
                  'Fechamento de caixa',
                  style: TextStyle(
                    color: gbl.primaryLight,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: gbl.primaryLight,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.monetization_on_outlined,
                  color: gbl.primaryLight,
                  size: 20,
                ),
                Text(
                  ' R\$ ${cashflow.getCloseValue()}',
                  style: TextStyle(
                      color: gbl.primaryLight, fontSize: 16, letterSpacing: 3),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(_context).size.width * .9,
            child: Divider(
              color: gbl.primaryLight,
              thickness: .5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.date_range,
                  color: gbl.primaryLight,
                  size: 20,
                ),
                Text(
                  ' ${cashflow.getInitTimeToString()} até $currentDay',
                  style: TextStyle(
                      color: gbl.primaryLight, fontSize: 16, letterSpacing: 3),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MaterialButton(
              onPressed: () {},
              color: gbl.primaryLight,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              minWidth: MediaQuery.of(_context).size.width * .9,
              splashColor: gbl.primaryDark,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text(
                'Confirmar',
                style: TextStyle(
                    color: gbl.primaryDark, letterSpacing: 3, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
