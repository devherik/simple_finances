import 'package:flutter/material.dart';
import 'package:simple_finances/config/usecases/dao_finances.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageFinances extends StatefulWidget {
  const PageFinances({super.key});

  @override
  State<PageFinances> createState() => _PageFinancesState();
}

class _PageFinancesState extends State<PageFinances> {
  final _daoFinances = DaoFinances();
  Future<List<Map<String, dynamic>>>? daysWithTransactions;
  String currentMonth = '';
  int yearIndex = DateTime.now().year;
  int monthIndex = DateTime.now().month;
  Map<String, dynamic> monthBalance = {
    'current_balance': 1600,
    'id': 05,
  };
  @override
  Widget build(BuildContext context) {
    _updatePage();
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
                  return Text(
                    snapshot.data!.toString(),
                    style: TextStyle(color: gbl.primaryLight),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  );
                }
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

  Widget dayBalance(int day) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dia ${monthBalance['id']}',
              style: TextStyle(
                  color: gbl.primaryLight, fontSize: 10, letterSpacing: 3),
            ),
            Text(
              'R\$ ${monthBalance['current_balance']}',
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
  }
}
