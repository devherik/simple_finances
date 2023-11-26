import 'package:flutter/material.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/features/home/page_finances.dart';
import 'package:simple_finances/features/home/page_goals.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;
import 'package:simple_finances/features/home/page_home.dart';

class PageNaigationBar extends StatefulWidget {
  const PageNaigationBar({super.key});

  @override
  State<PageNaigationBar> createState() => _PageNaigationBarState();
}

class _PageNaigationBarState extends State<PageNaigationBar> {
  int currentPageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () => FireAuth().signOut(),
                child: Icon(
                  Icons.logout,
                  color: gbl.primaryLight,
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.track_changes),
            label: 'Goals',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.money),
            label: 'Finances',
          )
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
      ),
      body: [
        const PageGoals(),
        const PageHome(),
        const PageFinances()
      ][currentPageIndex],
    );
  }
}
