import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  bool _isLoading = false;
  String _buttomLabel = 'Enviar';

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
      backgroundColor: gbl.primaryDark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: gbl.primaryDark,
        iconTheme: IconThemeData(color: gbl.primaryLight),
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
                  padding: const EdgeInsets.all(40),
                  child: SvgPicture.asset(
                    'assets/illustrations/forgot_password.svg',
                    semanticsLabel: 'Forgot Password',
                    height: 200,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
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
                      labelText: 'Digite seu email',
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
                  padding: const EdgeInsets.only(top: 30, bottom: 100),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_checkInputs()) {
                        UiWidgets().showMessage(
                            'Confira seus dados e tente novamente.', context);
                      } else {
                        setState(() => _isLoading = true);
                        await FireAuth()
                            .resetPassword(
                                email: _emailTextController.text.trim())
                            .whenComplete(() {
                          setState(() {
                            _isLoading = false;
                            _buttomLabel = 'Sucesso';
                          });
                        }).onError(
                          (error, stackTrace) {
                            if (kDebugMode) {
                              error.toString();
                            }
                            setState(() => _buttomLabel = 'Tente novamente');
                          },
                        );
                        await Future.delayed(const Duration(seconds: 2));
                        if (kDebugMode) {
                          print(_emailTextController.text);
                        }
                      }
                    },
                    elevation: 4,
                    color: gbl.primaryLight,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    splashColor: gbl.secondaryDark,
                    onLongPress: null,
                    minWidth: MediaQuery.of(context).size.width * .6,
                    child: _isLoading
                        ? CircularProgressIndicator(color: gbl.primaryDark)
                        : Text(
                            _buttomLabel,
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
