class Ejercicio10Logica {
  int? limiteInferior;
  int? limiteSuperior;
  final List<int> numeros = [];
  bool limitesEstablecidos = false;
  bool finalizado = false;

  String? establecerLimites(int inferior, int superior) {
    if (inferior > superior) {
      return 'El límite inferior no puede ser mayor que el límite superior.';
    }
    limiteInferior = inferior;
    limiteSuperior = superior;
    limitesEstablecidos = true;
    numeros.clear();
    finalizado = false;
    return null;
  }

  bool agregarNumero(int numero) {
    if (numero == 0) {
      finalizado = true;
      return true; // Finalizó
    }
    numeros.add(numero);
    return false;
  }

  int get sumaDentro {
    if (limiteInferior == null || limiteSuperior == null) return 0;
    int suma = 0;
    for (int n in numeros) {
      if (n > limiteInferior! && n < limiteSuperior!) {
        suma += n;
      }
    }
    return suma;
  }

  int get fueraCount {
    if (limiteInferior == null || limiteSuperior == null) return 0;
    int count = 0;
    for (int n in numeros) {
      if (n <= limiteInferior! || n >= limiteSuperior!) {
        count++;
      }
    }
    return count;
  }

  bool get igualALimites {
    if (limiteInferior == null || limiteSuperior == null) return false;
    for (int n in numeros) {
      if (n == limiteInferior || n == limiteSuperior) {
        return true;
      }
    }
    return false;
  }

  void reiniciar() {
    limiteInferior = null;
    limiteSuperior = null;
    limitesEstablecidos = false;
    finalizado = false;
    numeros.clear();
  }
}
