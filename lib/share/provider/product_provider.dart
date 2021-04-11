import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sale_managment/share/model/data/product.dart';

class ProductProvider with ChangeNotifier{

  Future loadCountries() async {
    final data = await rootBundle.loadString('assets/json_data/country_codes.json');
    final countriesJson = json.decode(data);
    // return countriesJson.keys.map<ProductModel>((code) {
    //   final json = countriesJson[code];
    //   final newJson = json..addAll({'code': code.toLowerCase()});
    //   return ProductModel.fromJson(newJson);
    // }).toList()
    //   ..sort(Utils.ascendingSort);
  }
}
