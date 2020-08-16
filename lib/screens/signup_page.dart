import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_graph/components/reuseable_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:connectivity/connectivity.dart';
import 'login_page.dart';
import 'home_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  int flag = 0;
  String emailAdd = '';
  String passwd = '';
  String fName = '';
  String lName = '';
  String cPasswd = '';
  @override
  Widget build(BuildContext context) {
    final netDialogBox = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text('No Internet Access'),
      content: Text(
          'You\'re not connected to a Network.'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        )
      ],
    );

    final dialogBox = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text('Empty!!'),
      content: Text(
          'All fields are Mandatory.'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        )
      ],
    );

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.0,
        child: Icon(
          Icons.trending_up,
          size: 100.0,
        ),
      ),
    );

    final firstName = TextFormField(
      autofocus: false,
      onChanged: (value) {
        fName = value;
      },
      style: TextStyle(
        color: Colors.black45,
      ),
      decoration: InputDecoration(
        hintText: 'First Name',
        hintStyle: TextStyle(
          color: Colors.black26,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final lastName = TextFormField(
      autofocus: false,
      onChanged: (value) {
        lName = value;
      },
      style: TextStyle(
        color: Colors.black45,
      ),
      decoration: InputDecoration(
        hintText: 'Last Name',
        hintStyle: TextStyle(
          color: Colors.black26,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onChanged: (value) {
        emailAdd = value;
      },
      style: TextStyle(
        color: Colors.black45,
      ),
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(
          color: Colors.black26,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) {
        passwd = value;
      },
      style: TextStyle(
        color: Colors.black45,
      ),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(
          color: Colors.black26,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) {
        cPasswd = value;
      },
      style: TextStyle(
        color: Colors.black45,
      ),
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        hintStyle: TextStyle(
          color: Colors.black26,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final signUpButton = Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          setState(() {
            showSpinner = true;
          });
          var connectivity = await Connectivity().checkConnectivity();
          try {
            if(connectivity == ConnectivityResult.none){
              showDialog(
                context: context,
                builder: (context) {
                  return netDialogBox;
                },
              );
            }
            else if (emailAdd == '' && passwd == '' && cPasswd == '' && fName == '' && lName == ''){
              flag = 1;
              showDialog(
                context: context,
                builder: (context) {
                  return dialogBox;
                },
              );
            }
            else {
              final newUser = await _auth.createUserWithEmailAndPassword(
                  email: emailAdd, password: passwd);
              if (newUser != null && passwd == cPasswd)
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
            }
            setState(() {
              showSpinner = false;
            });
          } catch (e) {
            print(e);
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Sign Up',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
      ),
    );

    final logIn = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Already had an account? ',
          style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LogIn();
            }));
          },
          child: Text(
            'Log In',
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    logo,
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ReuseableCard(
                            colour: Colors.white,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                firstName,
                                SizedBox(height: 8.0),
                                lastName,
                                SizedBox(height: 8.0),
                                email,
                                SizedBox(height: 8.0),
                                password,
                                SizedBox(height: 8.0),
                                confirmPassword,
                                SizedBox(height: 10.0),
                                signUpButton,
                                SizedBox(height: 15.0),
                                logIn,
                              ],
                            ),
                          ),
                        )
                      ],
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
}
