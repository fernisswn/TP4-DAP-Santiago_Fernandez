import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../providers/transistor_provider.dart';
import '../utils/snackbar.dart';
import 'detail_screen.dart';
import 'form_screen.dart';
import 'login_screen.dart';

class HomeScreen extends ConsumerWidget {
  static const name = 'home';

  const HomeScreen({super.key});

  void logout(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.read(authProvider.notifier).logout();

    AppSnackBar.info(
      context,
      'Sesión cerrada',
    );

    context.pushNamed(FormScreen.name);
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final transistores = ref.watch(transistorProvider);
    final user = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transistores'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context, ref);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: transistores.isEmpty
            ? const Center(
                child: Text(
                  'No hay transistores cargados',
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: transistores.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  final transistor = transistores[index];

                  return Card(
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(8),
                        child: Image.asset(
                          transistor.imagen,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return const SizedBox(
                              width: 70,
                              height: 70,
                              child: Icon(
                                Icons.memory,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        transistor.titulo,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        transistor.tipo,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      onTap: () {
                        context.pushNamed(
                          FormScreen.name,
                           queryParameters: {
                           'id': transistor.id,
                          },
                        );
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(FormScreen.name);
        },
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),
    );
  }
}