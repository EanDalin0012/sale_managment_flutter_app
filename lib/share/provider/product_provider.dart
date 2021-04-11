import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sale_managment/share/model/country.dart';
import 'package:sale_managment/share/model/product.dart';
import 'package:sale_managment/share/utils/utils.dart';

class ProductProvider with ChangeNotifier{
  ProductProvider() {
    loadProducts().then((countries) {
      _countries = countries;
      print('countries:'+countries.toString());
      notifyListeners();
    });
  }

  List<CountryModel> _countries = [];

  List<CountryModel> get countries => _countries;

  Future loadProducts() async {
    final data = await rootBundle.loadString('assets/json_data/country_codes.json');
    final countriesJson = json.decode(data);
    return countriesJson.keys.map<CountryModel>((code) {
      final json = countriesJson[code];
      final newJson = json..addAll({'code': code.toLowerCase()});
      return CountryModel.fromJson(newJson);
    }).toList()
      ..sort(Utils.ascendingSort);
  }
}
