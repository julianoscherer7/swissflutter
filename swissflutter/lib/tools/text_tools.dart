import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';

class TextTools extends StatefulWidget {
  const TextTools({super.key});

  @override
  State<TextTools> createState() => _TextToolsState();
}

class _TextToolsState extends State<TextTools> {
  final TextEditingController inputController = TextEditingController();
  String result = '';
  int selectedTool = 0;
  
  final List<String> tools = [
    'Contar caracteres',
    'Contar palavras',
    'Texto maiúsculo',
    'Texto minúsculo',
    'Inverter texto',
    'Remover espaços extras',
    'Capitalizar palavras',
  ];
  
  void processText() {
    String text = inputController.text;
    
    setState(() {
      switch (selectedTool) {
        case 0:
          result = '${text.length} caracteres';
          break;
        case 1:
          result = '${text.split(' ').where((word) => word.isNotEmpty).length} palavras';
          break;
        case 2:
          result = text.toUpperCase();
          break;
        case 3:
          result = text.toLowerCase();
          break;
        case 4:
          result = text.split('').reversed.join('');
          break;
        case 5:
          result = text.replaceAll(RegExp(r'\s+'), ' ');
          break;
        case 6:
          result = text.split(' ').map((word) {
            if (word.isEmpty) return '';
            return word[0].toUpperCase() + word.substring(1).toLowerCase();
          }).join(' ');
          break;
        default:
          result = text;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferramentas de Texto'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<int>(
              value: selectedTool,
              onChanged: (int? newValue) {
                setState(() {
                  selectedTool = newValue!;
                });
              },
              items: List.generate(tools.length, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(tools[index]),
                );
              }),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: inputController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Digite seu texto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            GradientButton(
              text: 'Processar Texto',
              onPressed: processText,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    result,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}