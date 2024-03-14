import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageWelcome extends StatelessWidget {
  const PageWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .6,
                margin: const EdgeInsets.only(bottom: 25),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(gbl.backgroundImage),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      'Organize sua vida financeira de forma simples e prática. \n ',
                      style: TextStyle(
                          fontSize: 30,
                          color: gbl.primaryLight,
                          letterSpacing: 3),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 18),
                      onPressed: () {
                        context.go('/login');
                      },
                      elevation: 4,
                      color: gbl.primaryLight,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.arrow_forward,
                        color: gbl.primaryDark,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
