import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_finances/config/database/firebase/app_fireauth_db.dart';
import 'package:simple_finances/config/usecases/dao_goals.dart';
import 'package:simple_finances/features/navigation_bar/business/widgets_goals.dart';
import 'package:simple_finances/config/util/app_globals.dart' as gbl;

class PageBusiness extends StatefulWidget {
  const PageBusiness({super.key});

  @override
  State<PageBusiness> createState() => _PageBusinessState();
}

class _PageBusinessState extends State<PageBusiness> {
  FireAuth? _auth;
  DaoGoal? _daoGoal;
  WidgetGoals? wGoal;

  @override
  void initState() {
    _daoGoal = DaoGoal();
    wGoal = WidgetGoals(context: context);
    _auth = FireAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.1),
        centerTitle: false,
        title: GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: gbl.primaryLight,
              ),
              Text(
                _auth!.currentUser!.email!,
                style: TextStyle(
                    color: gbl.primaryLight, fontSize: 12, letterSpacing: 3),
              )
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            splashColor: gbl.primaryDark,
            child: Icon(
              Icons.settings,
              color: gbl.primaryLight,
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/brown_gradient.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
