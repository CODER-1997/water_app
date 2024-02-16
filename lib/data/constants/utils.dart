import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Utils {
  static var phoneMaskFormatter = MaskTextInputFormatter(
      mask: '+998 ## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static Color getColor(String status) {
    if(status=='new'){
      return Colors.blue;
    }
   else if(status=='accepted'){
      return Colors.green;
    }
    else if(status=='rejected'){
      return Colors.red;
    }
   return Colors.deepPurpleAccent;
  }
}
