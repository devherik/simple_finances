import 'package:flutter/material.dart';
import 'package:simple_finances/config/usecases/dao_finances.dart';
import 'package:simple_finances/config/usecases/dao_transactions.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageFinances extends StatefulWidget {
  const PageFinances({super.key});

  @override
  State<PageFinances> createState() => _PageFinancesState();
}

class _PageFinancesState extends State<PageFinances> {
  final _daoFinances = DaoFinances();
  final _daoTransactions = DaoTransactions();
  Future<List<Map<String, dynamic>>>? daysWithTransactions;
  String currentMonth = '';
  int yearIndex = DateTime.now().year;
  int monthIndex = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    daysWithTransactions =
        _daoFinances.getBalanceCollection(DateTime(yearIndex, monthIndex));
    monthName(monthIndex);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    ),
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
            StreamBuilder(
              stream: daysWithTransactions!.asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return dayBalance(snapshot.data!);
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width - 16,
                  height: MediaQuery.of(context).size.height - 16,
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: gbl.primaryLight,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updatePage() async {
    setState(() {
      daysWithTransactions =
          _daoFinances.getBalanceCollection(DateTime(yearIndex, monthIndex));
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
            dayTransactions(balanceMap[index]['current_day']),
          ],
        );
      },
    );
  }

  Widget dayTransactions(String day) {
    Future<List<Map<String, dynamic>>> transactionsMap =
        _daoTransactions.getTransactionsCollection(
            DateTime(yearIndex, monthIndex, int.parse(day)));
    return StreamBuilder(
      stream: transactionsMap.asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              switch (snapshot.data![index]['type']) {
                case 'empty':
                  return const SizedBox();
                case 'income':
                  return Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: gbl.baseGreen,
                      ),
                      Column(
                        children: [
                          Text(
                            '${snapshot.data![index]['value']} \n${snapshot.data![index]['description']}',
                            style: TextStyle(color: gbl.primaryLight),
                          )
                        ],
                      )
                    ],
                  );
                case 'outcome':
                  return Row(
                    children: [
                      const Icon(
                        Icons.remove,
                        color: gbl.baseRed,
                      ),
                      Column(
                        children: [
                          Text(
                            '${snapshot.data![index]['value']} \n${snapshot.data![index]['description']}',
                            style: TextStyle(color: gbl.primaryLight),
                          )
                        ],
                      )
                    ],
                  );
              }
              return Text(
                snapshot.data![index]['type'],
                style: TextStyle(color: gbl.primaryLight),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
