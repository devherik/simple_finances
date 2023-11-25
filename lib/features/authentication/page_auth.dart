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
  final _emailTextControll = TextEditingController();
  final _passwordTextControll = TextEditingController();
  dynamic _imputColor = gbl.primaryLight;

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
        color: gbl.primaryDark,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Text(
                  'Simple Finances',
                  style: TextStyle(
                      color: gbl.primaryLight, letterSpacing: 3, fontSize: 60),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTextControll,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 15, letterSpacing: 3, color: gbl.primaryLight),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.primaryLight, width: 1),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.primaryLight, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.primaryLight, width: 1),
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
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordTextControll,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  maxLength: 6,
                  obscureText: true,
                  style: TextStyle(
                      fontSize: 15, letterSpacing: 3, color: gbl.primaryLight),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    suffixIcon: MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      splashColor: Colors.transparent,
                      child: Text(
                        '| Esqueceu?',
                        style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 3,
                            color: gbl.primaryLight),
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.primaryLight, width: 1),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: gbl.primaryLight, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: _imputColor, width: 1),
                    ),
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 3,
                        color: gbl.primaryLight),
                    hintText: '******',
                    hintStyle: TextStyle(
                        fontSize: 10,
                        letterSpacing: 3,
                        color: gbl.primaryLight),
                  ),
                  onChanged: (value) {
                    if (value.length < 6) {
                      setState(() {
                        _imputColor = gbl.baseRed;
                      });
                    } else {
                      setState(() {
                        _imputColor = gbl.primaryLight;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 18),
                      onPressed: () {},
                      elevation: 4,
                      color: gbl.secondaryDark,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset(
                        'assets/logos/google_logo.png',
                        fit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
                    MaterialButton(
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
                      color: gbl.primaryLight,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      splashColor: gbl.secondaryDark,
                      onLongPress: null,
                      minWidth: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(
                            letterSpacing: 3,
                            fontSize: 20,
                            color: gbl.primaryDark),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'Code Spellcaster Studio',
                  style: TextStyle(
                      color: gbl.secondaryLight,
                      fontSize: 10,
                      letterSpacing: 4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
