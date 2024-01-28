import 'package:flutter/material.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class WidgetFinances {
  final BuildContext _context;
  WidgetFinances({required BuildContext context}) : _context = context;
  Widget scrollAppBarClinch(double scrollPosition) {
    double size = scrollPosition <= 100 ? 200 - scrollPosition : 100;
    if (size >= 130.0) {
      return SafeArea(
        top: false,
        child: Container(
          height: size,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          color: gbl.primaryLight,
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(_context).size.width,
              child: Column(
                children: [
                  Text(
                    'Caixa',
                    style: TextStyle(color: gbl.primaryDark),
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
          color: gbl.primaryLight,
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(_context).size.width,
              child: Column(
                children: [
                  Text(
                    'R\$ 1500,00',
                    style: TextStyle(color: gbl.primaryDark),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
