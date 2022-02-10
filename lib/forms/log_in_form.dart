import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_ax/animations/fluid_swipe.dart';
import 'package:fuel_ax/utilities/constants.dart';

import '../constants.dart';
import '../home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  String _password, _errormail, _email, _errorpass;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildLoginBtn(Size size, bool darkMode) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      width: size.width,
      child: MaterialButton(
        color: Colors.black,
        focusColor: Colors.white,
        elevation: 5.0,
        onPressed: () => logIn(_email, _password),
        padding: const EdgeInsets.symmetric(vertical:15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: kPrimaryColor,
            letterSpacing: 1.5,
            fontSize: size.height*0.02,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  /*Widget _buildSkipBtn(Size size, bool darkMode) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      width: size.width,
      child: MaterialButton(
        color: darkMode?Colors.orange:Colors.deepOrange,
        focusColor: Colors.white,
        elevation: 5.0,
        onPressed: () => anonymousLogIn(),
        padding: const EdgeInsets.symmetric(vertical:15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'Skip For Now',
          style: TextStyle(
              fontSize: size.height*0.02,
              color: darkMode?Colors.black:Colors.white
          ),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/1.png"), context);
    bool darkMode = MediaQuery.of(context).platformBrightness==Brightness.dark;
    final node = FocusScope.of(context);
    Size size = MediaQuery.of(context).size;
    return Form(
    key: _formKey,
    child: SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        right: 40.0,
        top: 0.0,
        left: 40.0
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: size.height*0.05,
            ),
            const Image(image: AssetImage('assets/1.png')),
            SizedBox(
              height: size.height*0.05,
            ),
            TextFormField(
                onFieldSubmitted: (input){
                  if(input.contains('@')){
                    _email = input;
                  }
                },
                onChanged: (input) => {
                  setState((){
                    _email=input;
                  })
                },
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
    node.nextFocus();
    _formKey.currentState.validate();
    },
                validator: (input) => _errormail = ((input.isEmpty)?"Enter E-mail":(input.contains('@')?null:'Invalid E-mail')),
                onSaved: (input) => _email = input,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                fontFamily: 'OpenSans',
                ),
                decoration: kInputStyle('E-Mail Address', _errormail, Icons.mail)

            ),
            SizedBox(
              height: size.height*0.05,
            ),
            TextFormField(
              onFieldSubmitted: (input){
                if(input.length>=8){
                  _password = input;
                }
              },
                onChanged: (input) => {
                  setState((){
                    _password=input;
                  })
                },
                onEditingComplete: ()=> node.unfocus(),
                validator:(input) => _errorpass = ((input.length>=8)?null:'Password must be at least 8 character long'),
                onSaved: (input) => _password = input,
                obscureText: true,
                style: const TextStyle(
                  fontFamily: 'OpenSans',
                ),
                decoration: kInputStyle('Password', _errorpass, Icons.lock)
            ),
            SizedBox(
              height: size.height*0.2,
            ),
            _buildLoginBtn(size, darkMode),
          ],
        ),
      )
    ),
    );
  }

  Future<void> showYesNoAlertDialog({
    @required BuildContext context,
    @required String titleText,
    @required String messageText,
  }) async {
    // set up the buttons
    final Widget yesButton = TextButton(
      onPressed: () => Navigator.pop(context, 'Ok'),
      child: const Text('Ok'),
    );
    final Widget signupButton = TextButton(
      onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder :(_) {
        return const FluidSwipe(i:1);
      })),
      child: const Text('Sign Up'),
    );

    // set up the AlertDialog
    final alert = AlertDialog(
      title: Text(titleText),
      content: Text(messageText),
      actions: [
        yesButton,
        signupButton,
      ],
    );

    // show the dialog
    return showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  Future<void> logIn(String _emailController, String _passwordController) async {
    try {
      print(_emailController);
      (await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _emailController, password: _passwordController))
          .user;
      //add_user call here to get device details
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder :(_) {
        return const HomePage();
      }));
    }
    catch(e){
      int start = e.toString().indexOf('] ');
      showYesNoAlertDialog(context: context, titleText: 'Error Signing In!', messageText: e.toString().substring(start+2));
      print(e.toString());
      AlertDialog(title: const Text('Error !'),content: Text(e.toString()));
    }
  }
  Future<void> anonymousLogIn() async {
    const AlertDialog(
      title: Text(
        'Logging In...',
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'openSans',
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold
        ),
      ),
      content: CircularProgressIndicator(),
    );
    try {
      (await FirebaseAuth.instance
          .signInAnonymously())
          .user;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder :(_) {
        return const HomePage();
      }));
    }
    catch(e){
      int start = e.toString().indexOf('] ');
      showYesNoAlertDialog(context: context, titleText: 'Error Signing In!', messageText: e.toString().substring(start+2));
      print(e.toString());
      AlertDialog(title: const Text('Error !'),content: Text(e.toString()));
    }
  }
}
