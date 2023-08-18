import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nablr/src/features/authentication/screens/home_screen/home_screen.dart';
import 'package:nablr/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:nablr/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';

import '../../../features/authentication/models/user_model.dart';
import '../../../features/authentication/screens/on_boarding/on_boarding_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId= ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    //user == null ?
        Get.offAll(() => OnBoardingScreen());
        //: Get.offAll(() => WelcomeScreen() );
  }

  Future <void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        codeSent: (verificationId,resendToken) {
              this.verificationId.value= verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value= verificationId;
        },
        verificationFailed: (e){
          if(e.code=='invalid-phone-number'){
            Get.snackbar('Erreur','Le numéro entré est invalide.');
          }else {
            Get.snackbar('Error','Quelque chose s\'est mal passé, essayez à nouveau');
          }
        },
    );
  }

  Future <bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: this.verificationId.value, smsCode: otp));
    //return credentials.user != null ? true : false;
    if (credentials.user != null){
      return false;
    }else {
      return true;
    }
  }



  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<void> logout() async => await _auth.signOut();






}
