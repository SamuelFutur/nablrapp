
import 'package:flutter/material.dart';
import 'package:nablr/src/features/authentication/screens/login/login_screens.dart';
import 'package:nablr/src/features/authentication/screens/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage("assets/images/welcome_images/welcome.jpg"),height: height*0.6 ),
            Text("Venez! Commençons cette Odyssée!", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40),textAlign: TextAlign.center,),
            //Text("N'ayez pas peur", style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20), textAlign: TextAlign.center,),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.black),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: Text("Se connecter".toUpperCase()),

                    )),
                const SizedBox(width: 5,),
                Expanded(
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          side: BorderSide(color: Colors.black),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: Text("S'enregistrer".toUpperCase())

                    )),
              ],
            )

          ]
        )
      ),
    );
  }
}
