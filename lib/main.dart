import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel_ax/animations/fluid_swipe.dart';
import 'package:fuel_ax/constants.dart';
import 'package:fuel_ax/refresh_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'load_screen.dart';
import 'onboarding_page.dart';

Future<void> main() async{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kPrimaryColor,
    systemNavigationBarColor: kPrimaryColor,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool _run = (_prefs.getBool('run')??false);
  runApp(MyApp(_run));
}

class MyApp extends StatelessWidget {
  final bool _run;
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  final User user = FirebaseAuth.instance.currentUser;
  MyApp(this._run, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fuel AX',
      theme: ThemeData(
        primaryColor: kPrimaryColor
      ),
      darkTheme: ThemeData(
        primaryColor: kPrimaryColor
      ),
      themeMode: ThemeMode.dark,
      home: _run?
      FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot){
          if(snapshot.hasError){
            return RefreshWidget(snapshot.error.toString());
          }
          else if (snapshot.hasData){
            if (user==null){
              return const FluidSwipe(i:0);
            }
            else{
              return const HomePage();
            }
          }
          else{
            return const LoadScreen();
          }
        }
      )
      :
      const OnboardingPage()
    );
  }
}
