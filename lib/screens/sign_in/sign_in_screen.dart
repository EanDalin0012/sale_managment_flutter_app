import 'package:flutter/material.dart';
import 'package:sale_managment/screens/sign_in/widget/body_sign_in.dart';
import 'package:sale_managment/share/constant/text_style.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign In", style: TextStyle(fontFamily: fontFamilyDefault),),
      // ),
      body: SignInBody(),
    );
  }
}
