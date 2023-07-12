import 'package:flutter/material.dart';
import 'package:project_uas/views/home.dart';
import 'package:project_uas/views/views_console.dart';
import 'login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}
