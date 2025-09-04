// Utilitários para funções de conversão

class Converters {
  // Conversão de temperatura
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9/5) + 32;
  }

  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5/9;
  }

  static double celsiusToKelvin(double celsius) {
    return celsius + 273.15;
  }

  static double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  // Conversão de comprimento
  static double metersToFeet(double meters) {
    return meters * 3.28084;
  }

  static double feetToMeters(double feet) {
    return feet / 3.28084;
  }

  static double metersToInches(double meters) {
    return meters * 39.3701;
  }

  static double inchesToMeters(double inches) {
    return inches / 39.3701;
  }

  // Conversão de massa
  static double kilogramsToPounds(double kilograms) {
    return kilograms * 2.20462;
  }

  static double poundsToKilograms(double pounds) {
    return pounds / 2.20462;
  }

  // Conversão de volume
  static double litersToGallons(double liters) {
    return liters * 0.264172;
  }

  static double gallonsToLiters(double gallons) {
    return gallons / 0.264172;
  }

  // Outras funções úteis
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  static String removeExtraSpaces(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}