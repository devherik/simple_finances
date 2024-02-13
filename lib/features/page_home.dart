import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_finances/config/database/entities/entity_account.dart';
import 'package:simple_finances/config/database/entities/entity_user.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/config/util/app_ui_widgets.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  EntityUser _user = EntityUser(id: '', name: '');
  EntityAccount _account = EntityAccount(id: '', name: '', phone: '');
  late CloudFirestoreDataBase _database;
  final UiWidgets ui = UiWidgets();

  @override
  void initState() {
    super.initState();
    _database = CloudFirestoreDataBase();
    _updateApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/brown_gradient.jpeg'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: gbl.primaryLight,
          ),
        ),
      ),
    );
  }

  void _updateApp() async {
    try {
      await _database
          .getDocument('users', FireAuth().currentUser!.uid)
          .then((user) {
            _user = EntityUser(id: user.id, name: user['name']);
            _user.accountsLinked = user['accounts_linked'];
          })
          .whenComplete(() async => await _database
              .getDocument('accounts', _user.accountsLinked[0])
              .then((account) {
                _account = EntityAccount(
                    id: account.id,
                    name: account['name'],
                    phone: account['phone']);
                gbl.globalAccount = _account;
              })
              .whenComplete(() => context.go('/cashflow'))
              .onError((error, stackTrace) {
                ui.showMessage(error.toString(), context);
              }))
          .onError((error, stackTrace) {
            ui.showMessage(error.toString(), context);
          });
    } catch (e) {
      print(e);
    }
  }
}
