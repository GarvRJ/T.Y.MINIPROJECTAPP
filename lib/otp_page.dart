import 'package:flutter/material.dart';

import 'forms/otp_screen.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OtpScreen(),
    );
  }
}
