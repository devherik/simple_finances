import 'package:flutter/material.dart';
import 'package:simple_finances/config/database/entities/entity_cashflow.dart';
import 'package:simple_finances/config/database/entities/transaction/entity_transaction.dart';
import 'package:simple_finances/config/usecases/dao_cashflow.dart';
import 'package:simple_finances/config/usecases/dao_transactions.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;
import 'package:simple_finances/features/home/finance/widget_finances.dart';

class PageFinances extends StatefulWidget {
  const PageFinances({super.key});

  @override
  State<PageFinances> createState() => _PageFinancesState();
}

class _PageFinancesState extends State<PageFinances> {
  DaoCashflow? _daoCashflow;
  DaoTransactions? _daoTransactions;
  EntityCashflow? _currentCashflow;
  final wfinance = WidgetFinances();

  List<EntityTransaction> _transactions = [];
  String currentMonth = '';
  int yearIndex = DateTime.now().year;
  int monthIndex = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    _setInstances(context);
    monthName(monthIndex);
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: gbl.primaryDark,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              onPressed: () {
                if (monthIndex == 1) {
                  setState(() {
                    monthIndex = 12;
                    yearIndex -= 1;
                  });
                } else {
                  setState(() {
                    monthIndex--;
                  });
                }
              },
              minWidth: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(
                Icons.arrow_back,
                color: gbl.primaryLight,
              ),
            ),
            Text(
              '$currentMonth $yearIndex',
              style: TextStyle(
                  color: gbl.primaryLight,
                  letterSpacing: 3,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            MaterialButton(
              onPressed: () {
                if (monthIndex == 12) {
                  setState(() {
                    monthIndex = 1;
                    yearIndex += 1;
                  });
                } else {
                  setState(() {
                    monthIndex++;
                  });
                }
              },
              minWidth: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(
                Icons.arrow_forward,
                color: gbl.primaryLight,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 8, right: 8, top: 36),
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  Future<void> _setInstances(BuildContext context) async {
    _daoCashflow = DaoCashflow();
    _daoTransactions = DaoTransactions(context: context);
    _currentCashflow = await _daoCashflow!.getCurrentCashflow();
  }

  void _updatePage() {
    setState(() async {
      _transactions = await _daoTransactions!
          .getTransactionsCollection(_currentCashflow!.getId());
    });
  }

  void monthName(int numeric) {
    setState(() {
      switch (numeric) {
        case 1:
          currentMonth = 'Janeiro';
        case 2:
          currentMonth = 'Fevereiro';
        case 3:
          currentMonth = 'Março';
        case 4:
          currentMonth = 'Abril';
        case 5:
          currentMonth = 'Maio';
        case 6:
          currentMonth = 'Junho';
        case 7:
          currentMonth = 'Julho';
        case 8:
          currentMonth = 'Agosto';
        case 9:
          currentMonth = 'Setembro';
        case 10:
          currentMonth = 'Outubro';
        case 11:
          currentMonth = 'Novembro';
        case 12:
          currentMonth = 'Dezembro';
      }
    });
  }

  Widget dayBalance(List<Map<String, dynamic>> balanceMap) {
    return ListView.builder(
      shrinkWrap:
          true, // made the list work, but it seans not to be the best practice, instead perhaps I should use SliverList
      itemCount: balanceMap.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dia ${balanceMap[index]['current_day']}',
                  style: TextStyle(
                      color: gbl.primaryLight, fontSize: 10, letterSpacing: 3),
                ),
                Text(
                  'R\$ ${balanceMap[index]['current_balance']}',
                  style: TextStyle(
                      color: gbl.primaryLight, fontSize: 10, letterSpacing: 3),
                ),
              ],
            ),
            Divider(
              color: gbl.primaryLight,
            ),
          ],
        );
      },
    );
  }
}
