import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_ax/widgets/RatingScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../constants.dart';
import 'listings.dart';

class ListingExpanded extends StatefulWidget {
  final String name;
  final String distance;
  final String lat;
  final String long;
  final int cars;
  final int bikes;
  final bool petrol;
  final bool diesel;
  final bool petrolSpeed;
  final bool cng;
  final bool air;

  const ListingExpanded(
      {Key key,
      this.name,
      this.distance,
      this.cars,
      this.bikes,
      this.petrol,
      this.diesel,
      this.petrolSpeed,
      this.cng,
      this.air,
      this.lat,
      this.long})
      : super(key: key);

  @override
  _ListingExpandedState createState() => _ListingExpandedState(name, distance,
      cars, bikes, petrol, diesel, petrolSpeed, cng, air, lat, long);
}

class _ListingExpandedState extends State<ListingExpanded> {
  final String name;
  final String distance;
  final String lat;
  final String long;
  final int cars;
  final int bikes;
  final bool petrol;
  final bool diesel;
  final bool petrolSpeed;
  final bool cng;
  final bool air;
  bool open = false;
  final double rating = 4.5;

  _ListingExpandedState(
      this.name,
      this.distance,
      this.cars,
      this.bikes,
      this.petrol,
      this.diesel,
      this.petrolSpeed,
      this.cng,
      this.air,
      this.lat,
      this.long);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () => setState(() {
                  open = !open;
                }),
            child: Listing(
                name: name,
                distance: distance,
                cars: cars,
                bikes: bikes,
                open: open)),

        open
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  children: [
                    Text(
                      rating.toString(),
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    Icon(
                      Icons.star,
                      color: kPrimaryColor,
                    ),
                    SizedBox(width: 15.0,),
                    TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible:
                                true, // set to false if you want to force a rating
                            builder: (context) => RatingScreen(),
                          );
                        },
                        child: Text('Rate'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: kPrimaryColor,
                      ),
                    )
                  ],
                ),
            )
            : SizedBox(),
        open
            ? Container(
                height: size.height * 0.3,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    image: DecorationImage(
                        image: AssetImage('assets/nav.png'),
                        fit: BoxFit.cover)),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      alignment: Alignment.topCenter,
                      color: Colors.black.withOpacity(0.4),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20.0),
                            child: TextButton(
                              onPressed: () => {launchMaps(lat, long)},
                              child: Text(
                                "NAVIGATE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
            : SizedBox(
                height: 0,
                width: 0,
              )
      ],
    );
  }

  launchMaps(String lat, String long) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    String appleUrl = 'https://maps.apple.com/?sll=$lat,$long';
    if (await canLaunch("https://www.google.com/maps/")) {
      print('launching com googleUrl');
      await launch(googleUrl);
    } else if (await canLaunch(appleUrl)) {
      print('launching apple url');
      await launch(appleUrl);
    } else {
      print('Could not launch url');
    }
  }
}
