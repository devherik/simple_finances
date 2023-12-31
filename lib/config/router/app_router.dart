import 'package:go_router/go_router.dart';
import 'package:simple_finances/features/authentication/page_auth.dart';
import 'package:simple_finances/features/home/page_home.dart';
import 'package:simple_finances/features/welcome/page_welcome.dart';
import 'package:simple_finances/widget_tree.dart';

class AppRouter {
  final router = GoRouter(routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const PageAuth(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const PageHome(),
    ),
    GoRoute(
      path: '/widgettree',
      builder: (context, state) => const WidgetTree(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const PageWelcome(),
    )
  ], initialLocation: '/widgettree');
}
