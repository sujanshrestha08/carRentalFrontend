import 'package:car_rental/screen/car_details.dart';
import 'package:car_rental/screen/homepage.dart';
import 'package:car_rental/screen/login_screen.dart';
import 'package:car_rental/services/get_rent_services.dart';
import 'package:car_rental/services/product_service.dart';
import 'package:car_rental/services/searchProduct_api.dart';
import 'package:car_rental/services/view_my_order_services.dart';
import 'package:car_rental/utils/shared_preference.dart';
import 'package:car_rental/utils/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MyProduct()),
    ChangeNotifierProvider(create: (_) => TimeProvider()),
    ChangeNotifierProvider(create: (_) => GetRent()),
    ChangeNotifierProvider(create: (_) => SearchProduct()),
    ChangeNotifierProvider(create: (_) => ViewMyOrders()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental',
      theme: ThemeData(
        primaryColor: Colors.indigo[800],
      ),
      home: LoginScreen(),
    );
  }
}
