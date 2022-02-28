import 'dart:async';
import 'dart:io';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:car_rental/admin/admin_home.dart';
import 'package:car_rental/admin/update_product_scree.dart';
import 'package:car_rental/services/product_service.dart';
import 'package:car_rental/services/rent_api.dart';
import 'package:car_rental/services/searchProduct_api.dart';
import 'package:car_rental/utils/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:sensors_plus/sensors_plus.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

class ProductDetail extends StatefulWidget {
  final String id;
  final String name;
  final dynamic image;
  final String brand;
  final String category;
  final int price;
  final String description;
  final String productid;
  final String availableVehicle;

  const ProductDetail({
    Key? key,
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.description,
    required this.productid,
    required this.image,
    required this.availableVehicle,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

// void notify() async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//         id: 1,
//         channelKey: 'key1',
//         title: 'Car has been booked successfully',
//         notificationLayout: NotificationLayout.BigPicture,
//         bigPicture:
//             'https://media.istockphoto.com/photos/close-up-of-a-man-receiving-new-car-key-picture-id628453996?k=20&m=628453996&s=612x612&w=0&h=o0YMpSeU9tL73tn3xih1fGd3RQ8XViJpIgOeCTI_RB4='),
//   );
// }

class _ProductDetailState extends State<ProductDetail> {
  bool _isNear = false;

  late StreamSubscription<dynamic> _streamSubscription;

  final address = TextEditingController();
  final city = TextEditingController();
  final postalCode = TextEditingController();
  final country = TextEditingController();
  TextEditingController dateInText = TextEditingController();
  TextEditingController dateOutText = TextEditingController();
  final GlobalKey<FormState> globalCompleteFormKey = GlobalKey<FormState>();

  DateTimeRange? dateRange;
  String getFrom() {
    if (dateRange == null) {
      return "Select Rent Date From";
    } else {
      return DateFormat("yyyy-MM-dd").format(dateRange!.start);
    }
  }

  String getTo() {
    if (dateRange == null) {
      return ("Until *");
    } else {
      return DateFormat("yyyy-MM-dd").format(dateRange!.end);
    }
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        if (event < 1) {
          Navigator.pushNamed(context, "/logout");
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final timeDate = Provider.of<TimeProvider>(context);
    DateTime selectedDateFrom = DateTime.now();
    DateTime selectedDateTo = DateTime.now().add(const Duration(days: 7));
    String durationFrom = timeDate.getDate((selectedDateFrom).toString());
    String durationTo = timeDate.getDate((selectedDateTo).toString());

    Future pickDateRange(BuildContext context) async {
      final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 24 * 7)),
      );
      final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: dateRange ?? initialDateRange,
      );
      if (newDateRange == null) return;
      setState(() {
        dateRange = newDateRange;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: Consumer<MyProduct>(
        builder: (context, product, child) {
          return SingleChildScrollView(
            child: Card(
              elevation: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Text("Car name: ${widget.name}",
                            style: TextStyle(
                              color: Colors.indigo[800],
                              fontSize: 16,
                            )),
                      ),
                      SizedBox(
                        height: 40,
                        child: Text(
                          "Car Model: ${widget.brand}",
                          style: TextStyle(
                            color: Colors.indigo[800],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Text("Category: ${widget.category}",
                            style: TextStyle(
                              color: Colors.indigo[800],
                              fontSize: 16,
                            )),
                      ),
                      SizedBox(
                        height: 40,
                        child: Text("Price \$: ${widget.price}",
                            style: TextStyle(
                              color: Colors.indigo[800],
                              fontSize: 16,
                            )),
                      ),
                      SizedBox(
                        height: 40,
                        child: Text("Description: ${widget.description}",
                            style: TextStyle(
                              color: Colors.indigo[800],
                              fontSize: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  product
                                      .delproduct(
                                        widget.id,
                                        context,
                                      )
                                      .then((value) => {
                                            if (value.message ==
                                                "Product Removed")
                                              {
                                                Navigator.pop(context),
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Product Successfully Removed",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  fontSize: 20.0,
                                                  timeInSecForIosWeb: 1,
                                                  textColor: Colors.white,
                                                  backgroundColor:
                                                      Colors.blue[800],
                                                ),
                                              }
                                          });
                                },
                                child: const Text("Delete"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.indigo[800],
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateProductUi(
                                        id: widget.id,
                                        name: widget.name,
                                        brand: widget.brand,
                                        category: widget.category,
                                        description: widget.description,
                                        availableVehicle:
                                            widget.availableVehicle,
                                        price: widget.price.toString(),
                                        image: widget.image,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Update"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.indigo[800],
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: SingleChildScrollView(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  child: Form(
                                    key: globalCompleteFormKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        _gap(),
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          // onSaved: (input) => email = input,
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Empty Address Field";
                                            } else {
                                              null;
                                            }
                                          },
                                          // onSaved: (input) => _value = num.tryParse(input),
                                          controller: address,
                                          decoration: const InputDecoration(
                                            labelText: "Street Address *",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(
                                              Icons.location_on_outlined,
                                              // color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        _gap(),
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          // onSaved: (input) => email = input,
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Empty City ";
                                            } else {
                                              null;
                                            }
                                          },
                                          // onSaved: (input) => _value = num.tryParse(input),
                                          controller: city,
                                          decoration: const InputDecoration(
                                            labelText: "City *",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(
                                              Icons.location_city_outlined,
                                              // color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        _gap(),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          // onSaved: (input) => email = input,
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please Provide Postal Code";
                                            } else {
                                              null;
                                            }
                                          },
                                          // onSaved: (input) => _value = num.tryParse(input),
                                          controller: postalCode,
                                          decoration: const InputDecoration(
                                            labelText: "Postal Code *",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(
                                              Icons.qr_code_scanner_sharp,
                                              // color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        _gap(),
                                        TextFormField(
                                          keyboardType: TextInputType.text,
                                          // onSaved: (input) => email = input,
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Empty Country";
                                            } else {
                                              null;
                                            }
                                          },
                                          // onSaved: (input) => _value = num.tryParse(input),
                                          controller: country,
                                          decoration: const InputDecoration(
                                            labelText: "Country *",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(
                                              Icons.flag_outlined,
                                              // color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        _gap(),
                                        ElevatedButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.calendar_today_outlined,
                                                color: Colors.blue[900],
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${getFrom()} -> ${getTo()}",
                                                style: TextStyle(
                                                    color: Colors.blue[900]),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            pickDateRange(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            shadowColor: Colors.blue[900],
                                            elevation: 7,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            rentProduct(
                                              widget.name,
                                              "image",
                                              widget.price.toString(),
                                              widget.productid,
                                              address.text,
                                              city.text,
                                              postalCode.text,
                                              country.text,
                                              durationFrom,
                                              durationTo,
                                              context,
                                            ).then((value) => {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    // notify();
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           AdminHomePage()),
                                                    // );
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Successfully Rented",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      fontSize: 20.0,
                                                      timeInSecForIosWeb: 1,
                                                      textColor: Colors.white,
                                                      backgroundColor:
                                                          Colors.blue[800],
                                                    );
                                                    // notify();
                                                  }),
                                                  // }
                                                });
                                          },
                                          child: const Text("Rent this car"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.indigo[800],
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: const Text("Rent this Car."),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo[800],
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }
}
