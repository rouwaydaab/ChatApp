import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/auth/login_page.dart';
import 'package:flutter_application_3/pages/home_page.dart';
import 'package:flutter_application_3/service/auth_service.dart';

import '../../helper/helper_function.dart';
import '../../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";

  // String Username = "";
  String password = "";
  String fullName = "";

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar( backgroundColor: Theme.of(context).primaryColor),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //
                        // const Text(
                        //   "RAW",
                        //   style: TextStyle(
                        //       fontSize: 40, fontWeight: FontWeight.bold),
                        // ),
                        // const SizedBox(height: 10),
                        // const Text("Login now",
                        //     style: TextStyle(
                        //         fontSize: 15, fontWeight: FontWeight.w400)),
                        // const SizedBox(height: 50),
                        Image.asset(
                          "assets/regis.png",

                          width: 400, // Set the desired width
                          height: 100, // Set the desired height
                          // fit: BoxFit.cover, // Choose the appropriate fit
                        ),
                        const SizedBox(height: 50),

                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              )),
                          style: const TextStyle(color: Colors.white),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },

                          // check tha validation
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                        ),

                        const SizedBox(height: 15),

                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "FullName",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              )),
                          style: const TextStyle(color: Colors.white),
                          onChanged: (val) {
                            setState(() {
                              fullName = val;
                            });
                          },

                          // check tha validation
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name Cannot be empty";
                            }
                          },
                        ),

                        const SizedBox(height: 15),

                        // TextFormField(
                        //   decoration: textInputDecoration.copyWith(
                        //       labelText: "Username",
                        //       prefixIcon: Icon(
                        //         Icons.supervisor_account,
                        //         color: Theme.of(context).primaryColor,
                        //       )),
                        //   style: const TextStyle(color: Colors.white),
                        //   validator: (val) {
                        //     if (val == null || val.isEmpty) {
                        //       return 'Username is required';
                        //     } else if (!containsSpecialCharacters(val)) {
                        //       return 'Username should contains special characters';
                        //     }
                        //     return null; // if the validation is seccessful
                        //   },
                        //   onChanged: (val) {
                        //     setState(() {
                        //       password = val;
                        //     });
                        //   },
                        // ),

                        const SizedBox(height: 15),

                        ///The TextFormField widget is used to create a text field that can be edited by the user. The obscureText property is set to true,
                        /// which means that the text will be hidden as the user types it. The decoration property is used to specify the appearance of
                        /// the text field. The labelText property is used to specify the text that will be displayed above the text field.
                        /// The prefixIcon property is used to specify the icon that will be displayed at the beginning of the text field.
                        /// The validator property is used to specify a function that will be called to validate the input.
                        /// The onChanged property is used to specify a function that will be called when the text in the text field is changed.
                        // In this case, the validator function checks to make sure that the password is at least 6 characters long.
                        // If the password is not at least 6 characters long, the function returns an error message. Otherwise, the function returns null.
                        // The onChanged function is used to update the state of the parent widget. The state of the parent widget is updated with the new value of the password.
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              )),
                          style: const TextStyle(color: Colors.white),
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(
                          text: "Already have an account?",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Login Now",
                                style: const TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const LoginPage());
                                  }),
                          ],
                        )),
                      ],
                    )),
              ),
            ),
    );
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        setState(() {
          _isLoading = false;
        });
        if (value == true) {
          //saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackbar(context, Colors.red, value);

          setState(() {
            _isLoading = false;
          });

          // Pass back the entered data to the previous screen
          Navigator.pop(context, {"fullName": fullName, "email": email});
          // } else {
          //   setState(() {
          //     _isLoading = false;
          //   });
          // }
        }
      });
    }

    // bool containsSpecialCharacters(String value) {
    //   // Add logic to check if the username contains special characters
    //   // For example, you can use a regular expression
    //   final RegExp specialCharacters = RegExp(r'[!@#%^&*(),.?":{}|<>]');
    //   return specialCharacters.hasMatch(value);
    // }
  }

  bool containsSpecialCharacters(String value) {
    // Add logic to check if the username contains special characters
    // For example, you can use a regular expression
    final RegExp specialCharacters = RegExp(r'[!@#%^&*(),.?":{}|<>]');
    return specialCharacters.hasMatch(value);
  }
}
