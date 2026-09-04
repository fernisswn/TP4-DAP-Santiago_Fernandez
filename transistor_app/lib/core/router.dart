import 'package:go_router/go_router.dart';

import '../screens/detail_screen.dart';
import '../screens/form_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: LoginScreen.name,
      path: '/',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      name: RegisterScreen.name,
      path: '/register',
      builder: (context, state) {
        return const RegisterScreen();
      },
    ),
    GoRoute(
      name: HomeScreen.name,
      path: '/home',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      name: DetailScreen.name,
      path: '/detail/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;

        return DetailScreen(
          id: id,
        );
      },
    ),
    GoRoute(
      name: FormScreen.name,
      path: '/form',
      builder: (context, state) {
        final id = state.uri.queryParameters['id'];

        return FormScreen(
          id: id,
        );
      },
    ),
  ],
);