import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/share/constant/constantcolor.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/key/m_key.dart';

class CustomerItems extends StatefulWidget {
  final Color color;
  Map vCustomer;
  CustomerItems({
    this.color,
    this.vCustomer
  });

  @override
  _CustomerItemsState createState() => _CustomerItemsState();
}

class _CustomerItemsState extends State<CustomerItems> {
  Size size ;
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var controller = TextEditingController();
  List<dynamic> vData = [];
  int itemLength = 0;
  var isNative = false;

  @override
  void initState() {
    super.initState();
    this._fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          _container(),
          this.vData.length > 0 ? _buildBody(): Container(),
          SizedBox(height: 70,)
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Package of Product'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            // this.isNative = !isNative;
            // this.isItemChanged = false;
            // this.isFilterByProduct = false;
          }),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: size.width,
              child: _buildSearchWidget(
                text: controller.text,
                // onChanged: (text) => setState(() => this.text = text),
                hintText: 'Search by name', onTap: () {  },
              ),
            ),
            // _buildFilterByProduct()
          ],
        ),
      ): null,
    );
  }

  Container _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      width: size.width,
      padding: EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child:  Text(
        'Package of Product List',
        style: containStyle,
      ),
    );
  }

  Widget _buildBody () {
    return Expanded(
        child: new FutureBuilder(
            future: _fetchItems(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.separated(
                  itemCount: vData.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.purple[900].withOpacity(0.5),
                  ),
                  itemBuilder: (context, index) {
                    return _buildListTile(
                        customer: vData[index]
                    );
                  },
                );
                // return ListView(
                //   children: items.map((e) => _buildListTile1(dataItem: e)).toList(),
                // );
              }
            }
        )
    );
  }

  Widget _buildListTile({
    @required Map customer
  }) {
    return ListTile(
      // onTap: () => selectPackageProduct(dataItem),
      title: Text( customer[CustomerKey.customerName],
        style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      leading: _buildLeading(url: 'url'),
      subtitle: Text(
        customer[CustomerKey.phone],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing: Container(
        width: 130,
        child: _buildCheckIcon()
      ),
    );
  }

  Widget _buildCheckIcon() {
    return Container(
      margin: EdgeInsets.only(
          top: 15,
          left: 10
      ),
      child: Center(child: FaIcon(FontAwesomeIcons.checkCircle, size: 25 , color: Colors.deepPurple)),
    );
  }

  Widget _buildSearchWidget({
    @required String text,
    @required String hintText,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    final styleActive = TextStyle(color: Colors.black, fontSize: 15);
    final styleHint = TextStyle(color: Colors.black54);
    final style = text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: InkWell(
              onTap: () {
                print('data search');
              },
              child: Icon(Icons.search, color: style.color)),
          suffixIcon: text.isNotEmpty ? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller.clear();
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ) : null,
          hintText: hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: styleInput,
        onChanged: (value) {
          // if(value != null || value.trim() != '') {
          //   this.isItemChanged = true;
          //   if(value != null || value.trim() != '') {
          //     setState(() {
          //       items = onItemChanged(value);
          //     });
          //   }
          // }
        },
      ),
    );
  }

  Widget _buildLeading({
  @required String url
  }) {
    var url = 'https://icons-for-free.com/iconfiles/png/512/part+1+p-1320568343314317876.png';
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundImage:NetworkImage(url),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/customer_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['customers'];
      this.itemLength = this.vData.length;
    });
    print('${this.vData}');
    return this.vData;
  }

}
