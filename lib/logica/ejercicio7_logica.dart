class Ejercicio7Logica {
  double saldoAnterior = 0.0;
  double montoCompras = 0.0;
  double pagoAnterior = 0.0;

  double saldoActual = 0.0;
  double pagoMinimo = 0.0;
  double pagoNoIntereses = 0.0;
  double interes = 0.0;
  double multa = 0.0;
  bool esMoroso = false;

  double totalInteresesMorosos = 0.0;
  int clientesMorososCount = 0;
  int clientesAlDiaCount = 0;
  int totalClientes = 0;

  void calcularCliente(double saldoAnt, double compras, double pagoAnt) {
    saldoAnterior = saldoAnt;
    montoCompras = compras;
    pagoAnterior = pagoAnt;

    double pagoMinimoAnterior = saldoAnterior * 0.15;
    esMoroso = pagoAnterior < pagoMinimoAnterior;

    if (esMoroso) {
      interes = saldoAnterior * 0.12;
      multa = 200.0;
      totalInteresesMorosos += interes;
      clientesMorososCount++;
    } else {
      interes = 0.0;
      multa = 0.0;
      clientesAlDiaCount++;
    }

    saldoActual = saldoAnterior + montoCompras - pagoAnterior + interes + multa;
    pagoMinimo = saldoActual * 0.15;
    pagoNoIntereses = saldoActual * 0.85;

    totalClientes++;
  }

  void reiniciar() {
    saldoAnterior = 0.0;
    montoCompras = 0.0;
    pagoAnterior = 0.0;
    saldoActual = 0.0;
    pagoMinimo = 0.0;
    pagoNoIntereses = 0.0;
    interes = 0.0;
    multa = 0.0;
    esMoroso = false;
    totalInteresesMorosos = 0.0;
    clientesMorososCount = 0;
    clientesAlDiaCount = 0;
    totalClientes = 0;
  }
}
