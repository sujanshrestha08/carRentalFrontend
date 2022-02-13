import 'package:car_rental/services/get_rent_services.dart';
import 'package:car_rental/utils/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewAdminOrders extends StatefulWidget {
  ViewAdminOrders({Key? key}) : super(key: key);

  @override
  State<ViewAdminOrders> createState() => _ViewAdminOrdersState();
}

class _ViewAdminOrdersState extends State<ViewAdminOrders> {
  @override
  Widget build(BuildContext context) {
    final timeDate = Provider.of<TimeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Rent Orders"),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<GetRent>(builder: (context, rent, child) {
        // final oldValue = rent.value?.length;
        // var durationFrom = rent.value?[index].durationFrom;
        // DateTime rent.value?[index].durationFrom;
        // product.getRent(context);
        int lengthRent = (rent.value?.length)!.toInt();
        if (rent.value?.isEmpty == true && rent.value?.length != lengthRent) {
          rent.rentProduct(context);
          return Center(
              child: Container(
                  margin: const EdgeInsets.all(20), child: Text("Empty")));
        } else {
          rent.rentProduct(context);
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: rent.value?.length,
              itemBuilder: (BuildContext context, int index) {
                // DateTime from = DateTime.
                // String durationFrom = DateFormat('d MMM yyy').format((rent.value?[index].durationFrom).toString());
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Ordered By - ${(rent.value?[index].user?.name).toString()}"),
                                  Text(
                                      "Order duration from - ${timeDate.getDate((rent.value?[index].durationFrom).toString())}"),
                                  Text(
                                      "Order duration To - ${timeDate.getDate((rent.value?[index].durationTo).toString())}"),
                                  Text("Order Item"),
                                  Container(
                                    height: 50,
                                    child: Text(
                                      (rent.value?[index].rentItem?.image)
                                          .toString(),
                                    ),
                                  ),
                                  Text((rent.value?[index].rentItem?.name)
                                      .toString()),
                                  Text((rent.value?[index].rentItem?.price)
                                      .toString()),
                                  Text("Picking Address"),
                                  Text((rent.value?[index].pickingAddress
                                          ?.address)
                                      .toString()),
                                  Text((rent.value?[index].pickingAddress?.city)
                                      .toString()),
                                  Text((rent.value?[index].pickingAddress
                                          ?.country)
                                      .toString()),
                                  Text((rent.value?[index].pickingAddress
                                          ?.postalCode)
                                      .toString()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      }),
    );
  }
}