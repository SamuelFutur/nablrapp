import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nablr/src/features/authentication/models/user_model.dart';
import 'package:nablr/src/repository/authentication_repository/exceptions/authentication_repository.dart';
import 'package:nablr/src/repository/user_repository/user_repository.dart';


class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final email= TextEditingController();
  final password= TextEditingController();
  final fullName= TextEditingController();
  final phoneNo= TextEditingController();

  final userRepo = Get.put(UserRepository());

  Future <void> createUser(UserModel user) async{
    await userRepo.createUser(user);
    registerUser(user.email,user.password);
  }
  void registerUser(String email, String password){
     AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  void phoneAuthentication(String phoneNo){
        AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}