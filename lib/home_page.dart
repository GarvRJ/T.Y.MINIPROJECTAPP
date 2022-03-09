import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:fuel_ax/account_page.dart';
import 'package:fuel_ax/animations/fluid_swipe.dart';
import 'package:fuel_ax/plan_a_trip.dart';
import 'package:fuel_ax/widgets/listing_expanded.dart';
//import 'package:http/http.dart' as http;

import 'api.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> states = [
    "Andaman-&-Nicobar","Andhra-Pradesh","Arunachal-Pradesh","Assam","Bihar","Chandigarh","Chhatisgarh","Dadra-Nagarhaveli","Daman-Diu","Delhi","Goa","Gujarat","Haryana","Himachal-Pradesh","Jammu-&-Kashmir","Jharkhand","Karnataka","Kerala","Madhya-Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Pondicherry","Punjab","Rajasthan","Sikkim","Tamil-Nadu","Telangana","Tripura","Uttar-Pradesh","Uttarakhand","West-Bengal"
  ];
  List<String> cities = [
    "SANGLI","PUNE","AURANGABAD","AHMADNAGAR","JALGAON","NANDURBAR","DHULE","NASHIK","KOLHAPUR","SINDHUDURG","SATARA","LATUR","JALNA","BID","PALGHAR","NAGPUR","CHANDRAPUR","WARDHA","AMRAVATI","YAVATMAL","AKOLA","THANE","RAIGARH","RATNAGIRI","GREATER+MUMBAI","MUMBAI+CITY","OSMANABAD","SOLAPUR","GADCHIROLI","GONDIA","NANDED","HINGOLI","BULDHANA","PARBHANI","BHANDARA","WASHIM"
  ];
  List<Api> _api = [
    Api(
      district: "MUMBAI+CITY",
      products: [
        Products(
            productPrice: '112.11',
            productName: 'Petrol'
        ),
        Products(
          productName: 'Diesel',
          productPrice: '102.89'
        )
      ]
    )
  ];

  String state = "Maharashtra";
  String city = "MUMBAI+CITY";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    bool darkMode = MediaQuery.of(context).platformBrightness==Brightness.dark;
    return Scaffold(
      extendBody: false,
      bottomSheet: Container(
        color: darkMode?Colors.black:Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: (
            ElevatedButton(
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.map_rounded),
                        SizedBox(
                          width:15
                        ),
                        Text(
                          "Plan A Trip",
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 25,
                        )
                      ]
                  )
              ),
              onPressed: () => {
                Navigator.push(context, SlideRightRoute(page: const Trip()))
              },
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.white,
                onPrimary: darkMode?Colors.black:Colors.white,
                primary: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top:Radius.circular(20)),
                ),
              ),
            )
        ),
      ),
      key: scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text('Services Coming Soon',
                 style: TextStyle(
                   fontSize: 30.0,
                   fontWeight: FontWeight.bold,
                   fontStyle: FontStyle.italic,
                   color: darkMode?Colors.black:Colors.white,
                 ),
                ),
                ElevatedButton(
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.west_rounded),
                            Spacer(

                            ),
                            Text(
                              "Sign Out",
                            ),
                          ]
                      )
                  ),
                  onPressed: () => signOut(),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.white,
                    primary: darkMode?Colors.black:Colors.white,
                    onPrimary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: darkMode?Colors.black:Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {
            scaffoldKey.currentState?.openDrawer()
          },
            icon: Icon(Icons.view_module_rounded, color: darkMode?Colors.black:Colors.white,),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text('Fuel AX'),
        titleTextStyle: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: darkMode?Colors.black:Colors.white,
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
        Container(
        margin: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
        // It will cover 20% of our total height
        height: size.height * 0.2,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 36 + kDefaultPadding,
              ),
              height: size.height * 0.2 - 27,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Hi ${FirebaseAuth.instance.currentUser.displayName}',
                    style: Theme.of(context).textTheme.headline5.
                    copyWith(
                        color: darkMode?Colors.black:Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.supervised_user_circle_rounded, color: darkMode?Colors.black:Colors.white, size: 50.0,),
                    onPressed: () =>
                      {Navigator.push(context, ScaleRoute(page: const AccountPage()))}
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                  color: darkMode?Colors.black:Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Icon(Icons.location_on_rounded, color: kPrimaryColor),
                    Expanded(
                      //State
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Colors.black,
                              onChanged: (String newVal) => {
                                setState((){
                                  state = newVal;
                                })
                              },
                              style: TextStyle(
                                color: kPrimaryColor
                              ),
                              value: state,
                              items: states.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(color:kPrimaryColor, fontSize: 12.0),),
                                    );
                                  }
                              ).toList(),
                            ),
                          ),
                      ),
                    ),
                    Expanded(
                      //City
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.black,
                            onChanged: (String newVal) => {
                              setState((){
                                city = newVal;
                              })
                            },
                            style: TextStyle(
                                color: kPrimaryColor
                            ),
                            value: city,
                            items: cities.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(color:kPrimaryColor, fontSize: 12.0),),
                                  );
                                }
                            ).toList(),
                          ),
                      ),
                    )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
    ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        shadowColor: Colors.purpleAccent,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Colors.deepPurple,
                                    Colors.purpleAccent
                                  ]
                              )
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                          height: 200,
                          width: size.width*0.75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(image: AssetImage(darkMode?'assets/fuelDark.png':'assets/fuelLight.png'),width: 100, height: 100,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Petrol/L',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40.0,
                                    color: darkMode?Colors.black:Colors.white
                                  ),
                                  ),
                                  Text(_api.first.products.first.productPrice,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0,
                                      color: darkMode?Colors.black:Colors.white
                                  ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        shadowColor: Colors.greenAccent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.green,
                                Colors.lightGreenAccent
                              ]
                            )
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                          height: 200,
                          width: size.width*0.75,
                          child: Row(
                            children: [
                              Image(image: AssetImage(darkMode?'assets/fuelDark.png':'assets/fuelLight.png'),width: 100, height: 100,),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Diesel/L',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40.0,
                                        color: darkMode?Colors.black:Colors.white
                                    ),
                                  ),
                                  Text(_api.first.products[1].productPrice,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0,
                                        color: darkMode?Colors.black:Colors.white
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]
                ),

              ),
            ),
            ListingExpanded(name:"Station A", distance: "1.1Km", cars: 2, bikes: 0, lat: "19.044197669339596",long: "72.86488164388184",),
            ListingExpanded(name: "Station B", distance: "0.7Km", cars: 8, bikes: 8, lat: "19.044197669339596",long: "72.86488164388184",),
            ListingExpanded(name: "Station C", distance: "4.2Km", cars: 6, bikes: 4, lat: "19.069033583153775",long: "72.90106916299065",),
            ListingExpanded(name: "Station D", distance: "6.3Km", cars: 5, bikes: 0, lat: "19.06208599623719",long: "72.83572854831618",),
            ListingExpanded(name: "Station E", distance: "21.3Km", cars: 2, bikes: 3, lat: "19.178550012825163",long: "72.94489883147799",),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      )
    );
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder :(_) {
      return const FluidSwipe(i:0);
    }));
  }
}

class SlideRightRoute  extends PageRouteBuilder{
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        ScaleTransition(
          alignment: Alignment.topRight,
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        ),
  );
}
/*
Future<List<String>> getStates() async{
  String url = "https://fuelprice-api-india.herokuapp.com";
  Uri st = Uri.parse("$url/states");
  var response = await http.get(st);
  var items = json.decode(response.body);
  return items;
}

Future<List<String>> getCities(String state) async{
  var url = "https://fuelprice-api-india.herokuapp.com/$state/districts";
  Uri ct = Uri.parse(url);
  var response = await http.get(ct);
  var items = json.decode(response.body);
  return items;
}
*/