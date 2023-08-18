import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../repository/authentication_repository/exceptions/authentication_repository.dart';
import '../../controllers/signup_controller.dart';
import '../forget_password/forget_password_mail/forget_password_mail.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText= true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(SignUpController());

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        /*-- Section-1 --*/
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Image(image:const AssetImage("assets/logo/logo.png"), height: size.height * 0.3, alignment: Alignment.center),
                Text("Bon retour", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40)),
                /*-- End --*/

                /*-- Section-2 --*/

                 Form(
                   key: _formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:[
                       TextFormField(
                         controller: controller.email,
                         decoration: const InputDecoration(
                           prefixIcon: Icon(Icons.person_outline_outlined),
                           labelText:"Votre mail",
                           hintText:"Votre mail",
                           border: OutlineInputBorder()
                         ),
                       ),
                       SizedBox(height: 30.0 ),
                       TextFormField(
                         controller: controller.password,
                         obscureText: _obscureText,
                         decoration: InputDecoration(
                             prefixIcon: Icon(Icons.fingerprint),
                             labelText:"Votre mot de passe",
                             hintText:"Votre mot de pass",
                             border: OutlineInputBorder(),
                           suffixIcon: GestureDetector(
                             onTap: (){
                               setState(() {
                                 _obscureText=!_obscureText;
                               });
                             } ,
                               child: Icon(_obscureText? Icons.visibility_off: Icons.visibility)
                           ),

                       ),
                       ),
                       const SizedBox(height: 10),
                       //Align(alignment: Alignment.centerRight,child: TextButton(onPressed: (){}, child: Text("Mot de passe oublié?"))),
                       SizedBox(
                           width: double.infinity,
                           child: ElevatedButton(onPressed: (){
                             if(_formKey.currentState!.validate()){
                               AuthenticationRepository.instance.loginWithEmailAndPassword(controller.email.text.trim(), controller.password.text.trim());
                             }
                           },
                               child: Text("Se connecter".toUpperCase()),
                               style:  ElevatedButton.styleFrom(
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
                                 icon: Image(image: AssetImage("assets/logo/google.png"), width:20.0),
                                 onPressed: (){},
                                 label: Text("Se connecter avec Google")
                             ),
                           ),
                           const SizedBox(height: 10.0),
                           TextButton(
                               onPressed: (){
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                 );
                               },
                               child: Text.rich(
                                   TextSpan(
                                       text:"Vous n'avez pas de compte?",
                                       style: Theme.of(context).textTheme.bodyText1,
                                       children: [
                                                    TextSpan(
                                                        text: "S'enregistrer",
                                                        style: TextStyle(color: Colors.blue),
                                                      )
                                                          ])))
                         ],
                       ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: (){
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  builder: (context) =>Container(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Faites un choix!", style: Theme.of(context).textTheme.headline2),
                                        Text("Selectionnez une des options ci-dessous pour réinitialiser votre mot de passe.", style: Theme.of(context).textTheme.bodyText2),
                                        const SizedBox(height: 30.0),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ForgetPasswordMailScreen()),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Row(

                                              children: [
                                                const Icon(Icons.mail_outline_rounded, size:30.0),
                                                const SizedBox(width: 10.0),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Email", style: Theme.of(context).textTheme.headline6),
                                                    Text("Réinitialiser via email.", style: Theme.of(context).textTheme.bodyText2),
                                                  ]
                                                )

                                              ]
                                            ),
                                          ),
                                        ),
                                        SizedBox(height:20),
                                        GestureDetector(
                                          onTap: (){},
                                          child: Container(
                                            padding: const EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Row(

                                                children: [
                                                  const Icon(Icons.mobile_friendly_rounded, size:30.0),
                                                  const SizedBox(width: 10.0),
                                                  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Numéro de téléphone", style: Theme.of(context).textTheme.headline6),
                                                        Text("Réinitialiser via numéro de téléphone.", style: Theme.of(context).textTheme.bodyText2),
                                                      ]
                                                  )

                                                ]
                                            ),
                                          ),
                                        ),

                                      ],
                                    )
                                  ),
                              );
                            },
                            child:  Text("Mot de passe oublié ?"),
                          )
                        )
                     ],
                   ),
                 ),


              ],
            )
          )
        ),
      ),
    );
  }
}
