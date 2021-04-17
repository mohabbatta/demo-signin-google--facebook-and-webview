import 'package:flutter/material.dart';
import 'package:mohab_task/app/home_page.dart';
import 'package:mohab_task/app/sign_in_page.dart';
import 'package:mohab_task/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        if (auth.user != null) return MyHomePage();
        return SignInPage();
      },
    );
  }
}
