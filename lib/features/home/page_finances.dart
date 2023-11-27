import 'package:flutter/material.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageFinances extends StatefulWidget {
  const PageFinances({super.key});

  @override
  State<PageFinances> createState() => _PageFinancesState();
}

class _PageFinancesState extends State<PageFinances> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(
                      Icons.arrow_back,
                      color: gbl.primaryLight,
                    ),
                  ),
                  Text(
                    'Novembro',
                    style: TextStyle(
                      color: gbl.primaryLight,
                      letterSpacing: 3,
                      fontSize: 20,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(
                      Icons.arrow_forward,
                      color: gbl.primaryLight,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
