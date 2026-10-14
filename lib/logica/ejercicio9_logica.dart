import 'dart:math';

class Ejercicio9Logica {

  final int maxIntentos = 10;
  int numeroSecreto = 0;
  int intentosUsados = 0;
  bool juegoTerminado = false;

  Ejercicio9Logica() {
    reiniciar();
  }

  int get intentosRestantes {
    return maxIntentos - intentosUsados;
  }

  String comprobar(int numero) {
    intentosUsados++;

    if (numero == numeroSecreto) {
      juegoTerminado = true;
      return '¡Acertaste! Lo lograste en $intentosUsados intento(s).';
    }

    if (intentosUsados >= maxIntentos) {
      juegoTerminado = true;
      return 'Se acabaron los intentos. El número era $numeroSecreto.';
    }

    if (numeroSecreto > numero) {
      return 'El número a adivinar es MAYOR que $numero.';
    } else {
      return 'El número a adivinar es MENOR que $numero.';
    }
  }

  void reiniciar() {
    numeroSecreto = Random().nextInt(100) + 1; // de 1 a 100
    intentosUsados = 0;
    juegoTerminado = false;
  }
}
 