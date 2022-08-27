import 'package:flutter/material.dart';

import '../../../../core/utils/hex_color.dart';

class MessageFormField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  const MessageFormField({Key? key, this.onChanged,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller ,
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: 'الرسالة',
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        filled: true,
        fillColor: HexColor('#F5F5F5'),
      ),
      maxLines: 10,
      validator: (String? message) {
        if (message!.isEmpty) {
          return 'Should not be empty';
        }
      },
    );
  }
}
