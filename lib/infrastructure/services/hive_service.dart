import 'package:cheapest_app/utilities/constants/hive_database_keys.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveService {
  Box<dynamic> cartBox;

  Future<void> initialise() async {
    final appDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    cartBox = await Hive.openBox<dynamic>(HiveDatabaseKeys.cart);
  }

  void close() {
    cartBox.close();
  }

  // Future<void> persistCartCount(int value) async => await cartBox.put(HiveFieldKeys.cart_count, value);
  // Future<void> persistCartPrice(double value) async => await cartBox.put(HiveFieldKeys.cart_price, value);
}
