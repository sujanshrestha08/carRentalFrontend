import 'package:car_rental/services/rent_api.dart';
import 'package:car_rental/services/searchProduct_api.dart';
import 'package:car_rental/utils/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String imgae;
  final String brand;
  final String category;
  final int price;
  final String description;
  final String productid;

  ProductDetail({
    Key? key,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.description,
    required this.productid,
    required this.imgae,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 200,
                color: Colors.amber,
              ),
              Container(
                height: 40,
                child: Text(widget.name),
              ),
              Container(
                height: 40,
                child: Text(widget.brand),
              ),
              Container(
                height: 40,
                child: Text(widget.category),
              ),
              Container(
                height: 40,
                child: Text(widget.price.toString()),
              ),
              Container(
                height: 40,
                child: Text(widget.description),
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
                                      if (input == null || input.isEmpty) {
                                        return "Empty Address Field";
                                      } else {
                                        null;
                                      }
                                    },
                                    // onSaved: (input) => _value = num.tryParse(input),
                                    controller: address,
                                    decoration: const InputDecoration(
                                      labelText: "Address *",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.account_circle_outlined,
                                        // color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  _gap(),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    // onSaved: (input) => email = input,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return "Empty City ";
                                      } else {
                                        null;
                                      }
                                    },
                                    // onSaved: (input) => _value = num.tryParse(input),
                                    controller: city,
                                    decoration: const InputDecoration(
                                      labelText: "City *",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.account_circle_outlined,
                                        // color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  _gap(),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    // onSaved: (input) => email = input,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return "Please Provide Postal Code";
                                      } else {
                                        null;
                                      }
                                    },
                                    // onSaved: (input) => _value = num.tryParse(input),
                                    controller: postalCode,
                                    decoration: const InputDecoration(
                                      labelText: "Postal Code *",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.account_circle_outlined,
                                        // color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  _gap(),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    // onSaved: (input) => email = input,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return "Empty Country";
                                      } else {
                                        null;
                                      }
                                    },
                                    // onSaved: (input) => _value = num.tryParse(input),
                                    controller: country,
                                    decoration: const InputDecoration(
                                      labelText: "Country *",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.account_circle_outlined,
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
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: 40),
                                      primary: Colors.blue[100],
                                      shadowColor: Colors.blue[900],
                                      elevation: 7,
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        //            getFrom().toString() == "Start Date"
                                        //     ? dateFrom
                                        //     : getFrom().toString(),
                                        // getTo().toString() == "End Date"
                                        //     ? dateTo
                                        //     : getTo().toString(),
                                        // getProduct()
                                        rentProduct(
                                          widget.name,
                                          widget.imgae,
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
                                              }),
                                              // }
                                            });
                                      },
                                      child: const Text("Rent this car"))

                                  // TextFormField(
                                  //   keyboardType: TextInputType.text,
                                  //   // onSaved: (input) => email = input,
                                  //   validator: (input) {
                                  //     if (input == null || input.isEmpty) {
                                  //       return "Date From is Empty";
                                  //     } else {
                                  //       null;
                                  //     }
                                  //   },
                                  //   // onSaved: (input) => _value = num.tryParse(input),
                                  //   controller: city,
                                  //   readOnly: true,
                                  //   decoration: InputDecoration(
                                  //     labelText: "Date you want the car?",
                                  //     hintStyle:
                                  //         const TextStyle(color: Colors.black),
                                  //     border: const OutlineInputBorder(),
                                  //     prefixIcon: const Icon(
                                  //       Icons.calendar_today,
                                  //       // color: Colors.black54,
                                  //     ),
                                  //     hintText: getDateIn(),
                                  //   ),
                                  //   onTap: () {
                                  //     startDate(context);
                                  //   },
                                  // ),
                                  // _gap(),
                                  // TextFormField(
                                  //   keyboardType: TextInputType.text,
                                  //   readOnly: true,
                                  //   // onSaved: (input) => email = input,
                                  //   validator: (input) {
                                  //     if (input == null || input.isEmpty) {
                                  //       return "Return Date Empty";
                                  //     } else {
                                  //       null;
                                  //     }
                                  //   },
                                  //   // onSaved: (input) => _value = num.tryParse(input),
                                  //   controller: city,
                                  //   decoration: InputDecoration(
                                  //     labelText: "Date you will return?",
                                  //     hintStyle:
                                  //         const TextStyle(color: Colors.black),
                                  //     border: const OutlineInputBorder(),
                                  //     hintText: getDateOut(),
                                  //     prefixIcon: const Icon(
                                  //       Icons.calendar_today,
                                  //       // color: Colors.black54,
                                  //     ),
                                  //   ),
                                  //   onTap: () async {
                                  //     endDate(context);
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: const Text("Rent this Car."))
        ],
      ),
    );
  }

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }
}
