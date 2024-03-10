import 'package:flutter/material.dart';
import 'register.dart';

class Login extends StatefulWidget {
  Login({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFCF9F9E8),
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Container(
                child: Image.asset(
                  'assets/logo.png',
                  height: 70,
                  width: 70,
                ),
              ),
            ),
            Text(
              'ParkBuddy',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
        toolbarHeight: 110,
      ),

      body: Column(
        children: <Widget>[
          SizedBox(height: 100),
          Center(
            child: Text(
              'Welcome back',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 35,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Login to your account',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(70, 50, 70, 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username or email',
              ),
              style: TextStyle(height: 0.1),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(70, 0, 70, 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              style: TextStyle(height: 0.1),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(70, 0, 70, 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                  'Forgot Password ?',
                style: TextStyle(color: Color(0xFF023307),fontWeight: FontWeight.w500),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => Home()),
              // );
            },
            style: TextButton.styleFrom(
                minimumSize: Size(280, 0),
                backgroundColor: Colors.green[900],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
            child: Text(
              'Log In',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
            ),
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(80, 200, 0, 20),
                  child: Text(
                    'Don\'t have an Account? ',
                    style: TextStyle(fontSize: 14),
                  )),
              GestureDetector(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 200, 0, 20),
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 14, color: Color(0xFF5F7B5D)),
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      // Image(
      //   image: AssetImage(),
      // ),
    );
  }
}
