import 'package:c_masteruser/wrapper_main.dart';
import 'package:c_masteruser/themes/theme_constant.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  // SQLITE DATABASE NOT USED
  // AppDatabase.initDatabase;
  //
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager.getThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'C Master User',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeManager.themeMode,
        home: WrapperMain());
  }
}
