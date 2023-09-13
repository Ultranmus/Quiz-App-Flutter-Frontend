import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/colors.dart';
import 'package:quiz_app/questions/screens/main_screen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: appBar,
            titleTextStyle: TextStyle(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white)),
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: appBar,
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(teal),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: appBar),
          hintStyle: const TextStyle(color: appBar),
          suffixIconColor: appBar,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: appBar,
              )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: teal,
          )),
        ),
        indicatorColor: appBar,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}
