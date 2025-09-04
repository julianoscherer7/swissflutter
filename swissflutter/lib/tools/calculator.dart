import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'dart:math' as math;


class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _expression = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";
  bool _isScientific = false;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      } else if (buttonText == "⌫") {
        if (_output.isNotEmpty && _output != "0") {
          _output = _output.substring(0, _output.length - 1);
          if (_output.isEmpty) _output = "0";
        }
      } else if (buttonText == "=") {
        _num2 = double.parse(_output);
        
        if (_operand == "+") {
          _output = (_num1 + _num2).toString();
        }
        if (_operand == "-") {
          _output = (_num1 - _num2).toString();
        }
        if (_operand == "×") {
          _output = (_num1 * _num2).toString();
        }
        if (_operand == "÷") {
          _output = (_num1 / _num2).toString();
        }
        if (_operand == "%") {
          _output = (_num1 % _num2).toString();
        }
        if (_operand == "^") {
          _output = (math.pow(_num1, _num2)).toString();
        }
        
        _num1 = 0;
        _num2 = 0;
        _operand = "";
        _expression = "";
      } else if (["+", "-", "×", "÷", "%", "^"].contains(buttonText)) {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _expression = _output + buttonText;
        _output = "0";
      } else if (buttonText == "±") {
        _output = (-double.parse(_output)).toString();
      } else if (buttonText == ".") {
        if (!_output.contains(".")) {
          _output += ".";
        }
      } else if (buttonText == "√") {
        _output = (math.sqrt(double.parse(_output))).toString();
      } else if (buttonText == "sin") {
        _output = (math.sin(double.parse(_output) * math.pi / 180)).toStringAsFixed(4);
      } else if (buttonText == "cos") {
        _output = (math.cos(double.parse(_output) * math.pi / 180)).toStringAsFixed(4);
      } else if (buttonText == "tan") {
        _output = (math.tan(double.parse(_output) * math.pi / 180)).toStringAsFixed(4);
      } else if (buttonText == "log") {
        _output = (math.log(double.parse(_output))).toStringAsFixed(4);
      } else if (buttonText == "ln") {
        _output = (math.log(double.parse(_output)) / math.log(math.e)).toStringAsFixed(4);
      } else if (buttonText == "π") {
        _output = math.pi.toString();
      } else if (buttonText == "e") {
        _output = math.e.toString();
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
      
      // Remove trailing .0 if present
      if (_output.endsWith(".0")) {
        _output = _output.substring(0, _output.length - 2);
      }
    });
  }

  Widget _buildButton(String buttonText, {Color color = Colors.black54, Color textColor = Colors.white, double height = 1}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * height,
      margin: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () => _buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isScientific ? Icons.calculate : Icons.science),
            onPressed: () {
              setState(() {
                _isScientific = !_isScientific;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _expression,
                  style: const TextStyle(fontSize: 24, color: Colors.grey),
                ),
                Text(
                  _output,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _isScientific ? _buildScientificCalculator() : _buildBasicCalculator(),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicCalculator() {
    return GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 1.2,
      padding: const EdgeInsets.all(8),
      children: [
        _buildButton("C", color: Colors.red),
        _buildButton("⌫", color: Colors.blue),
        _buildButton("%", color: Colors.blue),
        _buildButton("÷", color: Colors.blue),
        _buildButton("7"),
        _buildButton("8"),
        _buildButton("9"),
        _buildButton("×", color: Colors.blue),
        _buildButton("4"),
        _buildButton("5"),
        _buildButton("6"),
        _buildButton("-", color: Colors.blue),
        _buildButton("1"),
        _buildButton("2"),
        _buildButton("3"),
        _buildButton("+", color: Colors.blue),
        _buildButton("±"),
        _buildButton("0"),
        _buildButton("."),
        _buildButton("=", color: Colors.green),
      ],
    );
  }

  Widget _buildScientificCalculator() {
    return GridView.count(
      crossAxisCount: 5,
      childAspectRatio: 1.2,
      padding: const EdgeInsets.all(8),
      children: [
        _buildButton("C", color: Colors.red),
        _buildButton("⌫", color: Colors.blue),
        _buildButton("%", color: Colors.blue),
        _buildButton("÷", color: Colors.blue),
        _buildButton("π", color: Colors.orange),
        _buildButton("7"),
        _buildButton("8"),
        _buildButton("9"),
        _buildButton("×", color: Colors.blue),
        _buildButton("e", color: Colors.orange),
        _buildButton("4"),
        _buildButton("5"),
        _buildButton("6"),
        _buildButton("-", color: Colors.blue),
        _buildButton("√", color: Colors.orange),
        _buildButton("1"),
        _buildButton("2"),
        _buildButton("3"),
        _buildButton("+", color: Colors.blue),
        _buildButton("^", color: Colors.orange),
        _buildButton("±"),
        _buildButton("0"),
        _buildButton("."),
        _buildButton("=", color: Colors.green),
        _buildButton("sin", color: Colors.orange),
        _buildButton("cos", color: Colors.orange),
        _buildButton("tan", color: Colors.orange),
        _buildButton("log", color: Colors.orange),
        _buildButton("ln", color: Colors.orange),
      ],
    );
  }
}