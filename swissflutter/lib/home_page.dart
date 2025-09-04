import 'package:flutter/material.dart';
import './utils/constants.dart';
import './widgets/custom_card.dart';
import './tools/unit_converter.dart';
import './tools/measurement_converter.dart';
import './tools/text_tools.dart';
import './tools/calculator.dart';
import './tools/password_generator.dart';
import './tools/currency_converter.dart';
import './tools/date_time_tools.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.appName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Container(
        color: AppColors.background,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.appDescription,
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  CustomCard(
                    title: AppStrings.unitConverter,
                    description: 'Converta entre diferentes unidades de medida',
                    icon: Icons.swap_horiz,
                    iconColor: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UnitConverter()),
                      );
                    },
                  ),
                  CustomCard(
                    title: AppStrings.measurementConverter,
                    description: 'Converta entre sistemas de medidas',
                    icon: Icons.straighten,
                    iconColor: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MeasurementConverter()),
                      );
                    },
                  ),
                  CustomCard(
                    title: AppStrings.textTools,
                    description: 'Diversas ferramentas para manipulação de texto',
                    icon: Icons.text_fields,
                    iconColor: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TextTools()),
                      );
                    },
                  ),
                  CustomCard(
                    title: AppStrings.calculator,
                    description: 'Calculadora básica e científica',
                    icon: Icons.calculate,
                    iconColor: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Calculator()),
                      );
                    },
                  ),
                  CustomCard(
                    title: AppStrings.passwordGenerator,
                    description: 'Gere senhas seguras personalizadas',
                    icon: Icons.lock,
                    iconColor: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PasswordGenerator()),
                      );
                    },
                  ),
                  CustomCard(
                    title: AppStrings.currencyConverter,
                    description: 'Converta entre diferentes moedas',
                    icon: Icons.attach_money,
                    iconColor: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CurrencyConverter()),
                      );
                    },
                  ),
                  CustomCard(
                    title: AppStrings.dateTimeTools,
                    description: 'Ferramentas para datas e horas',
                    icon: Icons.access_time,
                    iconColor: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DateTimeTools()),
                      );
                    },
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