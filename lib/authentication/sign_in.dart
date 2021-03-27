import 'package:envirocar/authentication/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  static String routeName = '/sign_in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final _key = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _securePassword = true;
  String _userName, _password;

  void toggle() {
    setState(() {
      _securePassword = !_securePassword;
    });
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/map_bg.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[800].withOpacity(0.998),
                      Colors.cyan.withOpacity(0.899),
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
                      child: Text('Sign In',
                        style: TextStyle(
                          color: Colors.white,
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
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              controller: userNameController,
                              validator: (input) {
                                if (input.isEmpty || input.length == 0)
                                  return "This field is required";
                                if (input.length < 6)
                                  return "User name is too short";
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
                                  Icons.person,
                                  color: Colors.grey[300],
                                ),
                                hintText: "Username",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
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
                              keyboardType: TextInputType.emailAddress,
                              controller: passwordController,
                              validator: (input) {
                                if (input.isEmpty || input.length == 0)
                                  return "This field is required";
                                return null;
                              },
                              onChanged: (input) {
                                _password = input;
                              },
                              obscureText: _securePassword,
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
                                  onTap: toggle,
                                  child: Icon(
                                    _securePassword ? Icons.remove_red_eye : Icons.visibility_off,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
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
                          SizedBox(height: 40),
                          Container(
                            width: 225,
                            height: 50,
                            child: MaterialButton(
                              elevation: 0,
                              color: Colors.black54,
                              onPressed: () {
                                if (_key.currentState.validate()) {
                                  print('Username $_userName');
                                  print('Token $_password');

                                }
                              },
                              child: Text('Login',
                                  style: TextStyle(
                                    color: Colors.grey[200],
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
                              'Do you do not have an account yet?',
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
                                Navigator.pushNamed(context, SignUp.routeName);
                              },
                              child: Text(
                                'Register here!',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.grey[200],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}