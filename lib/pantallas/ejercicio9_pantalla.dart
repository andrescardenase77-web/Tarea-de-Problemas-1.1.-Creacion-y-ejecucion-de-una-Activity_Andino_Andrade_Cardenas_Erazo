import 'package:flutter/material.dart';
import '../logica/ejercicio9_logica.dart';

class Ejercicio9Pantalla extends StatefulWidget {
  const Ejercicio9Pantalla({super.key});

  @override
  State<Ejercicio9Pantalla> createState() => _Ejercicio9PantallaState();
}

class _Ejercicio9PantallaState extends State<Ejercicio9Pantalla> {
  Ejercicio9Logica logica = Ejercicio9Logica();

  TextEditingController numeroController = TextEditingController();

  String mensaje = '';
  String mensajeError = '';

  void comprobar() {
    final int? numero = int.tryParse(numeroController.text);

    if (numero == null || numero < 1 || numero > 100) {
      setState(() {
        mensajeError = 'Ingrese un número válido entre 1 y 100.';
      });
      return;
    }

    setState(() {
      mensajeError = '';
      mensaje = logica.comprobar(numero);
      numeroController.clear();
    });
  }

  void nuevaPartida() {
    setState(() {
      logica.reiniciar();
      mensaje = '';
      mensajeError = '';
      numeroController.clear();
    });
  }

  @override
  void dispose() {
    numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 9: Adivina el Número'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'He pensado un número del 1 al 100. ¡Tienes 10 intentos!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: numeroController,
              enabled: !logica.juegoTerminado,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tu número',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.casino),
              ),
            ),

            if (mensajeError.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                mensajeError,
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: logica.juegoTerminado ? null : comprobar,
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Comprobar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: nuevaPartida,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Nueva'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Card(
              color: Colors.blue.shade50,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  'Intentos restantes: ${logica.intentosRestantes}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 14),

            if (mensaje.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: Text(
                  mensaje,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}