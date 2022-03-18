import 'package:flutter/material.dart';
import 'package:fuel_ax/register_vehicles_screen.dart';
import 'package:fuel_ax/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';
import 'main.dart';

class NewVehicle extends StatefulWidget {

  @override
  State<NewVehicle> createState() => _NewVehicleState();
}

class _NewVehicleState extends State<NewVehicle> {

  final _auth=FirebaseAuth.instance;
  User loggedInUser=FirebaseAuth.instance.currentUser;
  final _firestore=FirebaseFirestore.instance;

  List<ListItem> _dropdownItemsFuelType = [
    ListItem("Petrol", "Petrol"),
    ListItem("Diesel", "Diesel"),
    ListItem("CNG", "CNG"),
  ];

  List<ListItem> _dropdownItemsVehicleType = [
    ListItem("2", "2-Wheeler"),
    ListItem("4", "4-Wheeler"),
  ];



  String dropDownValue1;

  String dropDownValue2;

  TextEditingController textController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<DropdownMenuItem<ListItem>> _dropdownMenuItemsFuelType;
  ListItem _selectedItemFuelType;

  List<DropdownMenuItem<ListItem>> _dropdownMenuItemsVehicleType;
  ListItem _selectedItemVehicleType;
  
  String carNumber='';

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name,style: TextStyle(color: Colors.white),),
          value: listItem,
        ),
      );
    }
    return items;
  }



  @override
  void initState() {
    super.initState();
    _dropdownMenuItemsFuelType = buildDropDownMenuItems(_dropdownItemsFuelType);
    _selectedItemFuelType = _dropdownMenuItemsFuelType[0].value;
    data.registeredVehicles=[];
    _dropdownMenuItemsVehicleType = buildDropDownMenuItems(_dropdownItemsVehicleType);
    _selectedItemVehicleType = _dropdownMenuItemsVehicleType[0].value;
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.35,
                          decoration: BoxDecoration(
                            color: Color(0xFF21192E),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, -0.7),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            color: Colors.transparent,
                                            border: Border.all(),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: DropdownButton(
                                              dropdownColor: Color(0xFF21192E),
                                              style: TextStyle(
                                                color: Colors.white
                                              ),
                                                value: _selectedItemFuelType,
                                                items: _dropdownMenuItemsFuelType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedItemFuelType=value;
                                                  });
                                                }
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: AlignmentDirectional(0, -0.7),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 30, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.transparent,
                                          border: Border.all(),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: DropdownButton(
                                              dropdownColor: Color(0xFF21192E),
                                                style: TextStyle(
                                                    color: Colors.white
                                                ),
                                                value: _selectedItemVehicleType,
                                                items: _dropdownMenuItemsVehicleType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedItemVehicleType=value;
                                                  });
                                                }
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.9, 0),
                                child: Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                  child: Text(
                                    'Vehicle Number',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.characters,
                                  onChanged: (value)
                                  {
                                    carNumber=value;
                                  },
                                  controller: textController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Vehicle Number',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    suffixIcon: textController.text.isNotEmpty
                                        ? InkWell(
                                      onTap: ()
                                      {
                                        textController.clear();
                                        setState(() {

                                        });
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    )
                                        : null,
                                  ),
                                  style:
                                  TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.3,vertical: 20),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEEEEEE),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                        )
                                      ],
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () async{
                                        print("this was called");
                                        data.addVehicles(int.parse(_selectedItemVehicleType.value), _selectedItemFuelType.value, carNumber);
                                        textController.clear();
                                        carNumber='';
                                        print("number of vehicles ${VehicleData().registeredVehicles.length}");
                                        setState(() {

                                        });
                                      },
                                      child: kAddButton,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Center(
                        child: Text(
                          'Your Vehicles',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                      itemCount: data.registeredVehicles.length,
                        itemBuilder:(context,index)
                            {
                              return Padding(
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
                                                    'Vehicle Number : ${data.registeredVehicles[index].VehicleNumber}',
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
                                                    'Vehicle Type : ${data.registeredVehicles[index].tireCount}-Wheeler',
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
                                                    'Fuel Type : ${data.registeredVehicles[index].fuelType}',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: TextButton(onPressed: (){
                                              data.deletedVehicle(index);
                                              setState(() {

                                              });
                                            },
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFEEEEEE),
                                                    ),
                                                    child: Align(
                                                      alignment: AlignmentDirectional(0, 0),
                                                      child: Text(
                                                        'Delete Vehicle',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Color(0xFFFF0005),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )

                                            ),
                                          )
                                        ],
                                      )
                                )),
                              );
                            }
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width * 0.3,vertical: 20),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () async{
                          int length=data.registeredVehicles.length;
                          for(int i=0;i<length;i++)
                            {
                              var vehicles=data.registeredVehicles[i];
                              await _firestore.collection('RegisteredVehicles').doc('AEjxXIUbqA3H6MtR47iI').collection(loggedInUser.email).add(
                                {
                                  'VehicleNumber':vehicles.VehicleNumber,
                                  'VehicleType' : vehicles.tireCount,
                                  'FuelType': vehicles.fuelType
                                }
                              );
                            }
                          data.registeredVehicles.clear();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => const HomePage()));
                        },
                        child: kSubmitButton,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem {
  String value;
  String name;

  ListItem(this.value, this.name);

}