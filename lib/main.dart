import 'package:clima_x/screens/loading_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ClimaX());
}

class ClimaX extends StatelessWidget {
  const ClimaX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(),
      home: const LoadingScreen(),
    );
  }
}
