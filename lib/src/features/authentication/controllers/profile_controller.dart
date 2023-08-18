import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nablr/src/repository/authentication_repository/exceptions/authentication_repository.dart';

import '../../../repository/user_repository/user_repository.dart';
import '../models/user_model.dart';


class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData(){
    final email =_authRepo.firebaseUser.value?.email;
    if (email!=null){
      return _userRepo.getUserDetails(email);
    }else {
      Get.snackbar("Erreur", "Connecter vous pour continuer.");
    }
  }

  updateRecord(UserModel user) async {
    //await _userRepo.updateUserRecord(user);
    await _db.collection("User").doc(user.id).update(user.toJson());
    print("User id is ${user.id}");
  }
}