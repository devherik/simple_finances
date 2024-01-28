import 'package:flutter/material.dart';
import 'package:simple_finances/config/database/entities/entity_cashflow.dart';
import 'package:simple_finances/config/database/entities/transaction/entity_transaction.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class WidgetFinances {
  final BuildContext _context;

  WidgetFinances({required BuildContext context}) : _context = context;

  Widget scrollAppBarCashflow(double scrollPosition, EntityCashflow cashflow) {
    // to create an adaptive appbar, this widget uses the scroll position to
    // resize the container and realocate the widgets inside of it
    double size = scrollPosition <= 100 ? 200 - scrollPosition : 100;
    if (size >= 150.0) {
      return SafeArea(
        top: false,
        child: Container(
          height: size,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
                        onPressed: () {},
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
                            onPressed: () {},
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
                          'R\$ ${cashflow.getOpenValue().toString()}',
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
                        'R\$ ${cashflow.getOpenValue().toString()}',
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
        return Card(
          child: Text(
            transactions[index].getId(),
            style: TextStyle(color: gbl.primaryLight, fontSize: 22),
          ),
        );
      },
    );
  }
}
