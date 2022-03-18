import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Reviews {
  static void addRating(String station_id, double rating, String review) async{
    var url = Uri.parse('https://pawnest.com/webservice/station.php');
    final response = await post(url,body: {'sid': station_id, 'rating': rating, 'review': review});
    print(response.body);
  }
}