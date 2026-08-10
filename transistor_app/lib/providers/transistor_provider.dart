import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/transistor.dart';

final transistorProvider =
    NotifierProvider<TransistorNotifier, List<Transistor>>(
  TransistorNotifier.new,
);

class TransistorNotifier extends Notifier<List<Transistor>> {
  @override
  List<Transistor> build() {
    return [
      const Transistor(
        id: '1',
        titulo: 'Transistor BJT',
        descripcion:
            'El transistor BJT es un dispositivo semiconductor formado por tres regiones: emisor, base y colector. Puede utilizarse como amplificador o como interruptor electrónico.',
        imagen: 'assets/images/bjt.png',
        tipo: 'BJT',
        aplicacion: 'Amplificación y conmutación',
      ),
      const Transistor(
        id: '2',
        titulo: 'Transistor NPN',
        descripcion:
            'El transistor NPN está formado por una región tipo P ubicada entre dos regiones tipo N. Es uno de los transistores más utilizados en circuitos electrónicos.',
        imagen: 'assets/images/npn.png',
        tipo: 'NPN',
        aplicacion: 'Conmutación y amplificación',
      ),
      const Transistor(
        id: '3',
        titulo: 'Transistor PNP',
        descripcion:
            'El transistor PNP está formado por una región tipo N ubicada entre dos regiones tipo P. Su funcionamiento es complementario al del transistor NPN.',
        imagen: 'assets/images/pnp.png',
        tipo: 'PNP',
        aplicacion: 'Conmutación y amplificación',
      ),
      const Transistor(
        id: '4',
        titulo: 'MOSFET',
        descripcion:
            'El MOSFET es un transistor de efecto de campo controlado mediante tensión. Se utiliza ampliamente en fuentes de alimentación, electrónica digital y control de motores.',
        imagen: 'assets/images/mosfet.png',
        tipo: 'FET',
        aplicacion: 'Potencia y electrónica digital',
      ),
    ];
  }

  void addTransistor(Transistor transistor) {
    state = [
      ...state,
      transistor,
    ];
  }

  void updateTransistor(Transistor transistor) {
    state = [
      for (final item in state)
        if (item.id == transistor.id) transistor else item,
    ];
  }

  void deleteTransistor(String id) {
    state = [
      for (final item in state)
        if (item.id != id) item,
    ];
  }

  Transistor? getTransistor(String id) {
    for (final transistor in state) {
      if (transistor.id == id) {
        return transistor;
      }
    }

    return null;
  }
}