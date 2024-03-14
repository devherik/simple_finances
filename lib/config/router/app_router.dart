import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_finances/features/authentication/page_auth.dart';
import 'package:simple_finances/features/authentication/page_recovery.dart';
import 'package:simple_finances/features/navigation_bar/business/page_business.dart';
import 'package:simple_finances/features/navigation_bar/finance/page_cashflow.dart';
import 'package:simple_finances/features/navigation_bar/page_navigation_bar.dart';
import 'package:simple_finances/features/navigation_bar/transaction/page_transactions.dart';
import 'package:simple_finances/features/page_home.dart';
import 'package:simple_finances/features/welcome/page_welcome.dart';
import 'package:simple_finances/widget_tree.dart';

class AppRouter {
  final router = GoRouter(routes: [
    GoRoute(
      path: '/widgettree',
      builder: (context, state) => const WidgetTree(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const PageHome(),
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PageNavigationBar(child: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/cashflow',
              name: 'cashflow',
              builder: (context, state) => const PageCashflow(),
            )
          ]),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/new_transaction',
              name: 'new_transaction',
              builder: (context, state) => const PageNewTransaction(),
            )
          ]),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/business',
              name: 'business',
              builder: (context, state) => const PageBusiness(),
            )
          ])
        ]),
    GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
              child: const PageAuth(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
        routes: <RouteBase>[
          GoRoute(
            path: 'recovery',
            name: 'recovery',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              child: const PageRecovery(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ]),
    GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const PageWelcome())
  ], initialLocation: '/widgettree');
}
