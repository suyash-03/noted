import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noted/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage('assets/background.jpg'),
              fit: BoxFit.cover
          )
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width,),
            Container(
              child: Text(
                'Noted',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('Sign In to Continue', style: TextStyle(
              color: Colors.white54,
              fontSize: 20
            ),),
            SizedBox(height: 20,),
            Container(height: 100,width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/iconNoted.png')
                )
              ),

            ),
            SizedBox(height: MediaQuery.of(context).size.height/5,),
            // ignore: deprecated_member_use
            Container(width: 200,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue[900],
                      Colors.pink[900],
                    ],
                  )
              ),
              child: FlatButton.icon(
                icon: FaIcon(FontAwesomeIcons.google,color: Colors.white,),
                label: Text('Sign In with Google',
                  style: TextStyle(color: Colors.white),),
                onPressed: (){
                  final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                  provider.login(context);
                },
              ),
            )
          ],
        ),
      );
  }
}
