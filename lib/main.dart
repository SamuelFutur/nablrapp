import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nablr/firebase_options.dart';
import 'package:nablr/src/features/authentication/screens/home_screen/home_screen.dart';
import 'package:nablr/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:nablr/src/repository/authentication_repository/exceptions/authentication_repository.dart';
import 'package:nablr/src/utils/theme/theme.dart';
import 'package:nablr/src/utils/theme/widget_themes/text_theme.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthenticationRepository()));
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    //appleProvider: AppleProvider.appAttest,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.LightTheme,
      darkTheme: TAppTheme.darkTheme ,
      themeMode: ThemeMode.system,
      home: OnBoardingScreen(),//OnBoardingScreen(),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text(".appable/"), leading: const Icon(Icons.ondemand_video))


      );
  }
}

//class OTPController extends GetxController{
  //static OTPController get instance => Get.find();

  //void verifyOTP(String otp) async{
    //var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    //isVerified ? Get.offAll(const HomeScreen()) : Get.back();

  //}
//}
