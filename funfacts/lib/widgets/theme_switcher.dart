import 'package:flutter/material.dart';
import 'package:funfacts/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Theme Mode", style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Switch(
                value: themeProvider.isChecked,
                onChanged: (value) {
                  themeProvider.updateMode(switcher: value);
                },
              ),
              SizedBox(width: 20),
              // Text(isChecked ? "Dark" : "Light"),
              Icon(
                themeProvider.isChecked
                    ? Icons.dark_mode
                    : Icons.light_mode_outlined,
                size: 30,
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
