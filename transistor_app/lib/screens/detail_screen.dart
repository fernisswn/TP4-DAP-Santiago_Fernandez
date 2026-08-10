import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/transistor_provider.dart';
import '../utils/snackbar.dart';
import 'form_screen.dart';

class DetailScreen extends ConsumerWidget {
  static const name = 'detail';

  final String id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  void deleteTransistor(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref
        .read(transistorProvider.notifier)
        .deleteTransistor(id);

    AppSnackBar.success(
      context,
      'Transistor eliminado correctamente',
    );

    context.pop();
  }

  void showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Eliminar transistor',
          ),
          content: const Text(
            '¿Estás seguro de que querés eliminar este transistor?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                context.pop();

                deleteTransistor(
                  context,
                  ref,
                );
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final transistor = ref
        .watch(transistorProvider.notifier)
        .getTransistor(id);

    if (transistor == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle'),
        ),
        body: const Center(
          child: Text(
            'No se encontró el transistor',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(transistor.titulo),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(
                FormScreen.name,
                queryParameters: {
                'id': transistor.id,
                },
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDeleteDialog(
                context,
                ref,
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(12),
                child: Image.asset(
                  transistor.imagen,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return const SizedBox(
                      width: double.infinity,
                      height: 240,
                      child: Icon(
                        Icons.memory,
                        size: 100,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text(
                transistor.titulo,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall,
              ),
              const SizedBox(height: 16),
              _InfoRow(
                titulo: 'Tipo',
                valor: transistor.tipo,
              ),
              const SizedBox(height: 12),
              _InfoRow(
                titulo: 'Aplicación',
                valor: transistor.aplicacion,
              ),
              const SizedBox(height: 24),
              Text(
                'Descripción',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                transistor.descripcion,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.pushNamed(
                         FormScreen.name,
                          queryParameters: {
                           'id': transistor.id,
                         },
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Editar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        showDeleteDialog(
                          context,
                          ref,
                        );
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Eliminar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String titulo;
  final String valor;

  const _InfoRow({
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(valor),
        ),
      ],
    );
  }
}