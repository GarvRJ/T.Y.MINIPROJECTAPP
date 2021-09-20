import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fuel_ax/refresh_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'load_screen.dart';
import 'login_page.dart';
import 'onboarding_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool _run = (_prefs.getBool('run')??false);
  runApp(MyApp(_run));
}

class MyApp extends StatelessWidget {
  final bool _run;
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  final User? user = FirebaseAuth.instance.currentUser;
  MyApp(this._run);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel AX',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple
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
              return const LoginPage();
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
      OnboardingPage()
    );
  }
}
