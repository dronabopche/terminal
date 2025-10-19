import 'package:flutter/material.dart';
import 'theme_manager.dart';

class SettingsScreen extends StatelessWidget {
  final TerminalTheme currentTheme;
  final Function(TerminalTheme) onThemeChange;
  final List<TerminalTheme> themes;

  const SettingsScreen({
    super.key,
    required this.currentTheme,
    required this.onThemeChange,
    required this.themes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUANTUM TERMINAL SETTINGS',
              style: TextStyle(
                fontFamily: currentTheme.fontFamily,
                color: currentTheme.accentColor,
                fontSize: 18,
                shadows: currentTheme.textShadows,
              ),
            ),

            const SizedBox(height: 30),

            _buildSection('THEMES', [
              for (final theme in themes) _buildThemeOption(theme, context),
            ]),

            const SizedBox(height: 30),

            _buildSection('TERMINAL OPTIONS', [
              _buildSettingSwitch('Show Scanlines', true),
              _buildSettingSwitch('Animated Cursor', true),
              _buildSettingSwitch('Quantum Particles', true),
              _buildSettingSwitch('Sound Effects', false),
            ]),

            const SizedBox(height: 30),

            _buildSection('KEYBOARD SHORTCUTS', [
              _buildShortcut('Clear Terminal', 'Ctrl + L'),
              _buildShortcut('Theme Cycle', 'F2'),
              _buildShortcut('Matrix Mode', 'F3'),
              _buildShortcut('Help', 'F1'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: currentTheme.fontFamily,
            color: currentTheme.textColor.withOpacity(0.7),
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: currentTheme.accentColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildThemeOption(TerminalTheme theme, BuildContext context) {
    final isSelected = theme.name == currentTheme.name;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onThemeChange(theme),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.accentColor.withOpacity(0.2)
                : Colors.transparent,
            border: Border.all(
              color: isSelected ? theme.accentColor : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: theme.accentColor,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                theme.name,
                style: TextStyle(
                  fontFamily: theme.fontFamily,
                  color: theme.textColor,
                  fontSize: 14,
                ),
              ),

              const Spacer(),

              if (isSelected)
                Icon(Icons.check, color: theme.accentColor, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingSwitch(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: currentTheme.fontFamily,
              color: currentTheme.textColor,
              fontSize: 14,
            ),
          ),

          const Spacer(),

          Container(
            width: 40,
            height: 20,
            decoration: BoxDecoration(
              color: value ? currentTheme.accentColor : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShortcut(String action, String keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            action,
            style: TextStyle(
              fontFamily: currentTheme.fontFamily,
              color: currentTheme.textColor,
              fontSize: 14,
            ),
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: currentTheme.backgroundColor.withOpacity(0.5),
              border: Border.all(
                color: currentTheme.accentColor.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              keys,
              style: TextStyle(
                fontFamily: currentTheme.fontFamily,
                color: currentTheme.accentColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
