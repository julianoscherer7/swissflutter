import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController amountController = TextEditingController();
  String fromCurrency = 'USD';
  String toCurrency = 'BRL';
  double conversionRate = 0;
  double convertedAmount = 0;
  bool isLoading = false;
  
  final List<String> currencies = [
    'USD', 'BRL', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD', 'CHF', 'CNY', 'INR'
  ];
  
  Future<void> fetchConversionRate() async {
    if (amountController.text.isEmpty) return;
    
    setState(() {
      isLoading = true;
    });
    
    try {
      final response = await http.get(Uri.parse(
        'https://api.exchangerate-api.com/v4/latest/$fromCurrency'
      ));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          conversionRate = data['rates'][toCurrency];
          convertedAmount = double.parse(amountController.text) * conversionRate;
          isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar taxas de câmbio');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Moedas'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: fromCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        fromCurrency = newValue!;
                      });
                    },
                    items: currencies.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.arrow_forward),
                const SizedBox(width: 20),
                Expanded(
                  child: DropdownButton<String>(
                    value: toCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        toCurrency = newValue!;
                      });
                    },
                    items: currencies.map<DropdownMenuItem<String>>((String value) {
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
            GradientButton(
              text: 'Converter',
              onPressed: fetchConversionRate,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Text(
                    '${amountController.text} $fromCurrency = ${convertedAmount.toStringAsFixed(2)} $toCurrency',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 20),
            if (conversionRate > 0)
              Text(
                'Taxa de câmbio: 1 $fromCurrency = ${conversionRate.toStringAsFixed(4)} $toCurrency',
                style: const TextStyle(fontSize: 14),
              ),
          ],
        ),
      ),
    );
  }
}