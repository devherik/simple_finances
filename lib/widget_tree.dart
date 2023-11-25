import 'package:flutter/material.dart';
import 'package:simple_finances/features/home/page_home.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/features/welcome/page_welcome.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireAuth().authStateChanges,
      builder: (context, snapshot) =>
          snapshot.hasData ? const PageHome() : const PageWelcome(),
    );
  }
}
