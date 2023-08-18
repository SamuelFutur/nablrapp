

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nablr/src/features/authentication/screens/home_screen/home_screen.dart';
import 'package:nablr/src/repository/authentication_repository/exceptions/authentication_repository.dart';

class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeScreen()) : Get.back();

  }
}