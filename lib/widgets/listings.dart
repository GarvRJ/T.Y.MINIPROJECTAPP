import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fuel_ax/constants.dart';

class Listing extends StatefulWidget {
  final String name;
  final String distance;
  final int cars;
  final int bikes;
  final bool open;

  const Listing({Key key, this.name, this.distance, this.cars, this.bikes, this.open}) : super(key: key);
  @override
  _ListingState createState() => _ListingState(name, distance, cars, bikes, open);
}

class _ListingState extends State<Listing> {
  final String name;
  final String distance;
  final int cars;
  final int bikes;
  final bool open;

  _ListingState(this.name, this.distance, this.cars, this.bikes, this.open);

  TextStyle listStyle = TextStyle(
      color: kPrimaryColor,
      fontSize: 20.0
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 100.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width*0.3,
              child: Text(
                name,
                style: listStyle
              ),
            ),
            FaIcon(
              FontAwesomeIcons.map,
              color: kPrimaryColor,
            ),
            Text(distance, style: listStyle,),
            FaIcon(
              FontAwesomeIcons.car,
              color: kPrimaryColor,
            ),
            Text(cars.toString(), style: listStyle,),
            FaIcon(
              FontAwesomeIcons.biking,
              color: kPrimaryColor,
            ),
            Text(bikes.toString(), style: listStyle,),
            Icon(
              open?Icons.keyboard_arrow_up_rounded:Icons.keyboard_arrow_down_rounded,
              color: kPrimaryColor
            )
          ],
        ),
      ),
    );
  }
}
