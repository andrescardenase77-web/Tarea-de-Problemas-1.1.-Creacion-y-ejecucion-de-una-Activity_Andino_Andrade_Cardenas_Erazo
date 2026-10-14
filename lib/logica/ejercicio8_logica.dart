class Ejercicio8Logica {
  List<double> depositosMeses = [];
  List<double> acumuladosMeses = [];

  List<String> nombresMeses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  int get mesActual => depositosMeses.length + 1;
  bool get anoCompletado => depositosMeses.length >= 12;

  String get nombreMesActual {
    if (anoCompletado) return 'Año Completado';
    return nombresMeses[depositosMeses.length];
  }

  double get ahorroTotal {
    if (acumuladosMeses.isEmpty) return 0.0;
    return acumuladosMeses.last;
  }

  void registrarDeposito(double monto) {
    if (anoCompletado) return;

    double acumuladoAnterior = ahorroTotal;
    double nuevoAcumulado = acumuladoAnterior + monto;

    depositosMeses.add(monto);
    acumuladosMeses.add(nuevoAcumulado);
  }

  void reiniciar() {
    depositosMeses.clear();
    acumuladosMeses.clear();
  }
}
