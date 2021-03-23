class Printer {
  static void debug({api, body, response}) {
    if (api != null) {
      print("URL -> $api");
    }

    if (body != null) {
      print("BODY -> $body");
    }

    if (response != null) {
      print("RESPONSE -> $response");
    }
  }

  static void token({token}) {
    if (token != null) {
      print("TOKEN -> $token");
    }
  }
}
