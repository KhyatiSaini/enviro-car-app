import 'dart:convert';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:envirocar/authentication/sign_in.dart';
import 'package:envirocar/theme/colors_cario.dart';
import 'package:envirocar/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUp extends StatelessWidget {
  static String routeName = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _key = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();

  bool _securePassword = true, _secureConfirmPassword = true;
  String _userName, _password, _confirmPassword, _email;
  bool termsConditionsCheckBox = false, privacyStatementCheckBox = false;

  void togglePassword() {
    setState(() {
      _securePassword = !_securePassword;
    });
  }

  void toggleConfirmPassword() {
    setState(() {
      _secureConfirmPassword = !_secureConfirmPassword;
    });
  }

  bool emailValidator(String mail) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(mail);
  }

  bool passwordValidator(String pass) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(pass);
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            Container(
              padding: null,
              margin: null,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/map_bg.jpg'),
                    fit: BoxFit.cover
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: null,
                margin: null,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        CarioColors.blueDarkCario,
                        CarioColors.blueLightCario.withOpacity(0.8),
                      ]
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Image.asset('assets/images/envirocar_logo_white.png'),
                    ),
                    SizedBox(height: 16),
                    Container(
                      child: Text('Sign Up',
                        style: TextStyle(
                          color: CarioColors.whiteCario,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            // height: 50,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              enableSuggestions: true,
                              textInputAction:
                              TextInputAction.next,
                              keyboardType:
                              TextInputType.text,
                              controller: userNameController,
                              validator: (input) {
                                if (input.isEmpty || input.length == 0)
                                  return "This field is required";
                                if (input.length < 6)
                                  return "The user name is too short";
                                return null;
                              },
                              onChanged: (input) {
                                _userName = input;
                              },
                              onFieldSubmitted: (input) {
                                _userName = input;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                fillColor: Colors.black26,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                enabledBorder:
                                OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.grey[300],
                                ),
                                hintText: "Username",
                                hintStyle: TextStyle(
                                  color: CarioColors.whiteCarioTransparent,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                              ),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            // height: 50,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              enableSuggestions: true,
                              textInputAction:
                              TextInputAction.next,
                              keyboardType:
                              TextInputType.text,
                              controller: emailController,
                              validator: (input) {
                                if (input.isEmpty || input.length == 0)
                                  return "This field is required";
                                if (!emailValidator(input)) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                              onChanged: (input) {
                                _email = input;
                              },
                              onSaved: (input) {
                                _email = input;
                              },
                              onFieldSubmitted: (input) {
                                _email = input;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                fillColor: Colors.black26,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.grey[300],
                                ),
                                hintText: "E-Mail",
                                hintStyle: TextStyle(
                                  color: CarioColors.whiteCarioTransparent,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                              ),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            // height: 50,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              enableSuggestions: true,
                              obscureText: _securePassword,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              validator: (input) {
                                if (input.isEmpty || input.length == 0)
                                  return "This field is required";
                                if (input.length < 6)
                                  return "This password is too short";
                                if (!passwordValidator(input))
                                  return "Password must contain at least one uppercase letter,\n one lowercase letter and one digit";
                                return null;
                              },
                              onChanged: (input) {
                                _password = input;
                              },
                              onSaved: (input) {
                                _password = input;
                              },
                              onFieldSubmitted: (input) {
                                _password = input;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                fillColor: Colors.black26,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey[300],
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      togglePassword();
                                    });
                                  },
                                  child: Icon(
                                    _securePassword ? Icons.remove_red_eye : Icons.visibility_off,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: CarioColors.whiteCarioTransparent,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                              ),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            // height: 50,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              enableSuggestions: true,
                              obscureText: _secureConfirmPassword,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              controller: confirmPasswordController,
                              validator: (input) {
                                if (input.isEmpty || input.length == 0)
                                  return "This field is required";
                                if (_confirmPassword != _password)
                                  return "The Passwords do not match";
                                return null;
                              },
                              onChanged: (input) {
                                _confirmPassword = input;
                              },
                              onSaved: (input) {
                                _confirmPassword = input;
                              },
                              onFieldSubmitted: (input) {
                                _confirmPassword = input;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                fillColor: Colors.black26,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          30)),
                                  borderSide: new BorderSide(
                                      width: 0,
                                      color: Colors.black26),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey[300],
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      toggleConfirmPassword();
                                    });
                                  },
                                  child: Icon(
                                    _secureConfirmPassword ? Icons.remove_red_eye : Icons.visibility_off,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  color: CarioColors.whiteCarioTransparent,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                              ),
                              style: TextStyle(
                                  color: CarioColors.whiteCario,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.center,
                            child: CheckboxListTileFormField(
                              initialValue: termsConditionsCheckBox,
                              onSaved: (val) {
                                setState(() {
                                  termsConditionsCheckBox = !termsConditionsCheckBox;
                                });
                              },
                              validator: (value) {
                                if (!value)
                                  return "Required";
                                return null;
                              },
                              title: new RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey[200]),
                                    children: [
                                      TextSpan(text: 'I acknowledge I have read and agree to enviroCar\'s'),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // TODO:
                                            },
                                        text: ' Terms and Conditions',
                                        style: TextStyle(color: CarioColors.pressedCario)
                                      ),
                                    ]
                                ),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Colors.white,
                              checkColor: Colors.blue[800].withOpacity(0.88),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.center,
                            child: CheckboxListTileFormField(
                              initialValue: privacyStatementCheckBox,
                              onSaved: (val) {
                                setState(() {
                                  privacyStatementCheckBox = !privacyStatementCheckBox;
                                });
                              },
                              validator: (value) {
                                if (!value)
                                  return "Required";
                                return null;
                              },
                              title: new RichText(
                                text: TextSpan(
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey[200]),
                                    children: [
                                      TextSpan(text: 'I have taken note of'),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // TODO:
                                            },
                                          text: ' Privacy Statement',
                                          style: TextStyle(color: CarioColors.pressedCario)
                                      ),
                                    ]
                                ),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Colors.white,
                              checkColor: Colors.blue[800].withOpacity(0.88),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            width: 225,
                            height: 50,
                            child: MaterialButton(
                              elevation: 0,
                              color: CarioColors.carioColorPrimaryDark,
                              highlightColor: CarioColors.pressedCario,
                              splashColor: CarioColors.pressedCario,
                              onPressed: () {
                                if (_key.currentState.validate()) {
                                  print('Username $_userName');
                                  print('Email $_email');
                                  print('Token $_password');
                                  register(context);
                                }
                              },
                              child: Text('Submit',
                                style: TextStyle(
                                    color: CarioColors.whiteCario,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(35),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Text(
                              'Do you already have an account?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, SignIn.routeName);
                              },
                              child: Text(
                                'Sign In here!',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: CarioColors.whiteCario,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future register(BuildContext context) async {
    try {
      final Uri postUrl = Uri.parse(baseUrl + "users");
      print(postUrl);
      Response response = await post(
        postUrl,
        body: jsonEncode({
          "name": _userName,
          "mail": _email,
          "token": _password,
          "acceptedPrivacy" : true,
          "acceptedTerms": true
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please verify your mail! A verification link has been sent to your email'),
            duration: Duration(seconds: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      if (response.statusCode == 409) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up unsuccessful! Username already exists'),
            duration: Duration(seconds: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

    } catch (e) {
      print(e.toString());
    }
  }

}