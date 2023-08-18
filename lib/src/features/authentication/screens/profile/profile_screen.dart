import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';
import 'package:nablr/src/features/authentication/screens/home_screen/home_screen.dart';
import 'package:nablr/src/features/authentication/screens/login/login_screens.dart';
import 'package:nablr/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:nablr/src/repository/authentication_repository/exceptions/authentication_repository.dart';

import '../../controllers/profile_controller.dart';
import '../../models/user_model.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)  {

    final controller = Get.put(ProfileController());
    final _authRepo = Get.put(AuthenticationRepository());

    final email =_authRepo.firebaseUser.value?.email;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){ Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );},icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Profil", style: Theme.of(context).textTheme.headline5),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future:controller.getUserData(),
            builder:(context, snapshot){
              if(snapshot.connectionState == ConnectionState.done ){
                if(snapshot.hasData){
                  UserModel userData = snapshot.data as UserModel;
                  return Container(
                      alignment: Alignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(

                            width:120,
                            height:120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100), child: const Image(image:AssetImage('assets/images/profile/user.jpg')),

                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(userData.fullName,style: Theme.of(context).textTheme.headline4),
                          Text(email!),
                          const SizedBox(height: 10),
                          SizedBox(width:200, child: ElevatedButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
                                );
                              },

                              child:const Text("Modifier Profil", style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  side: BorderSide.none,
                                  shape: StadiumBorder()
                              ) )),
                          const SizedBox(height: 50),
                          SizedBox(width:200, child: ElevatedButton(
                              onPressed: (){
                                AuthenticationRepository.instance.logout();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                                );
                              },
                              child:const Text("Se déconnecter", style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  side: BorderSide.none,
                                  shape: StadiumBorder()
                              ) )),

                        ],
                      )
                  );
                }else if (snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()));
                }else {
                  return const Center(child:Text("Quelque chose ne s'est pas bien passé."));
                }
              }else{
                return const Center(child: CircularProgressIndicator());
              }

            }

        ),
      ),
    );
  }
}
