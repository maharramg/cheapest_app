import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final TextInputType textInputType;
  final String fieldText;
  final Function onChanged;
  final bool autoFocus;
  final bool uppercase;
  final bool obscureText;

  CustomTextField({
    this.autoFocus,
    this.controller,
    this.prefixIcon,
    this.fieldText,
    this.textInputType,
    this.onChanged,
    this.uppercase,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57.5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      child: CupertinoTextField(
        obscureText: obscureText ?? false,
        // inputFormatters: [uppercase == null ? UpperCaseFormatter() : LowerCaseInputFormatter()],
        autofocus: autoFocus ?? false,
        controller: controller,
        keyboardType: textInputType,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        style: bodyText2,
        onChanged: onChanged,
        placeholder: fieldText,
        placeholderStyle: bodyText2.copyWith(color: Colors.grey),
        prefix: Row(
          children: <Widget>[
            SizedBox(width: 10.0),
            Icon(prefixIcon, color: Colors.black.withOpacity(.6)),
          ],
        ),
        clearButtonMode: OverlayVisibilityMode.editing,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey.withOpacity(.07),
        ),
      ),
    );
  }
}

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.length > 0 ? "${newValue.text[0].toUpperCase()}${newValue.text.substring(1)}" : "",
      selection: newValue.selection,
    );
  }
}

class LowerCaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: "${newValue.text.toLowerCase()}",
      selection: newValue.selection,
    );
  }
}
