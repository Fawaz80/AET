import 'package:flutter/material.dart';

/// AppTheme provides centralized access to all design tokens including colors,
/// typography, spacing, and component styles.
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  // COLORS
  static const Color primaryColor = Color(0xFF2563EB); // Blue from image
  static const Color secondaryColor = Color(0xFF9CA3AF); // Gray from image
  static const Color fontColor = Color(0xFF111827); // Dark gray/black from image
  
  // Additional colors from design system
  static const Color accentGreen = Color(0xFF16A34A);
  static const Color accentRed = Color(0xFFDC2626);
  static const Color lightBackground = Color(0xFFF3F4F6);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFF111827);
  static const Color placeholderText = Color(0xFF9CA3AF);
  static const Color success = Color(0xFF16A34A);
  static const Color danger = Color(0xFFDC2626);
  
  // TYPOGRAPHY
  static const String _fontFamily = 'Inter'; // Assuming Inter font from the design system
  
  // Display styles
  static TextStyle displayLarge({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.normal,
    color: color ?? fontColor,
    height: 1.3,
  );
  
  static TextStyle displayLargeBold({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: color ?? fontColor,
    height: 1.3,
  );
  
  static TextStyle displayMedium({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.normal,
    color: color ?? fontColor,
    height: 1.3,
  );
  
  static TextStyle displayMediumBold({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: color ?? fontColor,
    height: 1.3,
  );
  
  static TextStyle displaySmall({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    color: color ?? fontColor,
    height: 1.3,
  );
  
  static TextStyle displaySmallBold({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: color ?? fontColor,
    height: 1.3,
  );
  
  // Text styles
  static TextStyle textLarge({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    color: color ?? fontColor,
    height: 1.5,
  );
  
  static TextStyle textMedium({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: color ?? fontColor,
    height: 1.5,
  );
  
  static TextStyle textSmall({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: color ?? fontColor,
    height: 1.5,
  );
  
  static TextStyle textXSmall({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: color ?? fontColor,
    height: 1.5,
  );
  
  // Link styles
  static TextStyle linkLarge({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: color ?? primaryColor,
    height: 1.5,
    decoration: TextDecoration.underline,
  );
  
  static TextStyle linkMedium({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: color ?? primaryColor,
    height: 1.5,
    decoration: TextDecoration.underline,
  );
  
  static TextStyle linkSmall({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: color ?? primaryColor,
    height: 1.5,
    decoration: TextDecoration.underline,
  );
  
  static TextStyle linkXSmall({Color? color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: color ?? primaryColor,
    height: 1.5,
    decoration: TextDecoration.underline,
  );

  // SPACING
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double space2XL = 48.0;
  static const double space3XL = 64.0;
  
  // BORDER RADIUS
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  
  // SHADOWS
  static const List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
  
  static const List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  
  // BUTTON STYLES
  static ButtonStyle primaryButtonStyle({
    Size size = const Size(double.infinity, 48),
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return primaryColor.withOpacity(0.5);
          }
          if (states.contains(WidgetState.pressed)) {
            return primaryColor.withOpacity(0.8);
          }
          return primaryColor;
        },
      ),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
      minimumSize: WidgetStateProperty.all<Size>(size),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: spaceM, vertical: spaceS),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        textMedium(color: Colors.white).copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
  
  static ButtonStyle secondaryButtonStyle({
    Size size = const Size(double.infinity, 48),
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return primaryColor.withOpacity(0.5);
          }
          if (states.contains(WidgetState.pressed)) {
            return primaryColor.withOpacity(0.8);
          }
          return primaryColor;
        },
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          side: const BorderSide(color: primaryColor),
        ),
      ),
      minimumSize: WidgetStateProperty.all<Size>(size),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: spaceM, vertical: spaceS),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        textMedium(color: primaryColor).copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
  
  // TEXT FIELD STYLES
  static InputDecoration textFieldDecoration({
    required String labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: lightBackground,
      labelStyle: textMedium(color: secondaryColor),
      hintStyle: textMedium(color: placeholderText),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spaceM,
        vertical: spaceM,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: primaryColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: danger, width: 1.0),
      ),
    );
  }
  
  // CARD STYLES
  static BoxDecoration cardDecoration({
    Color? color,
    List<BoxShadow>? shadow,
    double? radius,
  }) {
    return BoxDecoration(
      color: color ?? cardBackground,
      borderRadius: BorderRadius.circular(radius ?? radiusMedium),
      boxShadow: shadow ?? shadowSmall,
    );
  }
  
  // THEME DATA - for MaterialApp
  static ThemeData themeData() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBackground,
      fontFamily: _fontFamily,
      textTheme: TextTheme(
        displayLarge: displayLarge(),
        displayMedium: displayMedium(),
        displaySmall: displaySmall(),
        bodyLarge: textLarge(),
        bodyMedium: textMedium(),
        bodySmall: textSmall(),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        error: danger,
        surface: cardBackground,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: textLarge(color: Colors.white).copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}