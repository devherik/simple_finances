import 'package:flutter/material.dart';
import 'package:simple_finances/config/usecases/dao_finances.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final _daoFinance = DaoFinances();
  Future<List<Map<String, dynamic>>>? _balanceCollection;

  Widget dailyEvent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.add_box_outlined,
          color: gbl.primaryLight,
          size: 22,
        ),
        VerticalDivider(
          color: gbl.primaryLight,
        ),
        Text(
          'Fulano R30,00',
          style: TextStyle(
              color: gbl.primaryLight, fontSize: 18, letterSpacing: 3),
        ),
        MaterialButton(
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Icon(
            Icons.arrow_forward,
            color: gbl.primaryLight,
            size: 14,
          ),
        )
      ],
    );
  }

  Future<void> _updatePage() async {
    setState(() {
      _balanceCollection =
          _daoFinance.getBalanceCollection(DateTime(2023, 12, 27));
    });
  }

  Widget dailyCard(String date) {
    return StreamBuilder(
      stream: _balanceCollection!.asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    date,
                    style: TextStyle(
                        color: gbl.primaryLight,
                        fontSize: 10,
                        letterSpacing: 3),
                  ),
                ),
                Divider(
                  color: gbl.primaryLight,
                ),
                dailyEvent(),
                dailyEvent(),
                dailyEvent(),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: CircularProgressIndicator(
              color: gbl.primaryLight,
            )),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _updatePage();
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: _updatePage,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saldo do caixa',
                      style: TextStyle(
                          color: gbl.primaryLight,
                          fontSize: 18,
                          letterSpacing: 3),
                    ),
                    VerticalDivider(
                      color: gbl.primaryLight,
                      thickness: 1,
                    ),
                    Text(
                      'Lucro',
                      style: TextStyle(
                          color: gbl.primaryLight,
                          fontSize: 18,
                          letterSpacing: 3),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                dailyCard('hoje - 28/11'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
