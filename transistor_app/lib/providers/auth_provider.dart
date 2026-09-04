import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/user.dart';

final authProvider = NotifierProvider<AuthNotifier, User?>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<User?> {
  final List<User> _usuarios = [
    const User(
      id: '1',
      nombre: 'Administrador',
      email: 'admin@demo.com',
      password: '1234',
    ),
    const User(
      id: '2',
      nombre: 'Usuario de prueba',
      email: 'usuario@demo.com',
      password: '1234',
    ),
    const User(
      id: '3',
      nombre: 'Fernando',
      email: 'fernando@demo.com',
      password: 'flutter',
    ),
  ];

  @override
  User? build() {
    return null;
  }

  /// Intenta iniciar sesión con [email] y [password].
  /// Devuelve `true` si las credenciales son correctas.
  bool login({
    required String email,
    required String password,
  }) {
    final coincidencias = _usuarios.where(
      (usuario) =>
          usuario.email.toLowerCase() == email.toLowerCase() &&
          usuario.password == password,
    );

    if (coincidencias.isEmpty) {
      return false;
    }

    state = coincidencias.first;

    return true;
  }

  /// Registra un nuevo usuario y lo deja logueado.
  /// Devuelve un mensaje de error, o `null` si el registro fue exitoso.
  String? register({
    required String nombre,
    required String email,
    required String password,
  }) {
    final emailYaRegistrado = _usuarios.any(
      (usuario) => usuario.email.toLowerCase() == email.toLowerCase(),
    );

    if (emailYaRegistrado) {
      return 'Ya existe una cuenta registrada con ese email';
    }

    final nuevoUsuario = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nombre: nombre,
      email: email,
      password: password,
    );

    _usuarios.add(nuevoUsuario);

    state = nuevoUsuario;

    return null;
  }

  void logout() {
    state = null;
  }
}
