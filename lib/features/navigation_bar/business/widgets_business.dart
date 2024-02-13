import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class WidgetBusiness {
  final BuildContext _context;

  WidgetBusiness({required BuildContext context}) : _context = context;

  Widget settingsDialog() {
    return AlertDialog(
      backgroundColor: gbl.primaryDark,
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                minWidth: MediaQuery.of(_context).size.width,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                splashColor: gbl.primaryLight,
                onPressed: () {
                  FireAuth().signOut().whenComplete(() {
                    _context.pop();
                  });
                },
                child: const Text(
                  'Sair',
                  style: TextStyle(color: gbl.baseRed),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(_context).size.width * .7,
                child: Divider(
                  color: gbl.primaryLight,
                  thickness: .5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
