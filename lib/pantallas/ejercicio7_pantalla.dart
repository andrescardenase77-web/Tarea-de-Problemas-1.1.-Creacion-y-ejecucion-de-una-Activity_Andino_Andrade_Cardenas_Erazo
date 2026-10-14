import 'package:flutter/material.dart';
import '../logica/ejercicio7_logica.dart';

class Ejercicio7Pantalla extends StatefulWidget {
  const Ejercicio7Pantalla({super.key});

  @override
  State<Ejercicio7Pantalla> createState() => _Ejercicio7PantallaState();
}

class _Ejercicio7PantallaState extends State<Ejercicio7Pantalla> {
  Ejercicio7Logica logica = Ejercicio7Logica();

  TextEditingController saldoAnteriorController = TextEditingController();
  TextEditingController comprasController = TextEditingController();
  TextEditingController pagoAnteriorController = TextEditingController();

  String mensajeError = '';
  bool clienteCalculado = false;

  void procesarCliente() {
    final double? saldoAnterior = double.tryParse(saldoAnteriorController.text);
    final double? compras = double.tryParse(comprasController.text);
    final double? pagoAnterior = double.tryParse(pagoAnteriorController.text);

    if (saldoAnterior == null || saldoAnterior < 0) {
      setState(() {
        mensajeError = 'Ingrese un saldo anterior válido.';
      });
      return;
    }

    if (compras == null || compras < 0) {
      setState(() {
        mensajeError = 'Ingrese un monto de compras válido.';
      });
      return;
    }

    if (pagoAnterior == null || pagoAnterior < 0) {
      setState(() {
        mensajeError = 'Ingrese un monto de pago anterior válido.';
      });
      return;
    }

    setState(() {
      mensajeError = '';
      logica.calcularCliente(saldoAnterior, compras, pagoAnterior);
      clienteCalculado = true;

      saldoAnteriorController.clear();
      comprasController.clear();
      pagoAnteriorController.clear();
    });
  }

  void reiniciar() {
    setState(() {
      logica.reiniciar();
      clienteCalculado = false;
      mensajeError = '';
      saldoAnteriorController.clear();
      comprasController.clear();
      pagoAnteriorController.clear();
    });
  }

  @override
  void dispose() {
    saldoAnteriorController.dispose();
    comprasController.dispose();
    pagoAnteriorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 7: Banco Bandido de Peluche'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Datos del Cliente:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: saldoAnteriorController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Saldo Anterior (\$)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_balance_wallet),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: comprasController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Monto de Compras (\$)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.shopping_cart),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: pagoAnteriorController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Pago en Corte Anterior (\$)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.payment),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (mensajeError.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                mensajeError,
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: procesarCliente,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calcular Cliente'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: reiniciar,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reiniciar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black87,
                  ),
                ),
              ],
            ),

            if (clienteCalculado) ...[
              const SizedBox(height: 16),
              Card(
                color: logica.esMoroso ? Colors.amber.shade50 : Colors.blue.shade50,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resultado del Cliente #${logica.totalClientes}:',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Text('• Saldo Actual: \$${logica.saldoActual.toStringAsFixed(2)}'),
                      const SizedBox(height: 4),
                      Text('• Pago Mínimo (15%): \$${logica.pagoMinimo.toStringAsFixed(2)}'),
                      const SizedBox(height: 4),
                      Text('• Pago para no generar intereses (85%): \$${logica.pagoNoIntereses.toStringAsFixed(2)}'),
                      const SizedBox(height: 4),
                      if (logica.esMoroso) ...[
                        Text(
                          '• Estado: MOROSO (No cubrió el pago mínimo)',
                          style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
                        ),
                        Text('• Interés Generado (12%): \$${logica.interes.toStringAsFixed(2)}'),
                        Text('• Multa por Morosidad: \$${logica.multa.toStringAsFixed(2)}'),
                      ] else ...[
                        const Text(
                          '• Estado: AL DÍA (Pago mínimo cumplido)',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],

            if (logica.totalClientes > 0) ...[
              const SizedBox(height: 16),
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
                      'TOTAL GANADO POR INTERESES (CLIENTES MOROSOS)',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${logica.totalInteresesMorosos.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Total clientes: ${logica.totalClientes} | Morosos: ${logica.clientesMorososCount} | Al día: ${logica.clientesAlDiaCount}',
                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
