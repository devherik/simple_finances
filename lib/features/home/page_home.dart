import 'package:flutter/material.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
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

  Widget dailyCard(String date) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              date,
              style: TextStyle(
                  color: gbl.primaryLight, fontSize: 10, letterSpacing: 3),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      color: gbl.primaryLight, fontSize: 18, letterSpacing: 3),
                ),
                VerticalDivider(
                  color: gbl.primaryLight,
                  thickness: 1,
                ),
                Text(
                  'Lucro',
                  style: TextStyle(
                      color: gbl.primaryLight, fontSize: 18, letterSpacing: 3),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            dailyCard('hoje - 28/11'),
            dailyCard('sábado - 27/11'),
            dailyCard('sexta - 26/11'),
            dailyCard('quinta - 25/11'),
            dailyCard('quarta - 24/11'),
            dailyCard('terça - 23/11'),
            dailyCard('segunda - 22/11'),
          ],
        ),
      ),
    );
  }
}
