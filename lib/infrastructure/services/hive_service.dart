import 'package:cheapest_app/infrastructure/models/product_model.dart';
import 'package:cheapest_app/utilities/constants/hive_database_keys.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveService {
  Box<dynamic> cartBox;

  Future<void> initialise() async {
    final appDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    Hive.registerAdapter(ResultAdapter());
    cartBox = await Hive.openBox<Result>(HiveDatabaseKeys.cart);
  }

  void close() {
    cartBox.close();
  }

  Future<void> persistProduct(Result p) async {
    List<Result> products = cartBox.values.toList();
    Result product = products.firstWhere((element) => element.id == p.id, orElse: () => null);
    if (product != null) {
      product.count += 1;
    } else {
      await cartBox.add(p);
    }
  }
}
