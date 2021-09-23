import 'package:ecensus_nepal/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/images/eCensusNepal.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Hello, Ganak',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Sign into your account',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email Address'),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade100, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (String? email) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp emailRegExp = new RegExp(pattern.toString());

                          if (email!.isEmpty) return "Email cannot be empty";
                          if (!emailRegExp.hasMatch(email))
                            return "Enter a valid email";
                          return null;
                        }),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Password'),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade100, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      obscureText: true,
                      validator: (String? password) {
                        if (password!.isEmpty)
                          return "Password cannot be empty";
                        if (password.length < 8)
                          return "Password should be greater than 8 characters";
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _login,
              child: Text('Log In'),
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size.fromWidth(MediaQuery.of(context).size.width / 2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      print(_emailController.text);
      print(_passwordController.text);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => DashboardScreen()));
    }
  }
}
