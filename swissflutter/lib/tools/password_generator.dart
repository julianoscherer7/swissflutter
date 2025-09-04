import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';
import 'dart:math';

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String password = '';
  int length = 12;
  bool includeUppercase = true;
  bool includeLowercase = true;
  bool includeNumbers = true;
  bool includeSymbols = true;
  
  void generatePassword() {
    const String uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const String numbers = '0123456789';
    const String symbols = '!@#\$%^&*()_-+={}[]|;:<>.,?/';
    
    String chars = '';
    if (includeUppercase) chars += uppercase;
    if (includeLowercase) chars += lowercase;
    if (includeNumbers) chars += numbers;
    if (includeSymbols) chars += symbols;
    
    if (chars.isEmpty) {
      setState(() {
        password = 'Selecione pelo menos uma opção';
      });
      return;
    }
    
    String newPassword = '';
    final random = Random();
    
    for (int i = 0; i < length; i++) {
      newPassword += chars[random.nextInt(chars.length)];
    }
    
    setState(() {
      password = newPassword;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Senhas'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comprimento da senha:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: length.toDouble(),
              min: 4,
              max: 32,
              divisions: 28,
              label: length.toString(),
              onChanged: (double value) {
                setState(() {
                  length = value.round();
                });
              },
            ),
            Text('$length caracteres', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            const Text(
              'Incluir:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: const Text('Letras maiúsculas'),
              value: includeUppercase,
              onChanged: (bool? value) {
                setState(() {
                  includeUppercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Letras minúsculas'),
              value: includeLowercase,
              onChanged: (bool? value) {
                setState(() {
                  includeLowercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Números'),
              value: includeNumbers,
              onChanged: (bool? value) {
                setState(() {
                  includeNumbers = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Símbolos'),
              value: includeSymbols,
              onChanged: (bool? value) {
                setState(() {
                  includeSymbols = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            GradientButton(
              text: 'Gerar Senha',
              onPressed: generatePassword,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                password,
                style: const TextStyle(fontSize: 18, fontFamily: 'Monospace'),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            if (password.isNotEmpty)
              GradientButton(
                text: 'Copiar Senha',
                onPressed: () {
                  // Implementar cópia para área de transferência
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Senha copiada!')),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}