import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    final textstyle = TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
    );
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      primaryColor: AppColors.primary,

      scaffoldBackgroundColor: AppColors.secundary, //fundo
      cardColor: AppColors.primary, 
      canvasColor: AppColors.secundary,

      iconTheme: const IconThemeData(
        color: AppColors.surface,
        size: 20,
      ),
      textTheme: TextTheme(
        headlineMedium: textstyle,
        headlineSmall: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        bodyMedium: TextStyle(
          color: AppColors.text,
          fontSize: 13,
        ),
        labelMedium: TextStyle(
          color: AppColors.text,
          fontSize: 14,
        ),
        labelSmall: TextStyle(
          color: AppColors.text,
          fontSize: 12,
        ),
      ),
    );
  }
}