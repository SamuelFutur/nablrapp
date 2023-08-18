
import 'package:flutter/material.dart';
import 'package:nablr/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children:  [
                SizedBox(height: 30*4),
                Image(image:const AssetImage("assets/images/forget_password/forget_password.png"), height: size.height * 0.3),
                Text("Mot de passe oublié", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40), textAlign: TextAlign.center,),
                SizedBox(height: 15.0),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Email"),
                          hintText: "Email",
                            border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.mail_outline_rounded)
                        )
                      ),
                      SizedBox(height:20.0),
                      SizedBox(width: double.infinity ,child: ElevatedButton(onPressed: (){Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTPScreen()),
                      );}, child: Text("Next"), style: ElevatedButton.styleFrom(primary:Colors.black),))
                    ],
                  )
                )

              ]
            ),
          ),
        ),

      );

  }
}
