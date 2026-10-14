import 'package:flutter/material.dart';
import '../logica/ejercicio8_logica.dart';

class Ejercicio8Pantalla extends StatefulWidget {
  const Ejercicio8Pantalla({super.key});

  @override
  State<Ejercicio8Pantalla> createState() => _Ejercicio8PantallaState();
}

class _Ejercicio8PantallaState extends State<Ejercicio8Pantalla> {
  Ejercicio8Logica logica = Ejercicio8Logica();

  TextEditingController depositoController = TextEditingController();

  String mensajeError = '';

  void registrarDeposito() {
    final double? deposito = double.tryParse(depositoController.text);

    if (deposito == null || deposito <= 0) {
      setState(() {
        mensajeError = 'Ingrese una cantidad válida mayor a 0.';
      });
      return;
    }

    setState(() {
      mensajeError = '';
      logica.registrarDeposito(deposito);
      depositoController.clear();
    });
  }

  void reiniciar() {
    setState(() {
      logica.reiniciar();
      depositoController.clear();
      mensajeError = '';
    });
  }

  @override
  void dispose() {
    depositoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 8: Control de Ahorro Anual'),
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
                    Text(
                      logica.anoCompletado
                          ? '¡Año de ahorro completado!'
                          : 'Mes ${logica.mesActual} de 12: ${logica.nombreMesActual}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: depositoController,
                      enabled: !logica.anoCompletado,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: logica.anoCompletado
                            ? 'Ahorro completo'
                            : 'Monto a depositar en ${logica.nombreMesActual} (\$)',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.savings),
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
                    onPressed: logica.anoCompletado ? null : registrarDeposito,
                    icon: const Icon(Icons.add_circle),
                    label: const Text('Depositar Mes'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: reiniciar,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reiniciar Año'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (logica.depositosMeses.isNotEmpty) ...[
              const Text(
                'Ahorro acumulado mes a mes:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 2,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: logica.depositosMeses.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final int mesNum = index + 1;
                    final String nombreMes = logica.nombresMeses[index];
                    final double deposito = logica.depositosMeses[index];
                    final double acumulado = logica.acumuladosMeses[index];

                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          '$mesNum',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      title: Text(
                        'Mes $mesNum ($nombreMes)',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Depósito del mes: \$${deposito.toStringAsFixed(2)}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Acumulado',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          Text(
                            '\$${acumulado.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],

            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: logica.anoCompletado ? Colors.green.shade100 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: logica.anoCompletado ? Colors.green : Colors.blue,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    logica.anoCompletado
                        ? 'TOTAL AHORRADO EN EL AÑO'
                        : 'AHORRO ACUMULADO HASTA AHORA',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: logica.anoCompletado ? Colors.green : Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${logica.ahorroTotal.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: logica.anoCompletado ? Colors.green : Colors.blue,
                    ),
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
