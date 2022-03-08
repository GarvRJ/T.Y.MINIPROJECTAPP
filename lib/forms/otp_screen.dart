import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_ax/utilities/constants.dart';

import '../home_page.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({Key key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _errorphone, _errortext, _phone, _otp; // ignore: unused_field
  bool error, enable;

  @override
  Widget build(BuildContext context) {
    bool darkMode = MediaQuery.of(context).platformBrightness==Brightness.dark;
    final ThemeData theme = Theme.of(context);
    bool dark = (theme.brightness == Brightness.dark);
    final node = FocusScope.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body:Form(
        key: _formKey,
        child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.only(
    right: 20.0,
    top: 40.0,
    left: 20.0
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Image(image: (dark)?const AssetImage('assets/LOGO.png'):const AssetImage('assets/Tech-ShotsLogo.png')),
      SizedBox(
        height: size.height*0.1,
      ),
      TextFormField(
        onChanged: (input) => {
        setState((){
        _phone=input;
        })
        },
          textInputAction: TextInputAction.done,
          onEditingComplete: () {
            _formKey.currentState.validate();
            _formKey.currentState.save();
            node.nextFocus();
          },
          validator: (input) {
            error = (input.isEmpty);
            return _errorphone = ((input.isEmpty)?"Enter Phone":((input.length==10)?null:"Invalid Phone."));
          },
          onSaved: (input) => _phone = input,
          onFieldSubmitted: (input) => registerUser(input, context),
          keyboardType: TextInputType.phone,
          style: const TextStyle(
            fontFamily: 'OpenSans',
          ),
          decoration: kInputStyle('Phone Number', _errorphone, Icons.phone_rounded)
      ),
      SizedBox(
        height: size.height*0.05,
      ),
      Container(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        width: size.width,
      child: MaterialButton(
        focusColor: Colors.white,
        elevation: 5.0,
        onPressed: () {
         _formKey.currentState.validate()?
         _formKey.currentState.save():
             print("error");
         registerUser(_phone, context);
        },
        padding: const EdgeInsets.symmetric(vertical:15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: darkMode?Colors.orange:Colors.deepOrange,
        child: Text(
          'SEND OTP',
          style: TextStyle(
            color: darkMode?Colors.black:Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
        ),
      Container(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        width: size.width,
        child: MaterialButton(
          focusColor: Colors.white,
          elevation: 5.0,
          onPressed: () =>Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const HomePage()
          )),
          padding: const EdgeInsets.symmetric(vertical:15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: darkMode?Colors.orange:Colors.deepOrange,
          child: Text(
            'Skip Adding Phone',
            style: TextStyle(
              color: darkMode?Colors.black:Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      )
    ]
    )
    )
    )
    )
    );
  }
  Future<void> registerUser(String mobile, BuildContext context) async {
    final GlobalKey<FormState> _otpKey = GlobalKey<FormState>();
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: "+91$mobile",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential authCredential){
          _auth.currentUser.updatePhoneNumber(authCredential);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const HomePage()
          ));
        },
        verificationFailed: (authException){
          print(authException.message);
        },
        codeSent: (verificationId, token){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                  title: const Text("Enter SMS Code"),
                  content: TextFormField(
                    key: _otpKey,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    onEditingComplete: () {
                      _otpKey.currentState.validate()?
                      _otpKey.currentState.save():
                      print('Error');
                    },
                    onChanged: (otp){
                      _otp = otp;
                    },
                    validator: (otp) {
                      return _errortext = ((otp.isEmpty)?"Enter OTP":null);
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Done"),
                      onPressed: () {
                        String smsCode = _otp;
                        print(smsCode);
                        PhoneAuthCredential _phoneCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                        _auth.currentUser.updatePhoneNumber(_phoneCredential);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                          return const HomePage();}));
                        },
                    )
                  ]
              )
          );
        }, codeAutoRetrievalTimeout: (String verificationId) {  },
    );
  }
}