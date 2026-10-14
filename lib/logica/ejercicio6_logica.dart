class Ejercicio6Logica {

  double totalImpuestosCategoria1 = 0;
  double totalImpuestosCategoria2 = 0;
  double totalImpuestosCategoria3 = 0;
  int totalAutosCategoria1 = 0;
  int totalAutosCategoria2 = 0;
  int totalAutosCategoria3 = 0;

  double calcularImpuestoIndividual(int clave, double valor) {
    switch(clave){
      case 1:
        return valor * 0.10;
      case 2:
        return valor * 0.07;
      case 3:
        return valor * 0.05;
      default:
        return 0.0;
    }
  }

  double registrarAuto(int clave, double valor) {
    double impuesto = calcularImpuestoIndividual(clave, valor);

    switch(clave){
      case 1:
        totalAutosCategoria1++;
        totalImpuestosCategoria1 += impuesto;
        break;
      case 2:
        totalAutosCategoria2++;
        totalImpuestosCategoria2 += impuesto;
        break;
      case 3:
        totalAutosCategoria3++;
        totalImpuestosCategoria3 += impuesto;
        break;
    }
    return impuesto;
  }

  double obtenerTotalGeneral() {
    return totalImpuestosCategoria1 + totalImpuestosCategoria2 + totalImpuestosCategoria3;
  }

  void reiniciar() {
    totalImpuestosCategoria1 = 0;
    totalImpuestosCategoria2 = 0;
    totalImpuestosCategoria3 = 0;
    totalAutosCategoria1 = 0;
    totalAutosCategoria2 = 0;
    totalAutosCategoria3 = 0;
  }
}