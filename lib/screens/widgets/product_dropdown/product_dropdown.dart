import 'package:flutter/material.dart';
import 'package:sale_managment/screens/widgets/contry_dropdown/country_page.dart';
import 'package:sale_managment/screens/widgets/contry_dropdown/flag_widget.dart';
import 'package:sale_managment/share/model/country.dart';

class ProductDropdown extends StatefulWidget {
  @override
  _ProductDropdownState createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  CountryModel country;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
        child: buildSingleCountry(),
      );
  }

  Widget buildSingleCountry() {
    final onTap = () async {
      final country = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CountryPage()),
      );

      if (country == null) return;

      setState(() {
        this.country = country;
        print(this.country.toString());
      });
    };

    return buildCountryPicker(
      title: 'Select Country',
      child: country == null? buildListTile(title: 'No Country', onTap: onTap)
          : buildListTile(
        title: country.name,
        leading: FlagWidget(code: country.code),
        onTap: onTap,
      ),
    );
  }

  Widget buildListTile({
    @required String title,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  Widget buildCountryPicker({
    @required String title,
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );
}
