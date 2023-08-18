import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nablr/src/features/authentication/controllers/otp_verification.dart';


class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OTPController());
    var otp;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
              Text("CODE", style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontFamily: "CormorantGaramond",
              ), textAlign: TextAlign.center,),
            Text("de vérification".toUpperCase(), style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 40.0),
            Text("Entrez le code de vérification envoyé", textAlign: TextAlign.center,),
            const SizedBox(height: 20.0),
            OtpTextField(
                   numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  keyboardType: TextInputType.number ,
                  onSubmit: (code) {
                    otp=code;
                    OTPController.instance.verifyOTP(otp);
                  },
            ),
               const SizedBox(height: 20.0) ,
            SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () {OTPController.instance.verifyOTP(otp);},child: const Text("Next"), style: ElevatedButton.styleFrom( primary: Colors.black)))
          ],
        ),
      ),
    );
  }
}
