import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_managment/share/model/product.dart';
import 'package:sale_managment/screens/widgets/product_dropdown/product_list_tile_widget.dart';
class ProductPage extends StatefulWidget {
  final ProductModel productModel;

  const ProductPage({
    Key key,
    this.productModel,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isNative = false;
  String text = '';
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: new FutureBuilder(
          future: _fetchListItems(),//DefaultAssetBundle.of(context).loadString('assets/json_data/product_list.json'),
            builder: (context, snapshot) {
            //   if(snapshot.data != null) {
            //     var data = snapshot.data;
            //     Map valueMap = jsonDecode(data);
            //     var products = valueMap['products'];
            //     var objs =  products.map<ProductModel>((json) {
            //       return ProductModel.fromJson(json);
            //     }).toList();
            //     print(''+objs.toString());
            //
            //     return ListView(
            //       children: objs.map((e) => ListTile(
            //         title: Text('data'),
            //       )).toList(),
            //     );
            //   }
            // }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                    // child: ListView.builder(
                    //     itemCount: _faouriteList.length,
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Text('${_faouriteList[index].title}');
                    //     }
                    // )
                  child: Text('data'),
                );
              }
          }
        ),
      ),
    );
  }

  Widget buildAppBar() {
    final label =  'Product';

    return AppBar(
      title: Text('Select $label'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.language),
          onPressed: () => setState(() => this.isNative = !isNative),
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(preferredSize: Size.fromHeight(60),
        child: buildSearchWidget(
          text: text,
          // onChanged: (text) => setState(() => this.text = text),
          hintText: 'Search $label',
        ),
      ),
    );
  }


  Widget buildSearchWidget({
    @required String text,
    @required String hintText,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    final styleActive = TextStyle(color: Colors.black);
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
          icon: Icon(Icons.search, color: style.color),
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
        style: style,
      ),
    );
  }

  List<ProductModel> parseJosn(String response) {
    print('response:'+response);
    if(response==null){
      return [];
    }
    final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
    // return parsed.map<ProductModel>((json) => new ProductModel.fromJson(json);
    return null;
  }
  _fetchListItems() async {
    final data = await rootBundle.loadString('assets/json_data/country_codes.json');
    final countriesJson = json.decode(data);
    return countriesJson;
  }
}
