import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_finances/config/router/app_router.dart';
import 'package:simple_finances/theme/app_theme.dart';

import 'package:simple_finances/config/util/app_globals.dart' as glb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      title: glb.appTitle,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
