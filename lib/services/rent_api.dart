import 'dart:convert';

import 'package:car_rental/model/renting_model.dart';
import 'package:car_rental/utils/configs.dart';
import 'package:car_rental/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// class SearchProduct extends ChangeNotifier {
List<RequestAttendance>? _check = [];
List<RequestAttendance>? get value => _check;

Future<dynamic> rentProduct(
  String name,
  String image,
  String price,
  String product,
  String address,
  String city,
  String postalCode,
  String country,
  String durationFrom,
  String durationTo,
  context,
) async {
  var body = {
    "rentItem": {
      "name": name,
      "image": image,
      "price": price,
      "product": product,
    },
    "pickingAddress": {
      "address": address,
      "city": city,
      "postalCode": postalCode,
      "country": country
    },
    "durationFrom": durationTo,
    "durationTo": durationTo
  };
  String? token = await SharedServices.loginDetails();
  var response = await http.post(
    Uri.parse(Configs.rent),
    headers: {
      "Authorization": "Bearer $token",
      "Access-Control-Allow-Origin": "/",
      "Content-Type": "application/json",
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 201) {
    var modelProduct = requestAttendanceFromJson(response.body);
    Fluttertoast.showToast(
      msg: "Successfully Rented",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20.0,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.green[800],
    );
    // _check = modelProduct.products;
    return modelProduct;
    // notifyListeners();
  } else {
    Fluttertoast.showToast(
      msg: "Error ! \nPlease try again later.",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20.0,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.red[800],
    );
  }
}
// }
