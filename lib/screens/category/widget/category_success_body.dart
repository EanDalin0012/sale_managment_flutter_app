import 'package:flutter/material.dart';
import 'package:sale_managment/screens/home/Home.dart';
import 'package:sale_managment/screens/size_config.dart';
import 'package:sale_managment/screens/widgets/default_button/default_button.dart';

class CategorySuccessBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Center(
            child: Image.asset(
              "assets/images/success.png",
              height: SizeConfig.screenHeight * 0.4, //40%
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Center(
            child: Text(
            "Success",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.7,
            child: DefaultButton(
              text: "Back to home",
              color: Colors.red,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );

              },
            ),
          ),
          Spacer(),
        ],
      );
  }
}
