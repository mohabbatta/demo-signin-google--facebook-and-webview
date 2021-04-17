import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohab_task/landing_page.dart';
import 'package:mohab_task/provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Eassac",
      home: ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: LandingPage(),
      ),
    );
  }
}
