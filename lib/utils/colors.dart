import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1A237E);
  static const Color primaryLight = Color(0xFF534BAE);
  static const Color primaryDark = Color(0xFF000051);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF00ACC1);
  static const Color secondaryLight = Color(0xFF5DDEEB);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color danger = Color(0xFFF44336);
  static const Color normal = Color(0xFF2196F3);
  
  // Neutral Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color border = Color(0xFFE0E0E0);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1A237E), Color(0xFF283593)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient dangerGradient = LinearGradient(
    colors: [Color(0xFFEF5350), Color(0xFFE53935)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Helper method to replace deprecated withOpacity
  static Color withAlpha(Color color, double opacity) {
    return color.withAlpha((255 * opacity).toInt());
  }
}