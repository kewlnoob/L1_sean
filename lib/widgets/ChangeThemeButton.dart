import 'package:L1_sean/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class ChangeThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context,listen: false);
    return DayNightSwitcher(
      isDarkModeEnabled: provider.isDarkMode,
      onStateChanged: (isDarkModeEnabled) {
        provider.toggle(isDarkModeEnabled);
      },
    );
  }
}
