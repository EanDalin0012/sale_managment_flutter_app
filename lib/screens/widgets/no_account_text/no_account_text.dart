import 'package:flutter/material.dart';
import 'package:sale_managment/screens/constants.dart';
import 'package:sale_managment/screens/size_config.dart';

class NoAccountText extends StatelessWidget {

  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => onTabToSignUp(),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }

  onTabToSignUp () {
    print('Sign Up Click');
  }
}
