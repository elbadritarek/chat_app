import 'package:flutter/material.dart';

class customTextFeild extends StatelessWidget {
  const customTextFeild(
      {super.key,
      required this.hintText,
      this.maxLines = 1,
      this.onSaved,
      this.onChange,
      required this.textController,this.flag=false});
  final String hintText;
  final int maxLines;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChange;
  final TextEditingController textController;
  final bool flag;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onChanged: onChange,
      onSaved: onSaved,
      obscureText: flag,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "this feild is required";
        } else {
          return null;
        }
      },
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.blue),
        enabledBorder: BulderReduis(),
        focusedBorder: BulderReduis(color: Colors.black),
        border: BulderReduis(),
      ),
    );
  }

  OutlineInputBorder BulderReduis({color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
