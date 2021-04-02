import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/share/constant/icon/custome_icon.dart';

class SaleScreen extends StatefulWidget {
  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ProfileCategories(),
        ])
    );
  }
}

class Catg {
  String name;
  IconData icon;
  int number;
  Catg({this.icon, this.name, this.number});
}


List<Catg> listProfileCategories = [
  Catg(name: 'Wallet', icon: CustomIcon.account_balance_wallet, number: 0),
  Catg(name: 'Delivery', icon: CustomIcon.truck, number: 0),
  Catg(name: 'Message', icon: CustomIcon.chat, number: 2),
  Catg(name: 'Service', icon: CustomIcon.money, number: 0),
];

class FurnitureCategory extends StatelessWidget {
  final FurnitureCatg item;
  FurnitureCategory({@required this.item});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: Transform.rotate(
          angle: pi / 4,
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              boxShadow: [
                if (item.elivation)
                  BoxShadow(
                    color: Color(0xFFD1DCFF),
                    blurRadius: 5.0, // has the effect of softening the shadow
                    spreadRadius:
                    -1.0, // has the effect of extending the shadow
                    offset: Offset(10.0, 10.0),
                  )
              ],
              color: item.elivation ? profile_info_background : profile_info_categories_background,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Transform.rotate(
              angle: -pi / 4,
              child: Icon(
                item.icon,
                size: 30.0,
                color:
                item.elivation ? Colors.white : furnitureCateDisableColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FurnitureCatg {
  IconData icon;
  bool elivation;
  FurnitureCatg({this.icon, this.elivation});
}

//COLORS
const Color profile_info_background = Color(0xFF3775FD);
const Color profile_info_categories_background = Color(0xFF939BA9);
const Color furnitureCateDisableColor = Color(0xCD939BA9);

// da
class ProfileCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (Catg catg in listProfileCategories)
            Category(
              catg: catg,
            )
        ],
      ),
    );
  }
}



class Category extends StatelessWidget {
  final Catg catg;
  Category({this.catg});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (catg.name == listProfileCategories[0].name)
                  Navigator.pushNamed(context, '/furniture');
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: profile_info_categories_background,
                ),
                child: Icon(
                  catg.icon,
                  // size: 20.0,
                ),
              ),
            ),
            catg.number > 0
                ? Positioned(
              right: -5.0,
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: profile_info_background,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  catg.number.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),
                ),
              ),
            )
                : SizedBox(),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          catg.name,
          style: TextStyle(
            fontSize: 13.0,
          ),
        )
      ],
    );
  }
}
