import 'package:cheapest_app/infrastructure/services/hive_service.dart';
import 'package:cheapest_app/infrastructure/services/preferences_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await PreferencesService.instance;
  locator.registerSingleton<PreferencesService>(prefs);
  locator.registerSingleton<HiveService>(HiveService());
}
