import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';

class UnitConverter extends StatefulWidget {
  const UnitConverter({super.key});

  @override
  State<UnitConverter> createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  final List<String> categories = [
    'Comprimento',
    'Peso',
    'Temperatura',
    'Volume',
    'Tempo'
  ];
  
  final Map<String, List<String>> units = {
    'Comprimento': ['Metros', 'Quilômetros', 'Centímetros', 'Milímetros', 'Pés', 'Polegadas'],
    'Peso': ['Quilogramas', 'Gramas', 'Miligramas', 'Libras', 'Onças'],
    'Temperatura': ['Celsius', 'Fahrenheit', 'Kelvin'],
    'Volume': ['Litros', 'Mililitros', 'Galões', 'Xícaras'],
    'Tempo': ['Segundos', 'Minutos', 'Horas', 'Dias'],
  };
  
  String selectedCategory = 'Comprimento';
  String fromUnit = 'Metros';
  String toUnit = 'Quilômetros';
  double inputValue = 0;
  double result = 0;
  
  final TextEditingController inputController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    inputController.addListener(() {
      setState(() {
        inputValue = double.tryParse(inputController.text) ?? 0;
      });
    });
  }
  
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
  
  void convert() {
    setState(() {
      result = _convertValue(inputValue, fromUnit, toUnit, selectedCategory);
    });
  }
  
  double _convertValue(double value, String from, String to, String category) {
    // Implementação das conversões
    Map<String, Map<String, double>> conversionFactors = {
      'Comprimento': {
        'Metros': 1,
        'Quilômetros': 0.001,
        'Centímetros': 100,
        'Milímetros': 1000,
        'Pés': 3.28084,
        'Polegadas': 39.3701,
      },
      'Peso': {
        'Quilogramas': 1,
        'Gramas': 1000,
        'Miligramas': 1000000,
        'Libras': 2.20462,
        'Onças': 35.274,
      },
      'Temperatura': {
        'Celsius': 1,
        'Fahrenheit': 33.8,
        'Kelvin': 274.15,
      },
      'Volume': {
        'Litros': 1,
        'Mililitros': 1000,
        'Galões': 0.264172,
        'Xícaras': 4.22675,
      },
      'Tempo': {
        'Segundos': 1,
        'Minutos': 1/60,
        'Horas': 1/3600,
        'Dias': 1/86400,
      },
    };
    
    // Para temperatura, precisamos de conversões especiais
    if (category == 'Temperatura') {
      if (from == 'Celsius' && to == 'Fahrenheit') {
        return (value * 9/5) + 32;
      } else if (from == 'Celsius' && to == 'Kelvin') {
        return value + 273.15;
      } else if (from == 'Fahrenheit' && to == 'Celsius') {
        return (value - 32) * 5/9;
      } else if (from == 'Fahrenheit' && to == 'Kelvin') {
        return (value - 32) * 5/9 + 273.15;
      } else if (from == 'Kelvin' && to == 'Celsius') {
        return value - 273.15;
      } else if (from == 'Kelvin' && to == 'Fahrenheit') {
        return (value - 273.15) * 9/5 + 32;
      }
      return value;
    }
    
    // Para outras categorias, usamos fatores de conversão
    double fromFactor = conversionFactors[category]![from]!;
    double toFactor = conversionFactors[category]![to]!;
    
    // Converter para a unidade base primeiro
    double baseValue = value / fromFactor;
    
    // Converter da unidade base para a unidade de destino
    return baseValue * toFactor;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Unidades'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  fromUnit = units[selectedCategory]!.first;
                  toUnit = units[selectedCategory]!.last;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: fromUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        fromUnit = newValue!;
                      });
                    },
                    items: units[selectedCategory]!.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DropdownButton<String>(
                    value: toUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        toUnit = newValue!;
                      });
                    },
                    items: units[selectedCategory]!.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor para converter',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            GradientButton(
              text: 'Converter',
              onPressed: convert,
            ),
            const SizedBox(height: 20),
            Text(
              'Resultado: ${result.toStringAsFixed(4)} $toUnit',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}