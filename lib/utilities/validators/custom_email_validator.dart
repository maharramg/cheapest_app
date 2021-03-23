import 'package:email_validator/email_validator.dart';

class CustomEmailValidator {
  static isValidEmail({String email}) {
    return EmailValidator.validate(email);
  }
}
