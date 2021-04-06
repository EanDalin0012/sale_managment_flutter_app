import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/screens/customer/Customer.dart';
import 'package:sale_managment/screens/product/Product.dart';
import 'package:sale_managment/screens/vendor/Vendor.dart';

class SheetContainer extends StatefulWidget {
  @override
  _SheetContainerState createState() => _SheetContainerState();
}

class _SheetContainerState extends State<SheetContainer> {
  var colorContain = Color(0xffd9dbdb).withOpacity(0.9);
  Color _textColor= Colors.purple[900];
  Color _iconColor = Colors.purple[900];
  double _iconSize = 25;
  double wContainer = 60;
  double hContainer = 50;
  BoxBorder border = Border.all(color: Colors.blueGrey[100], width: 5);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = (size.width / 3) - 25;
    double h = w - 20;
    print('w:$w,h:$h');
    return Container(
      color: Color(0xFF737373),
      child: Container(
          padding: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Color(0xfff1f1f1)
          ),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  drawerHandler(),
                  item1(w,h),
                  SizedBox(height: 20,),
                  item0(w, h),
                ]
            ),
          )
      ),
    );
  }

  drawerHandler() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 5,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffd9dbdb)
      ),
    );
  }

  item1(double w, double h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Vendor()),
            );
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                      border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.cuttlefish,size: _iconSize , color: _iconColor,)),
                ),
                SizedBox(height: 5,),
                Text('Category',style: TextStyle(fontWeight: FontWeight.w900, color: Colors.purple[900])),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Product()),
            );
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                    border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.productHunt,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Product',style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15,color: Colors.purple[900])),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print('Vendor Click');
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                    border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.vimeo,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Vendor',style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15,color: Colors.purple[900])),
              ],
            ),
          ),
        ),
      ],
    );
  }

  item0(double w, double h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Customer()),
            );
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                    border: border
                  ),
                  child:Center(child: FaIcon(FontAwesomeIcons.users,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Member',style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15,color: Colors.purple[900])),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print('Vendor Click');
          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                    border: border
                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.layerGroup,size: _iconSize,color: _iconColor)),
                ),
                SizedBox(height: 5,),
                Text('Import',style: TextStyle(fontWeight: FontWeight.w900, color: Colors.purple[900]),),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {

          },
          child: Container(
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorContain,
                    borderRadius: BorderRadius.circular(50),
                    border: border

                  ),
                  child: Center(child: FaIcon(FontAwesomeIcons.database,size: _iconSize, color: _iconColor,)),
                ),
                SizedBox(height: 5,),
                Text('Stock',style: TextStyle(fontWeight: FontWeight.w900, color: Colors.purple[900])),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
