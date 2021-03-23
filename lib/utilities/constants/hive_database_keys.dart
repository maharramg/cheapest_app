class HiveDatabaseKeys {
  static final HiveDatabaseKeys _instance = HiveDatabaseKeys._internal();

  HiveDatabaseKeys._internal();

  factory HiveDatabaseKeys() => _instance;

  static const cart = 'cart';
}