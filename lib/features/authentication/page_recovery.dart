import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;
import 'package:simple_finances/config/util/app_ui_widgets.dart';

class PageRecovery extends StatefulWidget {
  const PageRecovery({super.key});

  @override
  State<PageRecovery> createState() => _PageRecoveryState();
}

class _PageRecoveryState extends State<PageRecovery> {
  final _emailTextController = TextEditingController();

  bool _checkInputs() {
    // check the data from textfields and return true if they are empty
    if (_emailTextController.text.trim().isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: gbl.primaryDark,
      ),
      body: Container(
        color: gbl.primaryDark,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextController,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 3,
                        color: gbl.primaryLight),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: gbl.primaryLight, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: gbl.primaryLight, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: gbl.primaryLight, width: 1),
                      ),
                      labelText: 'E-mail',
                      labelStyle: TextStyle(
                          fontSize: 15,
                          letterSpacing: 3,
                          color: gbl.primaryLight),
                      hintText: 'usuario@mail.com',
                      hintStyle: TextStyle(
                          fontSize: 10,
                          letterSpacing: 3,
                          color: gbl.primaryLight),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 70),
                  child: MaterialButton(
                    onPressed: () {
                      if (_checkInputs()) {
                        UiWidgets().showMessage(
                            'Confira seus dados e tente novamente.', context);
                      } else {
                        FireAuth()
                            .resetPassword(
                                email: _emailTextController.text.trim())
                            .onError(
                              (error, stackTrace) => UiWidgets()
                                  .showMessage(error.toString(), context),
                            );
                        if (kDebugMode) {
                          print(_emailTextController.text);
                        }
                      }
                    },
                    elevation: 4,
                    color: gbl.primaryLight,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    splashColor: gbl.secondaryDark,
                    onLongPress: null,
                    minWidth: MediaQuery.of(context).size.width * .6,
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                          letterSpacing: 3,
                          fontSize: 20,
                          color: gbl.primaryDark),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
