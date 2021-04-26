import 'package:flutter/material.dart';
import 'package:sale_managment/screens/sign_up/widget/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SignUpBody(),
    );
  }
}
