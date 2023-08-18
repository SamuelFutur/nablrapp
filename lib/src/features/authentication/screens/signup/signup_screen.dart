import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nablr/src/features/authentication/controllers/signup_controller.dart';
import 'package:nablr/src/features/authentication/models/user_model.dart';
import 'package:nablr/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:nablr/src/features/authentication/screens/login/login_screens.dart';
import 'package:nablr/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nablr/src/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool _obscureText= true;
  final  _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    final controller =Get.put(SignUpController());

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Image(
                    image: const AssetImage("assets/logo/logo.png"),
                    height: size.height * 0.2),
                Text("Demarrez l'aventure!",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 25)),
                SizedBox(height:10),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                         controller: controller.fullName,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: "Votre Nom Complet",
                            hintText: "Votre Nom Complet",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: controller.email,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: "Votre Mail",
                            hintText: "Votre Mail",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: controller.phoneNo,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            labelText: "Votre Numéro de téléphone",
                            hintText: "Votre Numéro de téléphone",
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 10.0),

                      TextFormField(
                        controller: controller.password,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint),
                          labelText: "Votre mot de passe",
                          hintText: "Votre mot de passe",
                          border: OutlineInputBorder(),
                          suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _obscureText=!_obscureText;
                                });
                              } ,
                              child: Icon(_obscureText? Icons.visibility_off : Icons.visibility)
                          ),

                        ),
                      ),
                      const SizedBox(height: 10),
                      //Align(alignment: Alignment.centerRight,child: TextButton(onPressed: (){}, child: Text("Mot de passe oublié?"))),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){

                                final user = UserModel(
                                    email: controller.email.text.trim(),
                                    password: controller.password.text.trim(),
                                    fullName: controller.fullName.text.trim(),
                                    phoneNo: controller.phoneNo.text.trim());


                                SignUpController.instance.createUser(user);//registerUser(controller.email.text.trim(), controller.password.text.trim());
                                //SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                                //Get.to(()=> const OTPScreen());
                              }
                            },
                            child: Text("S'enregistrer".toUpperCase()),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black, // Background color
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("OU"),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                                icon: Image(
                                    image: AssetImage("assets/logo/google.png"),
                                    width: 20.0),
                                onPressed: () {},
                                label: Text("S'inscrire avec Google")),
                          ),
                          const SizedBox(height: 10.0),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              },
                              child: Text.rich(TextSpan(
                                  text: "Déjà un compte?",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  children: [
                                    TextSpan(
                                      text: "Se connecter",
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ])))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
