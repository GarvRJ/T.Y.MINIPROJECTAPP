import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username, email, password;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FlipCard(
            direction: (size.width>800)?FlipDirection.VERTICAL:FlipDirection.HORIZONTAL,
            key: cardKey,
            flipOnTouch: false,
            front:Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              borderOnForeground: true,
              shadowColor: Colors.black,
              color: Colors.white,
              elevation: 10.0,
              child: SizedBox(
                width: size.width*0.9,
                height: size.height*0.9,
                child: Flex(
                  direction: (size.width>800)?Axis.horizontal:Axis.vertical,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(topLeft: const Radius.circular(15.0),bottomLeft: (size.width>800)?const Radius.circular(15.0):const Radius.circular(0.0), topRight: (size.width>800)?const Radius.circular(0.0):const Radius.circular(15.0),)
                      ),
                      height: size.height*0.4,
                      width: size.width*0.9,
                      child: const Padding(
                            padding: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 50.0, top: 0.0),
                            child:Image(image: AssetImage('assets/LOGO.png'), fit: BoxFit.fitHeight,)
                          ),
                    ),
                    SizedBox(
                      height: size.height*0.05,
                    ),
                    SizedBox(
                      height: size.height*0.4,
                      width: size.width*0.9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text(
                                          "Sign Up",
                                        ),
                                        Icon(Icons.arrow_forward_ios_rounded)
                                      ]
                                  )
                              ),
                              onPressed: () => cardKey.currentState!.toggleCard(),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shadowColor: Colors.white,
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            TextField(
                              onChanged:(input)=> setState((){
                                email = input;
                              }),
                              style: const TextStyle(
                                  color: Colors.black
                              ),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
                                contentPadding: const EdgeInsets.only(left: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            TextField(
                              onChanged:(input)=> setState((){
                                password = input;
                              }),
                              obscureText: true,
                              style: const TextStyle(
                                  color: Colors.black
                              ),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
                                contentPadding: const EdgeInsets.only(left: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              child: const SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Center(child: Text("Sign In"))),
                              onPressed: () => login(email, password),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            /*TextFormField(
                                style: TextStyle(
                                  color: Colors.black
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hoverColor: Colors.red,
                                ),
                              ),
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(
                                    color: Colors.black
                                ),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hoverColor: Colors.red,
                                ),
                              ),
                              MaterialButton(
                                color: Colors.orange,
                                  disabledColor: Colors.deepOrange,
                                  onPressed: login(),
                                  child: Text(
                                    'LOGIN'
                                  )
                              )*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            back: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              borderOnForeground: true,
              shadowColor: Colors.black,
              color: Colors.white,
              elevation: 10.0,
              child: SizedBox(
                width: size.width*0.9,
                height: size.height*0.9,
                child: Flex(
                  direction: (size.width>800)?Axis.horizontal:Axis.vertical,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(topLeft: const Radius.circular(15.0),bottomLeft: (size.width>800)?const Radius.circular(15.0):const Radius.circular(0.0), topRight: (size.width>800)?const Radius.circular(0.0):const Radius.circular(15.0),)
                      ),
                      height: size.height*0.4,
                      width: size.width*0.9,
                      child:const Padding(
                            padding: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 50.0, top: 0.0),
                            child: Image(image: AssetImage('assets/LOGO.png'), fit: BoxFit.fitHeight,),
                          ),
                    ),
                    SizedBox(
                      height: size.height*0.05,
                    ),
                    SizedBox(
                      height: size.height*0.4,
                      width: size.width*0.9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: const [
                                        Icon(Icons.arrow_back_ios_rounded),
                                        Text(
                                          "Log In",
                                        ),
                                      ]
                                  )
                              ),
                              onPressed: () => cardKey.currentState!.toggleCard(),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shadowColor: Colors.white,
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            TextField(
                              keyboardType: TextInputType.name,
                              onChanged:(input)=> setState((){
                                username = input;
                              }),
                              style: const TextStyle(
                                  color: Colors.black
                              ),
                              decoration: InputDecoration(
                                labelText: 'User Name',
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
                                contentPadding: const EdgeInsets.only(left: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged:(input)=> setState((){
                                email = input;
                              }),
                              style: const TextStyle(
                                  color: Colors.black
                              ),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
                                contentPadding: const EdgeInsets.only(left: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            TextField(
                              onChanged:(input)=> setState((){
                                password = input;
                              }),
                              obscureText: true,
                              style: const TextStyle(
                                  color: Colors.black
                              ),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
                                contentPadding: const EdgeInsets.only(left: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              child: const SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Center(child: Text("Sign Up"))),
                              onPressed: () => signUp(username, email, password),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            /*TextFormField(
                                style: TextStyle(
                                  color: Colors.black
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hoverColor: Colors.red,
                                ),
                              ),
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(
                                    color: Colors.black
                                ),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hoverColor: Colors.red,
                                ),
                              ),
                              MaterialButton(
                                color: Colors.orange,
                                  disabledColor: Colors.deepOrange,
                                  onPressed: login(),
                                  child: Text(
                                    'LOGIN'
                                  )
                              )*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        )
    );
  }
  forgotPassword(){

  }

  login(String emailController, String passwordController) async {
      try {
        User? user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: emailController, password: passwordController))
        .user;
        print(user!.uid);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder :(_) {
          return const HomePage();
        }));
    }
    catch(e){
    print(e.toString());
    }
  }
  signUp(String nameController, String emailController, String passwordController) async {
    try {
      User? user = (await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailController, password: passwordController))
          .user;
      user!.updateDisplayName(nameController);
      print(user.uid);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder :(_) {
        return const HomePage();
      }));
    }
    catch(e){
      print(e.toString());
    }
  }
}
