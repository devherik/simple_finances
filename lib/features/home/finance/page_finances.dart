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
  String appBarTitle = 'Caixa';
  late ScrollController _scrollController;
  double _scrollControllerOffset = 0.0;

  List<EntityTransaction> _transactions = [];
  String currentMonth = '';
  int yearIndex = DateTime.now().year;
  int monthIndex = DateTime.now().month;

  @override
  void initState() {
    _daoCashflow = DaoCashflow();
    _daoTransactions = DaoTransactions(context: context);
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 8, right: 8, top: 36),
        child: Stack(
          children: [
            PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 20),
                child: scrollAppBarClinch(_scrollControllerOffset)),
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
    _currentCashflow = await _daoCashflow!.getCurrentCashflow();
    _transactions = await _daoTransactions!
        .getTransactionsCollection(_currentCashflow!.getId());
  }

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  Widget scrollAppBarClinch(double size) {
    return SafeArea(
        top: false,
        child: Container(
          height: 200,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          color: Colors.white.withOpacity((size / 350).clamp(0, 1).toDouble()),
          child: SafeArea(child: Container()),
        ));
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
