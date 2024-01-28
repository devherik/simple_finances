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
  Future<EntityCashflow>? _currentCashflow;
  WidgetFinances? wfinance;
  String appBarTitle = 'Caixa';
  late ScrollController _scrollController;
  double _scrollControllerOffset = 0.0;

  Future<List<EntityTransaction>>? _transactions;
  String currentMonth = '';
  int yearIndex = DateTime.now().year;
  int monthIndex = DateTime.now().month;

  @override
  void initState() {
    _daoCashflow = DaoCashflow();
    _daoTransactions = DaoTransactions(context: context);
    wfinance = WidgetFinances(context: context);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _updatePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/brown_gradient.jpeg'),
              fit: BoxFit.cover),
        ),
        child: FutureBuilder(
          future: _currentCashflow,
          builder: (context, cashflow) {
            if (cashflow.hasData) {
              _transactions = _daoTransactions!
                  .getTransactionsCollection(cashflow.data!.getId());
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    wfinance!.scrollAppBarCashflow(
                        _scrollControllerOffset, cashflow.data!),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: StreamBuilder(
                          stream: _transactions!.asStream(),
                          builder: (context, transactions) {
                            if (transactions.hasData) {
                              return wfinance!
                                  .listTransactionsCashflow(transactions.data!);
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: gbl.primaryLight,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _updatePage() async {
    _currentCashflow = _daoCashflow!.getCurrentCashflow();
  }

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }
}
