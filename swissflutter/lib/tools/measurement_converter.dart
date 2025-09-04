import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';

class MeasurementConverter extends StatefulWidget {
  const MeasurementConverter({super.key});

  @override
  State<MeasurementConverter> createState() => _MeasurementConverterState();
}

class _MeasurementConverterState extends State<MeasurementConverter> {
  final List<String> categories = [
    'Comprimento',
    'Área',
    'Volume',
    'Massa',
    'Temperatura'
  ];
  
  final Map<String, List<String>> units = {
    'Comprimento': ['Metro (m)', 'Quilômetro (km)', 'Centímetro (cm)', 'Polegada (in)', 'Pé (ft)', 'Jarda (yd)', 'Milha (mi)'],
    'Área': ['Metro quadrado (m²)', 'Quilômetro quadrado (km²)', 'Hectare (ha)', 'Acre (ac)', 'Pé quadrado (ft²)'],
    'Volume': ['Metro cúbico (m³)', 'Litro (L)', 'Mililitro (mL)', 'Galão (gal)', 'Polegada cúbica (in³)'],
    'Massa': ['Quilograma (kg)', 'Grama (g)', 'Miligrama (mg)', 'Libra (lb)', 'Onça (oz)'],
    'Temperatura': ['Celsius (°C)', 'Fahrenheit (°F)', 'Kelvin (K)'],
  };
  
  String selectedCategory = 'Comprimento';
  String fromUnit = 'Metro (m)';
  String toUnit = 'Quilômetro (km)';
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
    // Fatores de conversão para cada categoria
    Map<String, Map<String, double>> conversionFactors = {
      'Comprimento': {
        'Metro (m)': 1,
        'Quilômetro (km)': 0.001,
        'Centímetro (cm)': 100,
        'Polegada (in)': 39.3701,
        'Pé (ft)': 3.28084,
        'Jarda (yd)': 1.09361,
        'Milha (mi)': 0.000621371,
      },
      'Área': {
        'Metro quadrado (m²)': 1,
        'Quilômetro quadrado (km²)': 0.000001,
        'Hectare (ha)': 0.0001,
        'Acre (ac)': 0.000247105,
        'Pé quadrado (ft²)': 10.7639,
      },
      'Volume': {
        'Metro cúbico (m³)': 1,
        'Litro (L)': 1000,
        'Mililitro (mL)': 1000000,
        'Galão (gal)': 264.172,
        'Polegada cúbica (in³)': 61023.7,
      },
      'Massa': {
        'Quilograma (kg)': 1,
        'Grama (g)': 1000,
        'Miligrama (mg)': 1000000,
        'Libra (lb)': 2.20462,
        'Onça (oz)': 35.274,
      },
      'Temperatura': {
        'Celsius (°C)': 1,
        'Fahrenheit (°F)': 33.8,
        'Kelvin (K)': 274.15,
      },
    };
    
    // Para temperatura, precisamos de conversões especiais
    if (category == 'Temperatura') {
      if (from == 'Celsius (°C)' && to == 'Fahrenheit (°F)') {
        return (value * 9/5) + 32;
      } else if (from == 'Celsius (°C)' && to == 'Kelvin (K)') {
        return value + 273.15;
      } else if (from == 'Fahrenheit (°F)' && to == 'Celsius (°C)') {
        return (value - 32) * 5/9;
      } else if (from == 'Fahrenheit (°F)' && to == 'Kelvin (K)') {
        return (value - 32) * 5/9 + 273.15;
      } else if (from == 'Kelvin (K)' && to == 'Celsius (°C)') {
        return value - 273.15;
      } else if (from == 'Kelvin (K)' && to == 'Fahrenheit (°F)') {
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
        title: const Text('Conversor de Medidas'),
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