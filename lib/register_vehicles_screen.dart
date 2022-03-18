import 'package:flutter/material.dart';
import 'package:fuel_ax/new_register_vehicle_widget.dart';

class RegisterVehicleScreen extends StatefulWidget {

  @override
  _RegisterVehicleScreenState createState() => _RegisterVehicleScreenState();
}

class _RegisterVehicleScreenState extends State<RegisterVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: NewVehicle(),
      ),
    );
  }
}

VehicleData data=VehicleData();

class RV
{
  RV({this.tireCount,this.fuelType,this.VehicleNumber});
  int tireCount;
  String fuelType;
  String VehicleNumber;
}

class VehicleData
{
  List<RV> registeredVehicles=[];

  void addVehicles(int tireCount,String fuelType,String carNumber) {
    final newVehicle = RV(
        tireCount: tireCount, fuelType: fuelType, VehicleNumber: carNumber);
    registeredVehicles.add(newVehicle);
    print("the number of vehicles is ${registeredVehicles.length}");
  }

  void deletedVehicle(int index)
  {
    registeredVehicles.removeAt(index);
  }


}
