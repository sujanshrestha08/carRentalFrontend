import 'package:car_rental/admin/add_product.dart';
import 'package:car_rental/admin/product_details.dart';
import 'package:car_rental/admin/search_page.dart';
import 'package:car_rental/admin/update_product_scree.dart';
import 'package:car_rental/admin/view_my_order.dart';
import 'package:car_rental/admin/view_order.dart';
import 'package:car_rental/model/product.dart';
import 'package:car_rental/screen/aboutus.dart';
import 'package:car_rental/screen/contactus.dart';
import 'package:car_rental/screen/faq.dart';
import 'package:car_rental/screen/login_screen.dart';
import 'package:car_rental/services/delete_product_api.dart';
import 'package:car_rental/services/product_service.dart';
import 'package:car_rental/services/searchProduct_api.dart';
import 'package:car_rental/utils/configs.dart';
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

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MyProduct>(context, listen: false).getproduct(context);
  }

  late List<ProductElement>? products;
  String query = '';
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   // color: Colors.transparent,
      //   child: Container(
      //     height: 30.0,
      //   ),
      // ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/welcome.jpg'))),
                child: Stack(children: const [
                  Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text(
                      "Welcome Admin to DashBoard",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ])

                // child: CircleAvatar(
                //   backgroundColor: Colors.grey,
                //   radius: 200,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Colors.grey,
                //       border: Border.all(
                //           color: const Color(0xfff06127),
                //           style: BorderStyle.solid),
                //       image: DecorationImage(
                //         fit: BoxFit.cover,
                //       image: details.userModel.data?.avatarImageUrl != null
                //           ? NetworkImage(details.userModel.data?.avatarImageUrl)
                //           : const AssetImage('assets/icons/neesumLogo.png')
                //               as ImageProvider,
                //       ),
                //     ),
                //   ),
                // ),
                ),
            Divider(
              color: Colors.blue.shade900,
              thickness: 1,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.stacked_bar_chart_outlined,
                    color: Colors.blue[900],
                  ),
                  Text(
                    "View All Orders",
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.blue.shade900,
              thickness: 1,
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
                      builder: (BuildContext context) => ViewMyOrder()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.date_range,
                    color: Colors.blue[900],
                  ),
                  Text(
                    "View My Order",
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.blue.shade900,
              thickness: 4,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              child: TextButton(
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
                        builder: (BuildContext context) => AboutUs()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.blueAccent[700],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "About Us",
                      style: TextStyle(
                          color: Colors.blue[900], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.blue.shade900,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              child: TextButton(
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
                        builder: (BuildContext context) => ContactUs()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.contact_mail_outlined,
                      color: Colors.blueAccent[700],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Contact Us",
                      style: TextStyle(
                          color: Colors.blue[900], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.blue.shade900,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              color: Colors.white,
              child: TextButton(
                style: TextButton.styleFrom(
                  // backgroundColor: const Color(0xfff06127),
                  padding: const EdgeInsets.all(10),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => FAQ()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.repeat_one,
                      color: Colors.blueAccent[700],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "FAQs",
                      style: TextStyle(
                          color: Colors.blue[900], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.blue.shade900,
              thickness: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
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
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.indigo.shade100,
                Colors.indigo.shade50,
              ])),
          child: Column(
            children: [
              Consumer<MyProduct>(builder: (context, product, child) {
                if (product.value?.isEmpty == true
                    // &&
                    //     oldValue != product.value?.length
                    ) {
                  return Center(
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: const Text("Empty")));
                } else {
                  return Column(
                    children: [
                      Container(
                        height: 150,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(2),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/homepage.jpg'),
                          ),
                        ),
                      ),
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: product.value?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Card(
                                elevation: 10,
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
                                                  id: (product.value?[index].id)
                                                      .toString(),
                                                  name: (product
                                                          .value?[index].name)
                                                      .toString(),
                                                  image: (product
                                                          .value?[index].image)
                                                      .toString(),
                                                  // NetworkImage(
                                                  //     Configs.mainURL +
                                                  //         // "/" +
                                                  //         // "${product.value?[index].image}"
                                                  //         "/uploads/image-1644773012939.png"
                                                  //     // "${product.value?[index].image}"

                                                  //     ),
                                                  brand: (product
                                                          .value?[index].brand)
                                                      .toString(),
                                                  category: (product
                                                          .value?[index]
                                                          .category)
                                                      .toString(),
                                                  price: (product
                                                          .value?[index].price)!
                                                      .toInt(),
                                                  description: (product
                                                          .value?[index]
                                                          .description)
                                                      .toString(),
                                                  productid:
                                                      (product.value?[index].id)
                                                          .toString(),
                                                  availableVehicle: ((product
                                                          .value?[index]
                                                          .availableVehicle)
                                                      .toString()),
                                                )),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 150,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.blue[50],
                                              // shape: BoxShape.circle,
                                              // color: Colors.grey,
                                              // border: Border.all(
                                              //     color: const Color(0xfff06127), style: BorderStyle.solid),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(Configs
                                                        .mainURL +
                                                    '/uploads/' +
                                                    product.value![index].image
                                                        .toString()),
                                              ),
                                            ),
                                          ),
                                          // Container(
                                          //   height: 150,
                                          //   width: double.infinity,
                                          //   decoration: BoxDecoration(
                                          //     color: Colors.purple.shade100,
                                          //     // shape: BoxShape.circle,
                                          //     // color: Colors.grey,
                                          //     // border: Border.all(
                                          //     //     color: const Color(0xfff06127), style: BorderStyle.solid),
                                          //     image: DecorationImage(
                                          //       fit: BoxFit.cover,
                                          //       image: NetworkImage(
                                          //           Configs.mainURL +
                                          //               // "/" +
                                          //               // "${product.value?[index].image}"
                                          //               "/uploads/image-1644773012939.png"
                                          //           // "${product.value?[index].image}"

                                          //           ),
                                          //     ),
                                          //   ),
                                          // ),
                                          space(),
                                          Text(
                                              "Car Name : ${(product.value?[index].name).toString()}",
                                              style: TextStyle(
                                                color: Colors.indigo[800],
                                                fontSize: 16,
                                              )),
                                          space(),
                                          Text(
                                              "\$\$\$ ${(product.value?[index].price).toString()}",
                                              style: TextStyle(
                                                color: Colors.red[600],
                                                fontSize: 16,
                                              )),
                                          space(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox space() {
    return const SizedBox(
      height: 5,
    );
  }

  // Widget searchProduct() => Search(
  //       text: query,
  //       hintText: "Search...",
  //       onChanged: product,
  //     );

  // Future product(String query) async {
  //   final products = await getProduct(query, context);
  //   if (!mounted) return;
  //   setState(() {
  //     this.query = query;
  //     this.products = products;
  //   });
  // }
}
