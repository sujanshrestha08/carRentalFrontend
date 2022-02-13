import 'package:car_rental/admin/add_product.dart';
import 'package:car_rental/admin/product_details.dart';
import 'package:car_rental/admin/search_page.dart';
import 'package:car_rental/admin/update_product_scree.dart';
import 'package:car_rental/admin/view_order.dart';
import 'package:car_rental/model/product.dart';
import 'package:car_rental/screen/login_screen.dart';
import 'package:car_rental/services/delete_product_api.dart';
import 'package:car_rental/services/product_service.dart';
import 'package:car_rental/services/searchProduct_api.dart';
import 'package:car_rental/utils/search.dart';
import 'package:car_rental/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

// void searchChanged(String searchtext) {
//   searchresult.clear();
// }

class _AdminHomePageState extends State<AdminHomePage> {
  // late final product;

  @override
  void initState() {
    super.initState();
    Provider.of<MyProduct>(context, listen: false).getproduct(context);
    // product.getproduct(context);
  }

  late List<ProductElement>? products;
  String query = '';
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        // color: Colors.transparent,
        child: Container(
          height: 30.0,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductUi()),
          );
        },
        backgroundColor: Colors.indigo[800],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 200,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    border: Border.all(
                        color: const Color(0xfff06127),
                        style: BorderStyle.solid),
                    // image: DecorationImage(
                    //   fit: BoxFit.cover,
                    // image: details.userModel.data?.avatarImageUrl != null
                    //     ? NetworkImage(details.userModel.data?.avatarImageUrl)
                    //     : const AssetImage('assets/icons/neesumLogo.png')
                    //         as ImageProvider,
                    // ),
                  ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                // backgroundColor: const Color(0xfff06127),
                padding: const EdgeInsets.all(10),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ViewAdminOrders()),
                );
              },
              child: const Text(
                "View Orders",
                style: TextStyle(color: Colors.black),
              ),
            ),
            // Expanded(child: Container()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: const EdgeInsets.all(15),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  SharedServices.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()),
                    (route) => false,
                  );
                  Fluttertoast.showToast(
                    msg: "Successfully Logged Out",
                    toastLength: Toast.LENGTH_LONG,
                    fontSize: 12,
                    textColor: Colors.black,
                    backgroundColor: Colors.grey[100],
                  );
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Car Rental"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // searchProduct(),

            // Consumer<SearchProduct>(builder: (context, search, child) {
            //   return Column(
            //     children: [
            //       Row(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: SizedBox(
            //               width: 2,
            //               child: TextField(
            //                 controller: controller,
            //               ),
            //             ),
            //           ),
            //           IconButton(
            //             onPressed: () {
            //               search.getProduct(controller.text, context);
            //             },
            //             icon: const Icon(Icons.search),
            //           ),
            //         ],
            //       ),
            //       ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: search.value?.length,
            //         itemBuilder: (context, index) {
            //           // final product = products?[index];
            //           return Card(
            //             child: ListTile(
            //               title: Text((search.value?[index].name).toString()),
            //             ),
            //           );
            //         },
            //       ),
            //     ],
            //   );
            //   // if (query.isEmpty == true) {
            //   //   return Container();
            //   // } else if (query.isNotEmpty || search.value?.isEmpty == true) {
            //   //   return Container(
            //   //     child: Expanded(
            //   //       child: ListView.builder(
            //   //         shrinkWrap: true,
            //   //         itemCount: search.value?.length,
            //   //         itemBuilder: (context, index) {
            //   //           // final product = products?[index];
            //   //           return Card(
            //   //             child: ListTile(
            //   //               title: Text((search.value?[index].name).toString()),
            //   //             ),
            //   //           );
            //   //         },
            //   //       ),
            //   //     ),
            //   //   );
            //   // } else {
            //   //   return Container();
            //   // }
            // }),

            Consumer<MyProduct>(builder: (context, product, child) {
              // product.getproduct(context);
              // final oldValue = product.value?.length;
              // product.getproduct(context);
              if (product.value?.isEmpty == true
                  // &&
                  //     oldValue != product.value?.length
                  ) {
                return Center(
                    child: Container(
                        margin: const EdgeInsets.all(20),
                        child: const Text("Empty")));
              } else {
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.value?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                          name: (product.value?[index].name)
                                              .toString(),
                                          imgae: (product.value?[index].image)
                                              .toString(),
                                          brand: (product.value?[index].brand)
                                              .toString(),
                                          category:
                                              (product.value?[index].category)
                                                  .toString(),
                                          price: (product.value?[index].price)!
                                              .toInt(),
                                          description: (product
                                                  .value?[index].description)
                                              .toString(),
                                          productid: (product.value?[index].id)
                                              .toString(),
                                        )),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Text(
                                            (product.value?[index].image)
                                                .toString(),
                                          ),
                                        ),
                                        Text((product.value?[index].name)
                                            .toString()),
                                        Text((product.value?[index].price)
                                            .toString()),
                                        Text((product.value?[index].description)
                                            .toString()),
                                        Text((product.value?[index].brand)
                                            .toString()),
                                        Text((product.value?[index].category)
                                            .toString()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            product
                                                .delproduct(
                                                    (product.value?[index].id)
                                                        .toString(),
                                                    context)
                                                .then((value) => {
                                                      if (value.message ==
                                                          "Product Removed")
                                                        {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Product Successfully Removed",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            fontSize: 20.0,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            textColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors
                                                                    .green[800],
                                                          ),
                                                        }
                                                    });
                                          },
                                          child: const Text("Delete"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateProductUi(
                                                  id: ((product
                                                          .value?[index].id)
                                                      .toString()),
                                                  name: ((product
                                                          .value?[index].name)
                                                      .toString()),
                                                  brand: ((product
                                                          .value?[index].brand)
                                                      .toString()),
                                                  category: ((product
                                                          .value?[index]
                                                          .category)
                                                      .toString()),
                                                  description: ((product
                                                          .value?[index]
                                                          .description)
                                                      .toString()),
                                                  availableVehicle: ((product
                                                          .value?[index]
                                                          .availableVehicle)
                                                      .toString()),
                                                  price: ((product
                                                          .value?[index].price)
                                                      .toString()),
                                                  image: ((product
                                                          .value?[index].image)
                                                      .toString()),
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text("Update"),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget searchProduct() => Search(
        text: query,
        hintText: "Search...",
        onChanged: product,
      );

  Future product(String query) async {
    final products = await getProduct(query, context);
    if (!mounted) return;
    setState(() {
      this.query = query;
      this.products = products;
    });
  }
}
