
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_ax/sign_up_screen.dart';
import 'package:fuel_ax/widgets/slide_icon_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../login_screen.dart';

class FluidSwipe extends StatefulWidget {
  static const style = TextStyle(
    fontSize: 30,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );
  final int i;
  const FluidSwipe({Key key, this.i}) : super(key: key);
  @override
  _FluidSwipeState createState() => _FluidSwipeState(i);
}

class _FluidSwipeState extends State<FluidSwipe> {
  final int i;
  _FluidSwipeState(this.i);
  LiquidController liquidController;
  UpdateType updateType;
  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  final pages = [
    const LoginScreen(),
    const SignUpScreen()
  ];

  Widget _buildDot(int index) {
    return Container();
  }
  int page;
  @override
  Widget build(BuildContext context) {
    page = i;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe(
            initialPage: i,
            enableLoop: true,
            slideIconWidget: SlideIconWidget(ind: (page==0)?'SIGN UP':'LOG IN'),
            positionSlideIcon: 0.48,
            pages: pages,
            onPageChangeCallback: (a) => pageChangeCallback(a),
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            ignoreUserGestureWhileAnimating: true,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(pages.length, _buildDot),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
