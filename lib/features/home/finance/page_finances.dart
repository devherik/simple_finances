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

  @override
  void initState() {
    _daoCashflow = DaoCashflow();
    _daoTransactions = DaoTransactions(context: context);
    wfinance = WidgetFinances(
        context: context,
        scrollPosition: _scrollControllerOffset,
        daoTransactions: _daoTransactions,
        update: updatePage);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    updatePage();
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
              return Column(
                children: [
                  wfinance!.scrollAppBarCashflow(cashflow.data!),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: StreamBuilder(
                          stream: _transactions!.asStream(),
                          builder: (context, transactions) {
                            if (transactions.hasData) {
                              return wfinance!.listTransactionsCashflow(
                                  cashflow.data!, transactions.data!);
                            } else {
                              return Center(
                                child: Text(
                                  'Sem transações',
                                  style: TextStyle(
                                      color: gbl.primaryLight,
                                      fontSize: 14,
                                      letterSpacing: 3),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
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

  updatePage() {
    _currentCashflow = _daoCashflow!.getCurrentCashflow();
    setState(() {});
  }

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }
}
