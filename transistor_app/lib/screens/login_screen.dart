import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../utils/snackbar.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const name = 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  String? validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresá tu email';
    }

    final emailRegex = RegExp(r'^[\w\.\-]+@[\w\-]+\.[\w\-\.]+$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Ingresá un email válido';
    }

    return null;
  }

  String? validarPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresá tu contraseña';
    }

    return null;
  }

  void login() {
    final esValido = formKey.currentState?.validate() ?? false;

    if (!esValido) {
      return;
    }

    final success = ref.read(authProvider.notifier).login(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

    if (!success) {
      AppSnackBar.error(
        context,
        'Email o contraseña incorrectos',
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
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: validarEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    validator: validarPassword,
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
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(RegisterScreen.name);
                    },
                    child: const Text('¿No tenés cuenta? Registrate'),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Usuarios de prueba:\n'
                    'admin@demo.com / 1234\n'
                    'usuario@demo.com / 1234\n'
                    'fernando@demo.com / flutter',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
