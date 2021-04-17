import 'package:flutter/material.dart';
import 'package:mohab_task/common_widget/social_sigin_button.dart';
import 'package:mohab_task/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          body: Container(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: _buildHeader(),
                    height: 50,
                  ),
                  //auth.user != null ? Text(auth.user.name) : Text(""),
                  SizedBox(height: 48),
                  //auth.user != null ? Text(auth.user.name) : Text(""),
                  SizedBox(height: 48),
                  SocialSignInButton(
                      assetName: 'images/google-logo.png',
                      text: 'Sign in with Google',
                      textColor: Colors.black87,
                      color: Colors.white,
                      onPressed: auth.signInWithGoogle),
                  SizedBox(height: 8.0),
                  SocialSignInButton(
                      assetName: 'images/facebook-logo.png',
                      text: 'Sign in with Facebook',
                      textColor: Colors.white,
                      color: Color(0xFF334D92),
                      onPressed: auth.signInWithFaceBook),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Text(
      'Sign In ',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
