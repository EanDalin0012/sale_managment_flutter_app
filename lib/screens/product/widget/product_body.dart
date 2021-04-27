import 'package:flutter/material.dart';
import 'package:sale_managment/screens/constants.dart';
import 'package:sale_managment/screens/size_config.dart';
import 'package:sale_managment/screens/product/widget/product_form_add.dart';

class ProductBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                    Text("Register Product", style: headingStyle),
                    Text(
                      "Complete your details",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    ProductFormAdd(),
                    Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            color: Colors.red,
                            // margin: EdgeInsets.only(
                            //   left: 5,
                            //   right: 5
                            // ),
                            child: Center(child: Text('SAVE', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                          ),
                        ),
                      ],
                    )
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
