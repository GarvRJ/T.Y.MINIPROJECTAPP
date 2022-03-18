import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_ax/register_vehicles_screen.dart';

import 'constants.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final _auth=FirebaseAuth.instance;
  User loggedInUser=FirebaseAuth.instance.currentUser;
  final _firestore=FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool darkMode = MediaQuery.of(context).platformBrightness==Brightness.dark;
    return Scaffold(
      backgroundColor: darkMode?Colors.black:Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {
          Navigator.pop(context)
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkMode?Colors.black:Colors.white,),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text('Travel AX'),
        titleTextStyle: TextStyle(
          fontSize: 30.0,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.supervised_user_circle_rounded, color: darkMode?Colors.black:Colors.white, size: 100.0,),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            FirebaseAuth.instance.currentUser.displayName,
                            style: Theme.of(context).textTheme.headline5.
                            copyWith(color: darkMode?Colors.white:Colors.black, fontWeight: FontWeight.bold),
                          ),
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
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'User Email',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: darkMode?Colors.white:Colors.black,
                            ),
                          ),
                          Text(
                            FirebaseAuth.instance.currentUser.email,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: darkMode?Colors.white:Colors.black,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Registered Vehicles',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: darkMode?Colors.white:Colors.black,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: _firestore.collection('RegisteredVehicles').doc('AEjxXIUbqA3H6MtR47iI').collection(loggedInUser.email).snapshots(),
                            builder: (context,snapshot)
                            {
                              List<Widget> VehicleWidget=[];
                              data.registeredVehicles=[];
                              List<QueryDocumentSnapshot<Object>> vehicles = snapshot.data.docs;

                              for(var v in vehicles)
                                {
                                  final details =v.data() as Map;
                                  final tireCount=details['VehicleType'];
                                  final fuelType=details['FuelType'];
                                  final vehicleNumber=details['VehicleNumber'];
                                  data.registeredVehicles.add(RV(tireCount: tireCount,fuelType: fuelType,VehicleNumber: vehicleNumber));
                                  VehicleWidget.add(Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        height: MediaQuery.of(context).size.height * 0.17,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF21192E),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 1,
                                          ),
                                        ),
                                        child: (
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                        child: Text(
                                                          'Vehicle Number : ${vehicleNumber}',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                        child: Text(
                                                          'Vehicle Type : ${tireCount}-Wheeler',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                        child: Text(
                                                          'Fuel Type : ${fuelType}',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                        )),
                                  ));
                                }
                              return Column(
                                children: VehicleWidget,
                              );
                            }
                            ,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ),
            ),

          ],
        ),
      )
    );
  }
}


