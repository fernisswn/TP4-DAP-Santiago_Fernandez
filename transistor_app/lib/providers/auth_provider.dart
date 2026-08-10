import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/user.dart';

final authProvider = NotifierProvider<AuthNotifier, User?>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<User?> {
  final List<User> _users = const [
    User(
      username: 'admin',
      password: '1234',
    ),
    User(
      username: 'usuario',
      password: '1234',
    ),
    User(
      username: 'fernando',
      password: 'flutter',
    ),
  ];

  @override
  User? build() {
    return null;
  }

  bool login({
    required String username,
    required String password,
  }) {
    final user = _users.where(
      (user) =>
          user.username.toLowerCase() == username.toLowerCase() &&
          user.password == password,
    );

    if (user.isEmpty) {
      return false;
    }

    state = user.first;

    return true;
  }

  void logout() {
    state = null;
  }
}