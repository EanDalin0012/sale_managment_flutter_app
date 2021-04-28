import 'package:flutter/material.dart';
import 'package:sale_managment/screens/constants.dart';
import 'package:sale_managment/screens/size_config.dart';
import 'package:sale_managment/screens/widgets/custom_surfix_icon/custom_surfix_icon.dart';
import 'package:sale_managment/screens/widgets/default_button/default_button.dart';
import 'package:sale_managment/share/helper/keyboard.dart';

class ProductFormAdd extends StatefulWidget {
  @override
  _ProductFormAddState createState() => _ProductFormAddState();
}

class _ProductFormAddState extends State<ProductFormAdd> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String conform_password;
  bool remember = false;
  final List<String> errors = [];
  Size size;
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
              _buildNameField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildCategoryField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildBrowsField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildRemarkField(),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              DefaultButton(
                text: "Save",
                color: Colors.red,
                borderRadiusCircular: 25,
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    // if all are valid then go to success screen

                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Home()),
                  // );
                  KeyboardUtil.hideKeyboard(context);
                },
              )
            ]
        )
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter product name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurfFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Remark",
        hintText: "Enter remark",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildCategoryField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Category",
        hintText: "Select category",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildBrowsField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Brows",
        hintText: "Brows to image",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/attachment_black_24dp.svg"),
      ),
    );
  }

}
