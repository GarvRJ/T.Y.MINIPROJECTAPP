import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_ax/animations/fluid_swipe.dart';
import 'package:fuel_ax/refresh_widget.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    var listPagesViewModel = [
      PageViewModel(
        title: "Hello",
        body:
            "Welcome to India's first travel accessibility app for all.\nClick 'next' to make your travels smoother.",
        image: const Center(child: Image(image: AssetImage('assets/LOGO.png'))),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
              color: Colors.deepPurple,
              fontSize: 25.0,
              fontWeight: FontWeight.w800),
          bodyTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
      ),
      PageViewModel(
        title: "You Are all Set!",
        body: "Be one of our first users to experience seamless travels.",
        image: const Center(child: Image(image: AssetImage('assets/LOGO.png'))),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
              color: Colors.deepPurple,
              fontSize: 25.0,
              fontWeight: FontWeight.w800),
          bodyTextStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
      /*PageViewModel(
        title: "Bored of Reading?",
        body: "Press the speaker icon to make the app read the news to you!",
        image: const Center(child: Image(image: AssetImage('assets/read.png'))),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.deepOrange,fontSize: 25.0,fontWeight: FontWeight.w800),
          bodyTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
      PageViewModel(
        title: "Want more Shots?",
        body: "Simply pull down from the top most article to fetch more Shots.",
        image: const Center(child: Image(image: AssetImage('assets/refresh.png'))),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.deepOrange,fontSize: 25.0,fontWeight: FontWeight.w800),
          bodyTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
      PageViewModel(
        title: "Something's Left there!",
        body: "Swipe it left to read the full article on the publisher's webpage.",
        image: const Center(child: Image(image: AssetImage('assets/full article.png'))),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.deepOrange,fontSize: 25.0,fontWeight: FontWeight.w800),
          bodyTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
      PageViewModel(
        title: "That's Right",
        body: "Swipe it Right for your topics of interest, those bookmarks you created, and much more!",
        image: const Center(child: Image(image: AssetImage('assets/categories.png'))),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.deepOrange,fontSize: 25.0,fontWeight: FontWeight.w800),
          bodyTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
      PageViewModel(
        title: "That's All!",
        body: "Your Shots are ready. Click on Done.",
        image: const Center(child: Image(image: AssetImage('assets/Tech-ShotsLogo.png'))),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.deepOrange,fontSize: 25.0,fontWeight: FontWeight.w800),
          bodyTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),*/
    ];
    User user = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.black,
            child: Column(
              children: const [
                Center(
                  child: Image(image: AssetImage('/assets/LOGO.png')),
                ),
                CircularProgressIndicator()
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return RefreshWidget(snapshot.error.toString());
        } else {
          SharedPreferences _prefs = snapshot.data as SharedPreferences;
          return Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 38.0, 0.0, 0.0),
                child: IntroductionScreen(
                  globalBackgroundColor: Colors.black,
                  dotsDecorator: const DotsDecorator(
                      spacing:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                      color: Colors.grey,
                      activeColor: Colors.purple),
                  showDoneButton: true,
                  showNextButton: true,
                  showSkipButton: true,
                  next: const Text("Next",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  skip: const Text("Skip",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  pages: listPagesViewModel,
                  done: const Text("Done",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  color: Colors.deepPurple,
                  skipColor: Colors.deepPurpleAccent,
                  doneColor: Colors.deepPurple,
                  nextColor: Colors.purpleAccent,
                  onDone: () {
                    _prefs.setBool('run', true);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => user == null
                                ? const FluidSwipe(
                                    i: 0,
                                  )
                                : const HomePage()));
                  },
                ),
              ));
        }
      },
    );
  }
}
