import 'package:flutter/material.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/features/home/page_finances.dart';
import 'package:simple_finances/features/home/page_goals.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;
import 'package:simple_finances/features/home/page_transactions.dart';

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
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     FireAuth().currentUser!.email.toString(),
      //     style: TextStyle(
      //       color: gbl.primaryLight,
      //       letterSpacing: 3,
      //       fontSize: 12,
      //     ),
      //   ),
      //   actions: [
      //     MaterialButton(
      //       onPressed: () async => await FireAuth().signOut(),
      //       shape:
      //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      //       child: Icon(
      //         Icons.settings,
      //         color: gbl.primaryLight,
      //       ),
      //     )
      //   ],
      // ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add), label: 'Adicionar'),
          NavigationDestination(
              icon: Icon(Icons.track_changes), label: 'Objetivos'),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: currentPageIndex,
        backgroundColor: gbl.primaryDark,
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
