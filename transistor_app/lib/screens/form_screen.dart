import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../entities/transistor.dart';
import '../providers/transistor_provider.dart';
import '../utils/snackbar.dart';

class FormScreen extends ConsumerStatefulWidget {
  static const name = 'form';

  final String? id;

  const FormScreen({
    super.key,
    this.id,
  });

  @override
  ConsumerState<FormScreen> createState() =>
      _FormScreenState();
}

class _FormScreenState
    extends ConsumerState<FormScreen> {
  final tituloController = TextEditingController();
  final descripcionController =
      TextEditingController();
  final imagenController = TextEditingController();
  final tipoController = TextEditingController();
  final aplicacionController =
      TextEditingController();

  bool get isEditing => widget.id != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      final transistor = ref
          .read(transistorProvider.notifier)
          .getTransistor(widget.id!);

      if (transistor != null) {
        tituloController.text =
            transistor.titulo;
        descripcionController.text =
            transistor.descripcion;
        imagenController.text =
            transistor.imagen;
        tipoController.text =
            transistor.tipo;
        aplicacionController.text =
            transistor.aplicacion;
      }
    }
  }

  @override
  void dispose() {
    tituloController.dispose();
    descripcionController.dispose();
    imagenController.dispose();
    tipoController.dispose();
    aplicacionController.dispose();

    super.dispose();
  }

  void save() {
    final titulo =
        tituloController.text.trim();
    final descripcion =
        descripcionController.text.trim();
    final imagen =
        imagenController.text.trim();
    final tipo =
        tipoController.text.trim();
    final aplicacion =
        aplicacionController.text.trim();

    if (titulo.isEmpty ||
        descripcion.isEmpty ||
        imagen.isEmpty ||
        tipo.isEmpty ||
        aplicacion.isEmpty) {
      AppSnackBar.error(
        context,
        'Completá todos los campos',
      );

      return;
    }

    if (isEditing) {
      final transistor = Transistor(
        id: widget.id!,
        titulo: titulo,
        descripcion: descripcion,
        imagen: imagen,
        tipo: tipo,
        aplicacion: aplicacion,
      );

      ref
          .read(transistorProvider.notifier)
          .updateTransistor(transistor);

      AppSnackBar.success(
        context,
        'Transistor actualizado correctamente',
      );
    } else {
      final transistor = Transistor(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        titulo: titulo,
        descripcion: descripcion,
        imagen: imagen,
        tipo: tipo,
        aplicacion: aplicacion,
      );

      ref
          .read(transistorProvider.notifier)
          .addTransistor(transistor);

      AppSnackBar.success(
        context,
        'Transistor agregado correctamente',
      );
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? 'Editar transistor'
              : 'Nuevo transistor',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: tipoController,
                decoration: const InputDecoration(
                  labelText: 'Tipo de transistor',
                  border: OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.category),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: aplicacionController,
                decoration: const InputDecoration(
                  labelText: 'Aplicación',
                  border: OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.settings),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: imagenController,
                decoration: const InputDecoration(
                  labelText:
                      'Ruta de la imagen',
                  hintText:
                      'assets/images/mi_transistor.png',
                  border: OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.image),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller:
                    descripcionController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  prefixIcon:
                      Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: save,
                  icon: Icon(
                    isEditing
                        ? Icons.save
                        : Icons.add,
                  ),
                  label: Text(
                    isEditing
                        ? 'Guardar cambios'
                        : 'Agregar transistor',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}