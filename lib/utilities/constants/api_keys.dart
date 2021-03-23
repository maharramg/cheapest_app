class ApiKeys {
  ApiKeys._();

  static const baseUrl = "https://cheapestapp.herokuapp.com/api";

  static const headers = {"Content-Type": "application/json"};

  static const login = "$baseUrl/auth/login";

  static const register = "$baseUrl/auth/register";

  static const profile = "$baseUrl/auth/myprofile";

  static const products_search = "$baseUrl/products";

  static const restaurants = "$baseUrl/restaurants";

  static const order = "$baseUrl/order/";
}
