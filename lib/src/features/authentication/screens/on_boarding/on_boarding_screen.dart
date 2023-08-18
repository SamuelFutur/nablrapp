import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:nablr/src/features/authentication/models/model_on_boarding.dart';
import 'package:nablr/src/features/authentication/screens/on_boarding/on_boarding_page_widget.dart';
import 'package:nablr/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    final pages= [
      OnBoardingPage(model: OnBoardingModel(
        image: "assets/images/on_boarding_images/onboarding-1.png",
        title:"Enregistrez toutes vos conversations" ,
        subTitle:"N-ABL-R la solution innovante de FUTURAFRIC IA" ,
        counterText:"1/3" ,
        height: size.height,
        bgColor: Colors.orangeAccent ,
      )),
      OnBoardingPage(model: OnBoardingModel(
        image: "assets/images/on_boarding_images/onboarding-2.jpg",
        title:"Posez des questions et obtenez les réponses" ,
        subTitle: "Adieu la mémoire floue!!!",
        counterText:"2/3" ,
        height: size.height,
        bgColor: Colors.white,

      )),
      OnBoardingPage( model: OnBoardingModel(
        image: "assets/images/on_boarding_images/onboarding-3.png",
        title:"Votre mémoire sera plus limpide que jamais" ,
        subTitle:" N-ABL-R est votre ami!",
        counterText:"3/3" ,
        height: size.height,
        bgColor: Colors.lightBlue ,
      )),
    ];


    return Scaffold(
      body: Stack(
        alignment: Alignment.center ,
      children: [
        LiquidSwipe(
            pages: pages,
            liquidController: controller,
            onPageChangeCallback: onPageChangedCallback,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
        ),
        Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: (){
                int nextPage = controller.currentPage +1;
                controller.animateToPage(page: nextPage);

              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black26),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                onPrimary: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.arrow_forward_ios),
                decoration: const BoxDecoration(color: Color(0xff272727), shape: BoxShape.circle
                ),
            )
            ),
        ),
        Positioned(
          top:50,
           right: 20,
          child: TextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            } //controller.jumpToPage(WelcomeScren())
            ,
            child: const Text(" Passer ", style: TextStyle(color: Colors.grey))
          )
        ),
      ],
      ),
    );
  }

  onPageChangedCallback(int activePageIndex) => currentPage = activePageIndex;
}

