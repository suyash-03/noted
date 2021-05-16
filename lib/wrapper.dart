import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noted/notes_screen.dart';
import 'google_sign_in.dart';
import 'sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<GoogleSignInProvider>(context);

          if (provider.isSigningIn) {
            return buildLoading();
          } else if (snapshot.hasData) {
            return NotesPage();
          } else {
            return SignIn();
          }
        },
      ),
    ),
  );

  Widget buildLoading() {
    return Container(color: Colors.black54,
      child: SpinKitFadingFour(
        color: Colors.black,
        size: 100,
      ),
    );
  }

}

