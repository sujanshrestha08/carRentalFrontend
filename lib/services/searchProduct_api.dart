import 'dart:convert';
import 'package:car_rental/model/product.dart';
import 'package:car_rental/utils/configs.dart';
import 'package:car_rental/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// class SearchProduct extends ChangeNotifier {
List<ProductElement>? _check = [];
List<ProductElement>? get value => _check;

Future<dynamic> getProduct(String query, context) async {
  var response = await http.get(
    Uri.parse(Configs.product + "?keyword=" + query),
  );
  if (response.statusCode == 200) {
    var modelProduct = productFromJson(response.body);
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