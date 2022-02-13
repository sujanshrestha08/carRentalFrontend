import 'dart:convert';
import 'dart:io';
import 'package:car_rental/model/add_product_model.dart';
import 'package:car_rental/utils/configs.dart';
import 'package:car_rental/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';

// class AddProduct extends ChangeNotifier {
Future<dynamic> postproduct(
  String name,
  String brand,
  String category,
  String description,
  String availableVehicle,
  String price,
  dynamic image,
  context,
) async {
  // var imageResult = MultipartFile.fromFileSync(image.path,
  //     filename: "${image.path.split("/")[image.path.split("/").length - 1]}");
  // print(imageResult);
  // .fromFileSync(tyoimagefile.path, filename: "${tyoimagefile.path.split("/")[tyoimagefile.path.split("/").length -1]}")
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
