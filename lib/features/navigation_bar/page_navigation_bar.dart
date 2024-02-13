import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageNavigationBar extends StatelessWidget {
  const PageNavigationBar({super.key, required this.child});
  final StatefulNavigationShell child;

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
        selectedIndex: child.currentIndex,
        backgroundColor: Colors.transparent,
        indicatorColor: gbl.primaryLight,
        surfaceTintColor: gbl.secondaryDark,
        onDestinationSelected: (value) {
          _onTap(value);
        },
      ),
      body: child,
      extendBody: true,
    );
  }

  void _onTap(index) {
    child.goBranch(index, initialLocation: index == child.currentIndex);
  }
}
