import 'package:expense_app/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Why k is a convenction in flutter to set theme related data
// For custom Material Theme accent
var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125)
);

void main() {

  /**
   * Restrict Device Orienation
   */
  // WidgetsFlutterBinding.ensureInitialized();

  // // Set supported Device orienations
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {

  //     // After orienation set
  //     runApp(const MyApp());
  // });


  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          )
        ),
      ),
      title: 'Expense Tracker',
      // theme: ThemeData(useMaterial3: true),
      // Copy the theme and then apply your custom theme
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          )
        ),
        // ElevatedButton does not have copyWith()
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer
          )
        ),
        
        // Dont know, why to use ThemeData().textTheme.copyWith()
        // textTheme: TextTheme().copyWith()
        
        // Check Titlebar
        // textTheme: ThemeData().textTheme.copyWith(
        //   titleLarge: TextStyle(
        //     fontWeight: FontWeight.normal,
        //     color: kColorScheme.onSecondaryContainer,
        //     fontSize: 16,
        //   ),
        //   titleMedium: TextStyle(
        //     fontWeight: FontWeight.normal,
        //     color: kColorScheme.onSecondaryContainer,
        //     fontSize: 12,
        //   ),
        //   titleSmall: TextStyle(
        //     fontWeight: FontWeight.normal,
        //     color: kColorScheme.onSecondaryContainer,
        //     fontSize: 8,
        //   )
        // )
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16
          ),
          displayLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.red,
            fontSize: 7
          ),
          // For Normal Text Widget
          bodyMedium: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      home: Expenses(),
      themeMode: ThemeMode.system,
    );
  }
}
