import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {
  final String district;
  final List<Products> products;
  Api({@required this.district, @required this.products});
  factory Api.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<Products> productList = list.map((e) => Products.fromJson(e)).toList();
    return Api(
      district: json['district'],
      products: productList
    );
  }
  static Future<List<Api>> getPrices(String query) async{
    var url = "https://fuelprice-api-india.herokuapp.com/price/$query";
    Uri pr = Uri.parse(url);
    var response = await http.get(pr);
    print(response.body);
    var items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Api> api = items.map<Api>((json){
      return Api.fromJson(json);
    }).toList();
    print(items);
    return api;
  }


}

class Products {
  final String productName;
  final String productPrice;
  Products({@required this.productName, @required this.productPrice});
  factory Products.fromJson(Map<String, dynamic> json){
    return Products(
        productName:json['productName'],
        productPrice:json['productPrice']
    );
  }
}