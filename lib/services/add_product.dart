import 'dart:convert';
import 'dart:io';
import 'package:car_rental/model/add_product_model.dart';
import 'package:car_rental/services/product_service.dart';
import 'package:car_rental/utils/configs.dart';
import 'package:car_rental/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';

import 'package:provider/provider.dart';

// class AddProduct extends ChangeNotifier {
Future<dynamic> postproduct(
  String name,
  String brand,
  String category,
  String description,
  String availableVehicle,
  String price,
  String image,
  context,
) async {
  var body = {
    "name": name,
    "brand": brand,
    "category": category,
    "description": description,
    "availableVehicle": availableVehicle,
    "price": price,
    "image": image,
  };
  String? token = await SharedServices.loginDetails();
  var response = await http.post(
    Uri.parse(Configs.product),
    headers: {
      "Authorization": "Bearer $token",
      "Access-Control-Allow-Origin": "/",
      "Content-Type": "application/json",
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 201) {
    var addProduct = addProductFromJson(response.body);
    await Provider.of<MyProduct>(context, listen: false).getproduct(context);
    return addProduct;
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
