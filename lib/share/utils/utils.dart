import 'package:sale_managment/share/model/country.dart';

class Utils {
  static int ascendingSort(CountryModel c1, CountryModel c2) =>
      c1.name.compareTo(c2.name);
}
