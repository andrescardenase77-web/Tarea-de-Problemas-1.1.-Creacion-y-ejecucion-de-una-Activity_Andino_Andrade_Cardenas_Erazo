import 'package:flutter/material.dart';
import '../logica/ejercicio10_logica.dart';

class Ejercicio10Pantalla extends StatefulWidget {
  const Ejercicio10Pantalla({super.key});

  @override
  State<Ejercicio10Pantalla> createState() => _Ejercicio10PantallaState();
}

class _Ejercicio10PantallaState extends State<Ejercicio10Pantalla> {
  final Ejercicio10Logica logica = Ejercicio10Logica();

  final TextEditingController inferiorController = TextEditingController();
  final TextEditingController superiorController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();

  String mensajeError = '';

  void guardarLimites() {
    final int? inf = int.tryParse(inferiorController.text);
    final int? sup = int.tryParse(superiorController.text);

    if (inf == null || sup == null) {
      setState(() {
        mensajeError = 'Ingrese valores numéricos válidos para ambos límites.';
      });
      return;
    }

    final String? error = logica.establecerLimites(inf, sup);
    setState(() {
      if (error != null) {
        mensajeError = '$error Vuelva a ingresarlos.';
      } else {
        mensajeError = '';
      }
    });
  }

  void agregarNumero() {
    final int? num = int.tryParse(numeroController.text);

    if (num == null) {
      setState(() {
        mensajeError = 'Ingrese un número entero válido.';
      });
      return;
    }

    setState(() {
      mensajeError = '';
      logica.agregarNumero(num);
      numeroController.clear();
    });
  }

  void reiniciar() {
    setState(() {
      logica.reiniciar();
      inferiorController.clear();
      superiorController.clear();
      numeroController.clear();
      mensajeError = '';
    });
  }

  @override
  void dispose() {
    inferiorController.dispose();
    superiorController.dispose();
    numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 10: Análisis de Intervalo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sección de Límites
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. Configurar Límites del Intervalo',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: inferiorController,
                            enabled: !logica.limitesEstablecidos,
                            keyboardType: const TextInputType.numberWithOptions(signed: true),
                            decoration: const InputDecoration(
                              labelText: 'Límite Inferior',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: superiorController,
                            enabled: !logica.limitesEstablecidos,
                            keyboardType: const TextInputType.numberWithOptions(signed: true),
                            decoration: const InputDecoration(
                              labelText: 'Límite Superior',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (!logica.limitesEstablecidos)
                      ElevatedButton.icon(
                        onPressed: guardarLimites,
                        icon: const Icon(Icons.check),
                        label: const Text('Establecer Límites'),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Intervalo abierto configurado: (${logica.limiteInferior}, ${logica.limiteSuperior})',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            if (mensajeError.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                mensajeError,
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],

            const SizedBox(height: 16),

            // Sección de Ingreso de Números
            if (logica.limitesEstablecidos && !logica.finalizado) ...[
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '2. Introducir Números (Ingrese 0 para terminar)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: numeroController,
                              keyboardType: const TextInputType.numberWithOptions(signed: true),
                              decoration: const InputDecoration(
                                labelText: 'Número',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: agregarNumero,
                            icon: const Icon(Icons.add),
                            label: const Text('Agregar'),
                          ),
                        ],
                      ),
                      if (logica.numeros.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Números ingresados: ${logica.numeros.join(", ")}',
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],

            // Resumen de Resultados al terminar con 0
            if (logica.finalizado) ...[
              Card(
                color: Colors.green.shade50,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resultados Finales del Análisis:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      const Divider(),
                      Text(
                        '• Suma de números dentro del intervalo (${logica.limiteInferior}, ${logica.limiteSuperior}): ${logica.sumaDentro}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• Números fuera del intervalo: ${logica.fueraCount}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• ¿Se introdujo algún número igual a los límites?: ${logica.igualALimites ? "Sí" : "No"}',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: reiniciar,
              icon: const Icon(Icons.refresh),
              label: const Text('Reiniciar Ejercicio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
