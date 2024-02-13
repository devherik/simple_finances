import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_finances/config/database/entities/entity_account.dart';
import 'package:simple_finances/config/database/entities/entity_user.dart';
import 'package:simple_finances/config/database/firebase/app_cloudfirestore_db.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/config/util/app_ui_widgets.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;
import 'package:simple_finances/features/navigation_bar/page_navigation_bar.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key, required this.child});
  final StatefulNavigationShell child;

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int currentPageIndex = 1;
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
    return PageNavigationBar(child: widget.child);
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
              }).onError((error, stackTrace) {
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
