import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;
import 'package:simple_finances/config/util/app_ui_widgets.dart';

class PageAuth extends StatefulWidget {
  const PageAuth({super.key});

  @override
  State<PageAuth> createState() => _PageAuthState();
}

class _PageAuthState extends State<PageAuth> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  dynamic _imputColor = gbl.primaryLight;
  bool _isLoading = false;

  bool _checkInputs() {
    // check the data from textfields and return true if they are empty
    if (_emailTextController.text.trim().isEmpty ||
        _passwordTextController.text.trim().isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/brown_gradient.jpeg'),
              fit: BoxFit.cover),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 110),
                child: Image.asset(
                  gbl.simpleFinanceLogoFull,
                  fit: BoxFit.cover,
                  semanticLabel: 'Simple Finance Logo',
                  width: MediaQuery.of(context).size.width * .7,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTextController,
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
                  controller: _passwordTextController,
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
                      onPressed: () {
                        context.push('/login/recovery');
                      },
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
                          vertical: 16, horizontal: 16),
                      onPressed: () async {},
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
                      onPressed: () async {
                        if (_checkInputs()) {
                          UiWidgets().showMessage(
                              'Confira seus dados e tente novamente.', context);
                        } else {
                          setState(() => _isLoading = true);
                          await FireAuth()
                              .signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .onError(
                                (error, stackTrace) => UiWidgets()
                                    .showMessage(error.toString(), context),
                              )
                              .whenComplete(() {
                            context.go('/home');
                          });
                          if (kDebugMode) {
                            print(
                                '${_emailTextController.text}, ${_passwordTextController.text}');
                          }
                        }
                      },
                      elevation: 4,
                      color: gbl.primaryLight,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      splashColor: gbl.secondaryDark,
                      onLongPress: null,
                      minWidth: MediaQuery.of(context).size.width * .6,
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: gbl.primaryDark,
                            )
                          : Text(
                              'Entrar',
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
