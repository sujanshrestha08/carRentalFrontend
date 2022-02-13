// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:car_rental/model/login_model.dart';
import 'package:car_rental/screen/homepage.dart';
import 'package:car_rental/screen/login_screen.dart';
import 'package:car_rental/services/signup_apiservices.dart';
import 'package:car_rental/utils/shared_preference.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // var email;
  // var password;
  // var repassword;
  bool apiCallProcess = false;
  bool hidePassword = true;
  bool rehidePassword = true;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // final TextEditingController _repasswordtextEditingController =
  //     TextEditingController();
  var confirmPass;

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: globalFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 80,
                  ),
                  _gap(),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    // onSaved: (input) => email = input,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return "Please provide full name";
                      } else {
                        null;
                      }
                    },
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: "Full Name ",
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
                    keyboardType: TextInputType.emailAddress,
                    // onSaved: (input) => email = input,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return "Email is empty";
                      } else {
                        null;
                      }
                    },
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.phone,
                        // color: Colors.black54,
                      ),
                    ),
                  ),
                  _gap(),
                  TextFormField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    validator: (input) {
                      confirmPass = input;
                      if (input == null || input.isEmpty) {
                        return "Password is required";
                      } else {
                        null;
                      }
                    },
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      labelText: "Password ",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        // color: Colors.black54,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        color: Colors.black.withOpacity(0.3),
                      ),
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
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (validateAndSave()) {
                          setState(() {
                            apiCallProcess = true;
                          });
                        }
                        signUpCustomer(
                          name.text,
                          email.text,
                          password.text,
                        ).then((value) => {
                              setState(() {
                                apiCallProcess = false;
                              }),
                              if (value.isAdmin == false)
                                {
                                  Fluttertoast.showToast(
                                    msg:
                                        "Congratulations ! \n ${value.name} User has been created.\n",
                                    toastLength: Toast.LENGTH_SHORT,
                                    fontSize: 20.0,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.green[800],
                                  ),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  ),
                                }
                              else if (value.message ==
                                  "User validation failed: name: Path `name` is required., email: Path `email` is required.")
                                {
                                  Fluttertoast.showToast(
                                    msg:
                                        "Error ! \nPlease make sure every thing is correct.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    fontSize: 20.0,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red[800],
                                  )
                                }
                              else if (value.message == "User already Exists")
                                {
                                  Fluttertoast.showToast(
                                    msg: "Error ! \nUser already Exists",
                                    toastLength: Toast.LENGTH_SHORT,
                                    fontSize: 20.0,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red[800],
                                  )
                                }
                            });
                      },
                      child: apiCallProcess == true
                          ? const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                              ),
                            ),
                    ),
                  ),
                  _gap(),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      children: [
                        const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(fontSize: 12),
                        ),
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: Colors.indigo[700],
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
