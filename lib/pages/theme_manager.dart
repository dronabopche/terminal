import 'package:flutter/material.dart';

abstract class TerminalTheme {
  // Core identity
  String get name;
  String get fontFamily;

  // Color palette
  Color get backgroundColor;
  Color get textColor;
  Color get accentColor;
  Color get cursorColor;
  Color get promptColor;

  // Status colors
  Color get errorColor;
  Color get warningColor;
  Color get successColor;

  // Visual effects
  List<Shadow> get textShadows;

  // Content
  String get asciiArt;
  String get welcomeMessage;

  // Decoration
  BoxDecoration get terminalDecoration;

  // Background (optional - for themes that want custom backgrounds)
  Widget get backgroundWidget => Container(color: backgroundColor);
}
