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
      // appBar: AppBar(
      //   backgroundColor: gbl.primaryDark,
      //   centerTitle: true,
      //   title: Text(
      //     appBarTitle,
      //     style: TextStyle(color: gbl.primaryLight),
      //   ),
      //   actions: [
      //     MaterialButton(
      //       onPressed: () {},
      //       shape:
      //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //       splashColor: gbl.primaryLight,
      //       child: Icon(
      //         Icons.share,
      //         color: gbl.primaryLight,
      //       ),
      //     )
      //   ],
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/brown_gradient.jpeg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            FutureBuilder(
              future: _currentCashflow,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return wfinance!.scrollAppBarClinch(
                      _scrollControllerOffset, snapshot.data!);
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: gbl.primaryLight,
                    ),
                  );
                }
              },
            ),
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5,
                    child: Icon(
                      Icons.rocket,
                      color: gbl.primaryLight,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _updatePage() async {
    _currentCashflow = _daoCashflow!.getCurrentCashflow();
    // _transactions = _daoTransactions!
    //     .getTransactionsCollection(_currentCashflow!.getId());
  }

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
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
