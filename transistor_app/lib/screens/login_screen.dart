import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../utils/snackbar.dart';
import 'home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const name = 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      AppSnackBar.error(
        context,
        'Completá usuario y contraseña',
      );

      return;
    }

    final success = ref.read(authProvider.notifier).login(
          username: username,
          password: password,
        );

    if (!success) {
      AppSnackBar.error(
        context,
        'Usuario o contraseña incorrectos',
      );

      return;
    }

    AppSnackBar.success(
      context,
      'Inicio de sesión correcto',
    );

    context.goNamed(HomeScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.memory,
                  size: 80,
                ),
                const SizedBox(height: 24),
                Text(
                  'Transistores',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Iniciá sesión para continuar',
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Usuario o email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: login,
                    child: const Text('Iniciar sesión'),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Usuarios de prueba:\n'
                  'admin / 1234\n'
                  'usuario / 1234\n'
                  'fernando / flutter',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}