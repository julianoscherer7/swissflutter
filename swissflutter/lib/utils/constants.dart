import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFFFF9F43);
  static const Color accent = Color(0xFF36BDC0);
  static const Color background = Color(0xFFF5F5F5);
  static const Color card = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2D2D2D);
  static const Color textSecondary = Color(0xFF757575);
}

class AppTextStyles {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}

class AppStrings {
  static const String appName = 'Swiss Army Knife';
  static const String appDescription = 'Todas as ferramentas que você precisa em um único lugar';
  
  static const String unitConverter = 'Conversor de Unidades';
  static const String measurementConverter = 'Conversor de Medidas';
  static const String textTools = 'Ferramentas de Texto';
  static const String calculator = 'Calculadora';
  static const String passwordGenerator = 'Gerador de Senhas';
  static const String currencyConverter = 'Conversor de Moedas';
  static const String dateTimeTools = 'Ferramentas de Data e Hora';
}