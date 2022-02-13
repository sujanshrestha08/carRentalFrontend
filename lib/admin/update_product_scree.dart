import 'package:car_rental/services/add_product.dart';
import 'package:car_rental/services/update_product_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UpdateProductUi extends StatefulWidget {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String description;
  final String availableVehicle;
  final String price;
  final String image;
  UpdateProductUi(
      {Key? key,
      required this.id,
      required this.name,
      required this.brand,
      required this.category,
      required this.description,
      required this.availableVehicle,
      required this.price,
      required this.image})
      : super(key: key);

  @override
  State<UpdateProductUi> createState() => _UpdateProductUiState();
}

class _UpdateProductUiState extends State<UpdateProductUi> {
  // late File _image;
  // late File _image;
  bool apiCallProcess = false;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController availableVehicle = TextEditingController();
  TextEditingController price = TextEditingController();
  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }

  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Update Product"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(35),
              child: Form(
                key: globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.integration_instructions_outlined,
                      size: 80,
                    ),

                    _gap(),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please provide car model name";
                        } else {
                          null;
                        }
                      },
                      controller: name,
                      decoration: InputDecoration(
                        labelText: widget.name,
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(
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
                          return "Empty Brand Name";
                        } else {
                          null;
                        }
                      },
                      controller: brand,
                      decoration: InputDecoration(
                        labelText: widget.brand,
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
                          return "Empty Category";
                        } else {
                          null;
                        }
                      },
                      controller: category,
                      decoration: InputDecoration(
                        labelText: widget.category,
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
                          return "Empty Description";
                        } else {
                          null;
                        }
                      },
                      controller: description,
                      decoration: InputDecoration(
                        labelText: widget.description,
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please enter available vehicle";
                        } else {
                          null;
                        }
                      },
                      controller: availableVehicle,
                      decoration: InputDecoration(
                        labelText: widget.availableVehicle,
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please Provide Price";
                        } else {
                          null;
                        }
                      },
                      // onSaved: (input) => _value = num.tryParse(input),
                      controller: price,
                      decoration: InputDecoration(
                        labelText: widget.price,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                    // _gap(),
                    // ListTile(
                    //     leading: new Icon(Icons.photo_library),
                    //     title: new Text('Photo Library'),
                    //     onTap: () {
                    //       // Navigator.of(context).pop();
                    //     }),
                    _gap(),
                    image != null
                        ? Image.file(
                            image!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: Column(
                              children: const [
                                Icon(Icons.photo_library),
                                Text('Photo Library'),
                              ],
                            ),
                          ),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo[800],
                          shape: const StadiumBorder(),
                          fixedSize:
                              const Size(double.maxFinite, double.infinity),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (apiCallProcess == false) {
                            if (validateAndSave()) {
                              setState(() {
                                apiCallProcess = true;
                              });
                            }
                            putproduct(
                              name.text,
                              brand.text,
                              category.text,
                              description.text,
                              availableVehicle.text,
                              price.text,
                              image!.path.toString(),
                              widget.id.toString(),
                              context,
                            ).then((value) => {
                                  setState(() {
                                    apiCallProcess = false;
                                  }),
                                  // if (value.isAdmin == false)
                                  // {
                                  Fluttertoast.showToast(
                                    msg:
                                        "Congratulations ! \n Product has been updated",
                                    toastLength: Toast.LENGTH_SHORT,
                                    fontSize: 20.0,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.green[800],
                                  ),
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           LoginScreen()),
                                  // ),
                                  // }
                                  // else if (value.message ==
                                  //     "User validation failed: name: Path `name` is required., email: Path `email` is required.")
                                  //   {
                                  //     Fluttertoast.showToast(
                                  //       msg:
                                  //           "Error ! \nPlease make sure every thing is correct.",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       fontSize: 20.0,
                                  //       timeInSecForIosWeb: 1,
                                  //       textColor: Colors.white,
                                  //       backgroundColor: Colors.red[800],
                                  //     )
                                  //   }
                                  // else if (value.message ==
                                  //     "User already Exists")
                                  //   {
                                  //     Fluttertoast.showToast(
                                  //       msg: "Error ! \nUser already Exists",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       fontSize: 20.0,
                                  //       timeInSecForIosWeb: 1,
                                  //       textColor: Colors.white,
                                  //       backgroundColor: Colors.red[800],
                                  //     )
                                  //   }
                                });
                          }
                        },
                        child: apiCallProcess == true
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : const Text(
                                "Update",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                      ),
                    ),
                    _gap(),
                    // RichText(
                    //   text: TextSpan(
                    //     style: const TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 13,
                    //     ),
                    //     children: [
                    //       const TextSpan(
                    //         text: "Already have an account? ",
                    //         style: TextStyle(fontSize: 12),
                    //       ),
                    //       TextSpan(
                    //         text: "Login",
                    //         style: TextStyle(
                    //           color: Colors.indigo[700],
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () => Navigator.pop(context),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
