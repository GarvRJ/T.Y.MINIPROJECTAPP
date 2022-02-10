import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_ax/animations/fluid_swipe.dart';
import 'package:fuel_ax/utilities/constants.dart';

import '../constants.dart';
import '../otp_page.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {

  String _password, _email,_name, _errormail, _errorname, _errorpass,  _phone;
  bool error = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildLoginBtn(Size size, bool darkMode) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      width: size.width,
      child: MaterialButton(
        color: Colors.black,
        elevation: 5.0,
        onPressed: () => signUp(_email, _password, _phone, _name),
        padding: const EdgeInsets.symmetric(vertical:15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'SIGNUP',
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
    precacheImage(const AssetImage("assets/2.png"), context);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: size.height*0.05,
                ),
                const Image(image: AssetImage('assets/2.png')),
                SizedBox(
                  height: size.height*0.05,
                ),
                TextFormField(
                  onChanged: (input) => {
                    setState((){
                      _name=input;
                    })
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    _formKey.currentState.validate();
                    node.nextFocus();
                  },
                    validator: (input) {
                      return _errorname = ((input.isEmpty)?"Enter User Name":null);
                    },
                    onSaved: (input) => _name = input,
                    onFieldSubmitted: (input) => _name = input,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                      fontFamily: 'OpenSans',
                    ),
                    decoration: kInputStyle('User name', _errorname, Icons.person_rounded)
                ),
                SizedBox(
                  height: size.height*0.05,
                ),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      _formKey.currentState.validate();
                      node.nextFocus();
                    },
                    onChanged: (input) => {
                      setState((){
                        _email=input;
                      })
                    },
                    validator: (input) {
                      return _errormail = ((input.isEmpty)?"Enter E-mail":((input.contains('@'))?null:"Invalid e-mail."));
                    },
                    onSaved: (input) => _email = input,
                    onFieldSubmitted: (input) => _email = input,
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
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      _formKey.currentState.validate();
                      node.unfocus();
                    },
                    onChanged: (input) => {
                      setState((){
                        _password=input;
                      })
                    },
                  validator:(input) => _errorpass = ((input.length>=8)?null:'Password must be at least 8 character long'),
                  onFieldSubmitted: (input) => _password = input,
                  onSaved: (input) => _password = input,
                  obscureText: true,
                  style: const TextStyle(
                    fontFamily: 'OpenSans',
                  ),
                  decoration: kInputStyle('Password', _errorpass, Icons.lock)
                ),
                SizedBox(
                  height: size.height*0.077,
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
        return const FluidSwipe(i:0);
      })),
      child: const Text('Log In'),
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



  Future<void> signUp(String _emailController, String _passwordController, String _phoneController, String _nameController) async {
    final formState = _formKey.currentState;
    const AlertDialog(
      title: Text(
        'Creating account...',
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'openSans',
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold
        ),
      ),
      content: CircularProgressIndicator(),
    );
    formState.validate();
    if (formState.validate()) {
      formState.save();
      if((true)){
      try {
        UserCredential credential = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController, password: _passwordController));
        credential.user.updateDisplayName(_nameController);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return OtpPage();
        }));
      }
      catch (e) {
        int start = e.toString().indexOf('] ');
        showYesNoAlertDialog(context: context,
            titleText: 'Error Signing In!',
            messageText: e.toString().substring(start + 2));
        print(e.toString());
        AlertDialog(title: const Text('Error !'), content: Text(e.toString()));
      }
    }
  }
  }
  /*Future<void> anonymousLogIn() async {
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
        print('Ex');
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
  }*/
}
