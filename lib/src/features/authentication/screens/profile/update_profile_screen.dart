import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';
import 'package:nablr/src/features/authentication/controllers/profile_controller.dart';
import 'package:nablr/src/features/authentication/models/user_model.dart';
import 'package:nablr/src/features/authentication/screens/profile/profile_screen.dart';

import '../../controllers/signup_controller.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProfileController());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );}, icon: const Icon(LineAwesomeIcons.angle_left)),
          title: Text("Modifier Profil",
              style: Theme.of(context).textTheme.headline5),
        ),
        body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.all(30),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder:(context, snapshot){
              if(snapshot.connectionState == ConnectionState.done ){
                if(snapshot.hasData){
                  UserModel user = snapshot.data as UserModel;

                  final email= TextEditingController(text: user.email);
                  final password= TextEditingController(text: user.password);
                  final fullName= TextEditingController(text: user.fullName);
                  final phoneNo= TextEditingController(text: user.phoneNo);

                  return Column(children: [

                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: fullName,
                              //initialValue: user.fullName ,
                              //controller: controller.fullName,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person_outline_outlined),
                                  labelText: "Votre Nom Complet",
                                  hintText: "Votre Nom Complet",
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              controller: email,
                             // initialValue: user.email,
                              //controller: controller.email,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelText: "Votre Mail",
                                  hintText: "Votre Mail",
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              controller: phoneNo,
                              //initialValue: user.phoneNo,
                              //controller: controller.phoneNo,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.numbers),
                                  labelText: "Votre Numéro de téléphone",
                                  hintText: "Votre Numéro de téléphone",
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 10.0),

                            TextFormField(
                              controller: password,
                              //initialValue: user.password,
                              //controller: controller.password,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.fingerprint),
                                labelText: "Votre mot de passe",
                                hintText: "Votre mot de passe",
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.remove_red_eye_sharp),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            //Align(alignment: Alignment.centerRight,child: TextButton(onPressed: (){}, child: Text("Mot de passe oublié?"))),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final userData = UserModel(
                                      id:user.id,
                                      email: email.text.trim(),
                                      password: password.text.trim(),
                                      fullName: fullName.text.trim(),
                                      phoneNo: phoneNo.text.trim(),
                                    );
                                    await controller.updateRecord(userData);
                                  },
                                  child: Text("Modifier".toUpperCase()),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black, // Background color
                                  ),
                                )),
                          ],
                        )),
                  ]);
                } else if (snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()));
                }else {
                  return const Center(child:Text("Quelque chose ne s'est pas bien passé."));
                }
              }else{
                return const Center(child: CircularProgressIndicator());
              }
            } ,

          ),
        ),
        ));
  }
}

