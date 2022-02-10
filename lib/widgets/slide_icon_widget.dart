import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SlideIconWidget extends StatelessWidget {
  final String ind;

  const SlideIconWidget({Key key, this.ind}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
          const Icon(Icons.arrow_back_ios),
          RotatedBox(
            quarterTurns: 3,
            child: Text(ind ,
              textAlign: TextAlign.right)
          )
        ]
      ),
    );
  }
}
