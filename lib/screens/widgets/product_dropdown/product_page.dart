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

  var isNative = false;
  var text = '';
  var controller = TextEditingController();
  var isSearch = false;
  var isItemChanged = false;

  List<ProductModel> items;
  List<ProductModel> itemsTmp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: new FutureBuilder(
            future: _fetchListItems(),
            //DefaultAssetBundle.of(context).loadString('assets/json_data/product_list.json'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                var productName = '';
                var obj = widget.productModel;
                if(obj != null) {
                  productName = obj.name.toLowerCase();
                }
                return ListView(
                  children: items.map((e) {
                    return ProductListTileWidget(
                      productModel: e,
                      isSelected: e.name.toLowerCase() == productName,
                      onSelectedProduct: selectProduct,
                    );
                  }).toList(),
                  // itemCount: items.length,
                  // scrollDirection: Axis.horizontal,
                  // itemBuilder: (BuildContext context, int index) {
                  //   return ProductListTileWidget(
                  //     productModel: items[index],
                  //   );
                  // }
                );
              }
            }
        ),
      ),
    );
  }

  Widget buildAppBar() {
    final label = 'Product';

    return AppBar(
      title: Text('Select $label'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() => this.isNative = !isNative),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  buildSearchWidget(
          text: text,
          // onChanged: (text) => setState(() => this.text = text),
          hintText: 'Search $label',
        ),
      ): null,
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
        style: style,
        onChanged: (value) {
          this.isItemChanged = true;
          if(value != null || value.trim() != '') {
            setState(() {
              items = onItemChanged(value);
            });
          }
        },
      ),
    );
  }

  List<ProductModel> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed = json.decode(response.toString()).cast<
        Map<String, dynamic>>();
    // return parsed.map<ProductModel>((json) => new ProductModel.fromJson(json);
    return null;
  }

  _fetchListItems() async {
    if(isItemChanged == true) {
      if(controller.text != null) {
        setState(() {
          isItemChanged = true;
          items = onItemChanged(controller.text);
        });
      }
      return items;
    }  else {
      final data = await rootBundle.loadString('assets/json_data/product_list.json');
      Map valueMap = jsonDecode(data);
      var products = valueMap['products'];
      var objs = products.map<ProductModel>((json) {
        return ProductModel.fromJson(json);
      }).toList();
      items = objs;
      itemsTmp = items;
      return objs;
    }

  }

  void selectProduct(ProductModel productModel) {
    // setState(() {
    //   final isSelected = items.contains(productModel);
    //   print(isSelected);
    // });
    Navigator.pop(context, productModel);
  }

  onItemChanged(String value) {
    var dataItems = itemsTmp.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }
}
