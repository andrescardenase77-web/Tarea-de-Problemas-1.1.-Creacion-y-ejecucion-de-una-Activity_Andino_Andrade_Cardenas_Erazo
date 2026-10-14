import 'package:flutter/material.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu de Ejercicios'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seleccione un Ejercicio:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Ejercicio 6
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/ejercicio6');
              },
              icon: const Icon(Icons.directions_car),
              label: const Text('Ejercicio 6: Impuesto Automotriz'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.centerLeft,
              ),
            ),
            const SizedBox(height: 12),

            // Ejercicio 7: Banco Bandido de peluche
            ElevatedButton.icon(
              onPressed: () {
                // Navigator.pushNamed(context, '/ejercicio7');
              },
              icon: const Icon(Icons.account_balance),
              label: const Text('Ejercicio 7: Banco "Bandido de Peluche"'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.centerLeft,
              ),
            ),
            const SizedBox(height: 12),

            // Ejercicio 8: Ahorro Anual
            ElevatedButton.icon(
              onPressed: () {
                // Navigator.pushNamed(context, '/ejercicio8');
              },
              icon: const Icon(Icons.savings),
              label: const Text('Ejercicio 8: Control de Ahorro Anual'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.centerLeft,
              ),
            ),
            const SizedBox(height: 12),

            // Ejercicio 9: Adivinar el Número
            ElevatedButton.icon(
              onPressed: () {
                // Navigator.pushNamed(context, '/ejercicio9');
              },
              icon: const Icon(Icons.casino),
              label: const Text('Ejercicio 9: Juego Adivinar Número'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.centerLeft,
              ),
            ),
            const SizedBox(height: 12),

            // Ejercicio 10: Intervalo Numérico
            ElevatedButton.icon(
              onPressed: () {
                // Navigator.pushNamed(context, '/ejercicio10');
              },
              icon: const Icon(Icons.linear_scale),
              label: const Text('Ejercicio 10: Análisis de Intervalos'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}