import 'dart:ui';
import 'package:flutter/material.dart';

class LocalTheme{
  Color textPrimaryColor;
  Color textSecondaryColor;
  Color primaryColor;
  Color iconsFooterColor;
  Color headerColor;
  bool transparentHeader;
  Color footerColor;
  bool transparentFooter;
  bool filtroImagenFondo;
  bool fondoBlanco;
  double widthLogoLogin;
  final ThemeData datePickerStyle = ThemeData.dark();
  final Color colorCardTrnsparente1 = Colors.white.withOpacity(0.5);
  final Color colorCardTrnsparente2 = Colors.white.withOpacity(0.7);
  final Color colorCardTrnsparente3 = Colors.white.withOpacity(0.3);
  final double appbarSize = 30.0;

  LocalTheme(
      {this.textPrimaryColor = Colors.white,
        this.textSecondaryColor = Colors.white70,
        this.primaryColor = Colors.white24,
        this.filtroImagenFondo = true,
        this.fondoBlanco = true,
        this.iconsFooterColor = Colors.white,
        this.transparentHeader = true,
        this.transparentFooter = true,
        this.headerColor = Colors.white24,
        this.footerColor = Colors.white24,
        this.widthLogoLogin = 140.0}
      );
}