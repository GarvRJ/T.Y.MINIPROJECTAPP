import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class RefreshWidget extends StatelessWidget {
  final String error;
  RefreshWidget(this.error);
  @override
  Widget build(BuildContext context) {
    bool darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
    backgroundColor: darkMode?Colors.black:Colors.white,
      leading: IconButton(
          onPressed: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder :(_) {
            return const HomePage();
          })),
          icon: Icon(Icons.arrow_back_ios, color: darkMode?Colors.white:Colors.black,)),
    ),
      body: Center(
        child:Text(error, style: const TextStyle(
            color: Colors.red
          )
        ),
      ),
    );
  }
}
