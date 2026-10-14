import 'package:flutter/material.dart';
import '../logica/ejercicio6_logica.dart';

class Ejercicio6Pantalla extends StatefulWidget {
  const Ejercicio6Pantalla({super.key});

  @override
  State<Ejercicio6Pantalla> createState() => _Ejercicio6PantallaState();
}

class _Ejercicio6PantallaState extends State<Ejercicio6Pantalla> {
  Ejercicio6Logica logica = Ejercicio6Logica();

  TextEditingController valorController = TextEditingController();
  int claveSeleccionada = 1;

  double ultimoImpuesto = 0.0;
  String mensajeError = '';

  void procesarRegistro() {
    final double? valor = double.tryParse(valorController.text);

    if (valor == null || valor <= 0) {
      setState(() {
        mensajeError = 'Por favor, ingrese un valor válido mayor a 0.';
      });
      return;
    }

    setState(() {
      mensajeError = '';
      ultimoImpuesto = logica.registrarAuto(claveSeleccionada, valor);
      valorController.clear();
    });
  }

  void limpiar() {
    setState(() {
      logica.reiniciar();
      ultimoImpuesto = 0.0;
      valorController.clear();
      mensajeError = '';
    });
  }

  @override
  void dispose() {
    valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 6: Impuesto Automotriz'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<int>(
              initialValue: claveSeleccionada,
              decoration: const InputDecoration(
                labelText: 'Clave del Vehículo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.vpn_key),
              ),
              items: const [
                DropdownMenuItem(value: 1, child: Text('Clave 1 (Impuesto 10%)')),
                DropdownMenuItem(value: 2, child: Text('Clave 2 (Impuesto 7%)')),
                DropdownMenuItem(value: 3, child: Text('Clave 3 (Impuesto 5%)')),
              ],
              onChanged: (int? nuevoValor) {
                if (nuevoValor != null) {
                  setState(() {
                    claveSeleccionada = nuevoValor;
                  });
                }
              },
            ),
            const SizedBox(height: 14),

            TextField(
              controller: valorController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor del Automóvil (\$)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
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
                    onPressed: procesarRegistro,
                    icon: const Icon(Icons.add_circle),
                    label: const Text('Registrar Auto'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: limpiar,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Limpiar'),
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
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Último impuesto calculado: \$${ultimoImpuesto.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 14),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resumen por Categorías:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Text('• Clave 1 (10%): ${logica.totalAutosCategoria1} autos | Total: \$${logica.totalImpuestosCategoria1.toStringAsFixed(2)}'),
                    const SizedBox(height: 6),
                    Text('• Clave 2 (7%):  ${logica.totalAutosCategoria2} autos | Total: \$${logica.totalImpuestosCategoria2.toStringAsFixed(2)}'),
                    const SizedBox(height: 6),
                    Text('• Clave 3 (5%):  ${logica.totalAutosCategoria3} autos | Total: \$${logica.totalImpuestosCategoria3.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                children: [
                  const Text(
                    'TOTAL GENERAL A PAGAR',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${logica.obtenerTotalGeneral().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}