import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;
import 'package:simple_finances/config/util/app_ui_widgets.dart';

class PageAuth extends StatefulWidget {
  const PageAuth({super.key});

  @override
  State<PageAuth> createState() => _PageAuthState();
}

class _PageAuthState extends State<PageAuth> {
  bool _showPassword = true;
  final _emailTextControll = TextEditingController();
  final _passwordTextControll = TextEditingController();
  dynamic _imputColor = gbl.lightColor;

  bool _checkInputs() {
    // check the data from textfields and return true if they are empty
    if (_emailTextControll.text.trim().isEmpty ||
        _passwordTextControll.text.trim().isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: gbl.darkColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(gbl.backgroundImage), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 80),
                child: Text(
                  'Simple Finances',
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 3, fontSize: 60),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTextControll,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 15, letterSpacing: 3, color: gbl.lightColor),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.lightColor, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.lightColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.lightColor, width: 1),
                    ),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                        fontSize: 15, letterSpacing: 3, color: gbl.lightColor),
                    hintText: 'usuario@mail.com',
                    hintStyle: TextStyle(
                        fontSize: 10, letterSpacing: 3, color: gbl.lightColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordTextControll,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  maxLength: 6,
                  obscureText: _showPassword,
                  style: TextStyle(
                      fontSize: 15, letterSpacing: 3, color: gbl.lightColor),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                              _showPassword = !_showPassword;
                            }),
                        child: !_showPassword
                            ? Icon(
                                Icons.visibility,
                                size: 24,
                                color: gbl.lightColor,
                              )
                            : Icon(
                                Icons.visibility_off,
                                size: 24,
                                color: gbl.lightColor,
                              )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.lightColor, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.lightColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: _imputColor, width: 1),
                    ),
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                        fontSize: 15, letterSpacing: 3, color: gbl.lightColor),
                    hintText: '******',
                    hintStyle: TextStyle(
                        fontSize: 10, letterSpacing: 3, color: gbl.lightColor),
                  ),
                  onChanged: (value) {
                    if (value.length < 6) {
                      setState(() {
                        _imputColor = gbl.redMy;
                      });
                    } else {
                      setState(() {
                        _imputColor = gbl.lightColor;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: MaterialButton(
                  onPressed: () {
                    if (_checkInputs()) {
                      UiWidgets().showMessage(
                          'Confira seus dados e tente novamente.', context);
                    } else {
                      FireAuth()
                          .signInWithEmailAndPassword(
                              email: _emailTextControll.text,
                              password: _passwordTextControll.text)
                          .onError(
                            (error, stackTrace) => UiWidgets()
                                .showMessage(error.toString(), context),
                          );
                      if (kDebugMode) {
                        print(
                            '${_emailTextControll.text}, ${_passwordTextControll.text}');
                      }
                    }
                  },
                  elevation: 4,
                  color: gbl.blueMy,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  splashColor: Colors.blueGrey,
                  onLongPress: null,
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(
                        letterSpacing: 3, fontSize: 20, color: gbl.lightColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  splashColor: Colors.blueGrey,
                  child: Text(
                    'Reculperar minha senha',
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 3, color: gbl.lightColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
