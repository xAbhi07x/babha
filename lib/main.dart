import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
// import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 99, 125), brightness: Brightness.dark);

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); //ensures the Flutter framework is initialized before executing any further code
  // SystemChrome.setPreferredOrientations([
  //   // is used to set the preferred orientations for the device's screen. It takes a list of DeviceOrientation enums as arguments. These enums represent the possible orientations of the device's screen, such as portrait, landscape left, landscape right, etc.
  //   DeviceOrientation.portraitUp,
  // ]).then((fn){
    runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          ),
      ),
      theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 30, 28, 28),
                    fontSize: 14),
              )),
      // themeMode: ThemeMode.system, default
      home: const Expenses(),
    ),
  );
  // });

  
}
