import 'package:flutter/material.dart';

import '../Screens/HomeScreen.dart';
import 'CreateAccount.dart';
import 'Methods.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/astro.jpg"), fit: BoxFit.cover)),
      child: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: size.width / 0.5,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 120),
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baloo',
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 105),
                    child: Container(
                      width: size.width / 1.1,
                      child: Text(
                        "Sign In to Continue",
                        style: TextStyle(
                          color: Color.fromARGB(255, 205, 200, 200),
                          fontSize: 25,
                          fontFamily: 'Baloo',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "Email", Icons.account_box, _email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "password", Icons.lock, _password),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CreateAccount())),
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontFamily: 'Baloo',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
    ));
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              print("Login Sucessfull");
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill form correctly");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromARGB(255, 3, 20, 75),
          ),
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Baloo'),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 205, 200, 200),
              fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white)),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
