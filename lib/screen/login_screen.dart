// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:car_rental/admin/admin_home.dart';
import 'package:car_rental/screen/homepage.dart';
import 'package:car_rental/screen/sign_up.dart';
import 'package:car_rental/services/login_apiservices.dart';
import 'package:car_rental/utils/shared_preference.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email;
  var password;
  bool hidePassword = true;
  bool apiCallProcess = false;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.indigo.shade900,
              Colors.indigo.shade100,
            ])),
        child: Center(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      size: 100,
                      color: Colors.indigo[900],
                    ),
                    _gap(),
                    Text(
                      "User Login",
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _gap(),
                    _gap(),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),

                      keyboardType: TextInputType.emailAddress,
                      // onSaved: (input) => email = input,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "User Name is empty";
                        } else {
                          null;
                        }
                      },
                      controller: _email,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.indigo.shade900, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        labelText: "User Name ",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                          // color: Colors.black54,
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _password,
                      keyboardType: TextInputType.text,
                      // onSaved: (input) => password = input,
                      autofillHints: const [AutofillHints.password],
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Password is required";
                        } else {
                          null;
                        }
                      },
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.indigo.shade900, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.white,
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
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if (validateAndSave()) {
                            setState(() {
                              apiCallProcess = true;
                            });
                            await login(
                              _email.text.toString(),
                              _password.text.toString(),
                            ).then((value) => {
                                  setState(() {
                                    apiCallProcess = false;
                                  }),
                                  if (value.isAdmin == true)
                                    {
                                      SharedServices.setLoginDetails(
                                          value.token),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminHomePage()),
                                      ),
                                    }
                                  else if (value.isAdmin == false)
                                    {
                                      SharedServices.setLoginDetails(
                                          value.token),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      ),
                                    }
                                });
                          }
                        },
                        child: apiCallProcess == true
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                // color: Color(0xfff06127),
                              )
                            : const Text(
                                "Login",
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
                          // fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        children: [
                          const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(fontSize: 14),
                          ),
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                                color: Colors.indigo[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()),
                                  ),
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
      ),
    );
  }

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
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
