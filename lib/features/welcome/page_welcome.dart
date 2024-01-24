import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageWelcome extends StatelessWidget {
  const PageWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gbl.primaryDark,
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(gbl.backgroundImage), fit: BoxFit.cover),
        ),
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: MaterialButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
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
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Organize sua vida financeira de forma simples e prática. \n ',
                style: TextStyle(
                    fontSize: 30, color: gbl.primaryLight, letterSpacing: 3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
