import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Código de Colores de Resistencias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResistorCalculatorPage(),
    );
  }
}

class ResistorCalculatorPage extends StatefulWidget {
  @override
  _ResistorCalculatorPageState createState() => _ResistorCalculatorPageState();
}

class _ResistorCalculatorPageState extends State<ResistorCalculatorPage> {
  String banda1 = 'Rojo';
  String banda2 = 'Verde';
  String banda3 = 'Negro'; // Para resistencias de 5 o 6 bandas
  String multiplicador = 'Amarillo';
  String tolerancia = 'Oro';
  String bandaTemperatura = 'Negro'; // Solo para 6 bandas
  int? valorResistencia;
  double? valorTolerancia;
  int numeroBandas = 4; // Valor por defecto para 4 bandas

  final Map<String, int> valoresColor = {
    'Negro': 0,
    'Marrón': 1,
    'Rojo': 2,
    'Naranja': 3,
    'Amarillo': 4,
    'Verde': 5,
    'Azul': 6,
    'Violeta': 7,
    'Gris': 8,
    'Blanco': 9,
  };

  final Map<String, double> valoresMultiplicador = {
    'Negro': 1,
    'Marrón': 10,
    'Rojo': 100,
    'Naranja': 1000,
    'Amarillo': 10000,
    'Verde': 100000,
    'Azul': 1000000,
    'Violeta': 10000000,
    'Gris': 100000000,
    'Blanco': 1000000000,
    'Oro': 0.1,
    'Plata': 0.01,
  };

  final Map<String, double> valoresTolerancia = {
    'Marrón': 1,
    'Rojo': 2,
    'Verde': 0.5,
    'Azul': 0.25,
    'Violeta': 0.1,
    'Gris': 0.05,
    'Oro': 5,
    'Plata': 10,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Código de Colores de Resistencias'),
      ),
      body: Container(
        color: Colors.green[100], // Fondo verde claro
        child: SingleChildScrollView(
          child: Center( // Envuelve el Column dentro de un Center
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    'Selecciona el número de bandas',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 4,
                        groupValue: numeroBandas,
                        onChanged: (int? value) {
                          setState(() {
                            numeroBandas = value!;
                          });
                        },
                      ),
                      Text('4 bandas'),
                      Radio(
                        value: 5,
                        groupValue: numeroBandas,
                        onChanged: (int? value) {
                          setState(() {
                            numeroBandas = value!;
                          });
                        },
                      ),
                      Text('5 bandas'),
                      Radio(
                        value: 6,
                        groupValue: numeroBandas,
                        onChanged: (int? value) {
                          setState(() {
                            numeroBandas = value!;
                          });
                        },
                      ),
                      Text('6 bandas'),
                    ],
                  ),

                  // Dropdown para la primera banda
                  DropdownButton<String>(
                    value: banda1,
                    onChanged: (String? newValue) {
                      setState(() {
                        banda1 = newValue!;
                      });
                    },
                    items: valoresColor.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  // Dropdown para la segunda banda
                  DropdownButton<String>(
                    value: banda2,
                    onChanged: (String? newValue) {
                      setState(() {
                        banda2 = newValue!;
                      });
                    },
                    items: valoresColor.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  // Si son 5 o 6 bandas, mostrar la tercera banda
                  if (numeroBandas >= 5)
                    DropdownButton<String>(
                      value: banda3,
                      onChanged: (String? newValue) {
                        setState(() {
                          banda3 = newValue!;
                        });
                      },
                      items: valoresColor.keys
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                  // Dropdown para el multiplicador
                  DropdownButton<String>(
                    value: multiplicador,
                    onChanged: (String? newValue) {
                      setState(() {
                        multiplicador = newValue!;
                      });
                    },
                    items: valoresMultiplicador.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  // Dropdown para la tolerancia
                  DropdownButton<String>(
                    value: tolerancia,
                    onChanged: (String? newValue) {
                      setState(() {
                        tolerancia = newValue!;
                      });
                    },
                    items: valoresTolerancia.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  // Si es una resistencia de 6 bandas, mostrar la banda de temperatura
                  if (numeroBandas == 6)
                    DropdownButton<String>(
                      value: bandaTemperatura,
                      onChanged: (String? newValue) {
                        setState(() {
                          bandaTemperatura = newValue!;
                        });
                      },
                      items: valoresColor.keys
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                  SizedBox(height: 20),

                  // Botón para calcular la resistencia
                  ElevatedButton(
                    onPressed: calcularResistencia,
                    child: Text('Calcular resistencia'),
                  ),

                  SizedBox(height: 20),

                  // Mostrar el valor de la resistencia y la tolerancia
                  if (valorResistencia != null && valorTolerancia != null)
                    Text(
                      'Valor de la resistencia: $valorResistencia Ω \n'
                          'Tolerancia: ±$valorTolerancia%',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void calcularResistencia() {
    int valor1 = valoresColor[banda1]!;
    int valor2 = valoresColor[banda2]!;
    int? valor3 = numeroBandas >= 5 ? valoresColor[banda3] : null;
    double valorMultiplicador = valoresMultiplicador[multiplicador]!;
    double toleranciaSeleccionada = valoresTolerancia[tolerancia]!;

    // Calcular resistencia para 4, 5 y 6 bandas
    setState(() {
      if (numeroBandas == 4) {
        valorResistencia = ((valor1 * 10 + valor2) * valorMultiplicador).toInt();
      } else if (numeroBandas == 5) {
        valorResistencia = ((valor1 * 100 + valor2 * 10 + valor3!) * valorMultiplicador).toInt();
      } else if (numeroBandas == 6) {
        valorResistencia = ((valor1 * 100 + valor2 * 10 + valor3!) * valorMultiplicador).toInt();
        // Aquí podrías agregar la lógica para usar la sexta banda (bandaTemperatura).
      }
      valorTolerancia = toleranciaSeleccionada;
    });

    print('El valor de la resistencia es $valorResistencia ohms con una tolerancia de ±$valorTolerancia%');
  }
}
