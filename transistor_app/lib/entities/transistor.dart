class Transistor {
  final String id;
  final String titulo;
  final String descripcion;
  final String imagen;
  final String tipo;
  final String aplicacion;

  const Transistor({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.imagen,
    required this.tipo,
    required this.aplicacion,
  });

  Transistor copyWith({
    String? id,
    String? titulo,
    String? descripcion,
    String? imagen,
    String? tipo,
    String? aplicacion,
  }) {
    return Transistor(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      imagen: imagen ?? this.imagen,
      tipo: tipo ?? this.tipo,
      aplicacion: aplicacion ?? this.aplicacion,
    );
  }
}