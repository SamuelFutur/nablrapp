import 'package:flutter/material.dart';
import 'package:nablr/src/features/authentication/screens/chat/chat_screen.dart';
import 'package:nablr/src/features/authentication/screens/choice_screen/choice_screen.dart';
import 'package:nablr/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:nablr/src/features/authentication/screens/y.dart';
import 'package:nablr/src/features/authentication/screens/z.dart';

import '../transcription/transcription_screen.dart';
import '../x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState  extends State<HomeScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.75,
  );

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(cities[currentPage].imageUrl),
                fit: BoxFit.cover,
                opacity: 0.45,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: cities[currentPage].gradientColor,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.75,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: cities.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(23),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            margin: EdgeInsets.only(
                              left: 12,
                              right: 12,
                              bottom: index == currentPage ? 15 : 35,
                              top: index == currentPage ? 15 : 35,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23),
                              color: index == currentPage
                                  ? Colors.white
                                  : Colors.grey.shade300,
                              image: DecorationImage(
                                image: AssetImage(cities[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            height: 30.0,
                            width: 250.0,
                            bottom: 20,
                            right: 20,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => _pages[currentPage]),
                                );
                              },
                              child: Text(text[currentPage]),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class City {
  final String name;
  final String imageUrl;
  final List<Color> gradientColor;

  City(this.name, this.imageUrl, this.gradientColor);
}
List<Widget> _pages = [
  Choice(),
  ChatScreen(),
  ProfileScreen()
];

List<String> text =[
  "Transcription",
  "Question-Réponse",
  "Votre Profil"
];

final List<City> cities = [
  City(
    'Paris',
    'assets/images/welcome_images/conversation.jpg',
    [Color(0xFFF131210).withOpacity(0.25), Color(0xFFF8F430E).withOpacity(0.3)],
  ),
  City(
    'New York',
    'assets/images/welcome_images/resume.jpg',
    [Color(0xFFF016FAA).withOpacity(0.25), Color(0xFFF925EA2).withOpacity(0.25)],
  ),
  City(
    'Singapore',
    'assets/images/welcome_images/profile.jpg',
    [Color(0xFFFB69EDC).withOpacity(0.25), Color(0xFFF3D195C).withOpacity(0.25)],
  ),

];
