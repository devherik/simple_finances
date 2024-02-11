import 'package:flutter/material.dart';
import 'package:simple_finances/features/home/finance/page_finances.dart';
import 'package:simple_finances/features/home/goal/page_goals.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;
import 'package:simple_finances/features/transaction/page_transactions.dart';

class PageNavigationBar extends StatefulWidget {
  const PageNavigationBar({super.key});

  @override
  State<PageNavigationBar> createState() => _PageNavigationBarState();
}

class _PageNavigationBarState extends State<PageNavigationBar> {
  int currentPageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add), label: 'Adicionar'),
          NavigationDestination(
              icon: Icon(Icons.track_changes), label: 'Objetivos'),
        ],
        height: 50,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.transparent,
        indicatorColor: gbl.primaryLight,
        surfaceTintColor: gbl.secondaryDark,
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
      ),
      body: [
        const PageFinances(),
        const TransactionsPage(),
        const PageGoals(),
      ][currentPageIndex],
      extendBody: true,
    );
  }
}
