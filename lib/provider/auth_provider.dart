import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String name;
  final String email;
  final String url;

  User({this.name, this.email, this.url});
}

class AuthProvider extends ChangeNotifier {
  User user;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
    ],
  );

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      user = User(
          name: account.displayName,
          email: account.email,
          url: account.photoUrl);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> signInWithFaceBook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      user = User(
          name: userData["name"],
          email: userData["email"],
          url: userData["picture"]["data"]["url"]);
      notifyListeners();
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await FacebookAuth.instance.logOut();
    user = null;
    notifyListeners();
  }
}
