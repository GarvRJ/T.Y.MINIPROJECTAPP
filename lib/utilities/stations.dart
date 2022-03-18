import 'dart:convert';
import 'package:http/http.dart';

class Stations {
  final String long;
  final String lat;
  final String address;
  final String name;
  final List<String> services;
  Stations({this.long, this.lat, this.address, this.name, this.services});
  factory Stations.fromJson(Map<String, dynamic> json) {
    return Stations(
        long: json['long'],
        lat: json['lat'],
        address: json['address'],
        name: json['name'],
        services: json['services'],
    );
  }
  static Future<List<Stations>> getStationList(String lat, String long) async {
    var url = Uri.parse('https://pawnest.com/webservice/station.php');
    final response = await post(url,body: {'long':long, 'lat':lat});
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Stations> stations = items.map<Stations>((json) {
      return Stations.fromJson(json);
    }).toList();
    return stations;
  }
}