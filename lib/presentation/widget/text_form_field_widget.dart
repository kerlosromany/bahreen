import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFormFieldWidget extends StatefulWidget {
  TextEditingController controller;
  TextInputType textInputType;
  String hintTxt;
  String textValidation;
  Widget? widget;
  String? text;
  TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.textInputType,
    required this.hintTxt,
    required this.textValidation,
    this.widget,
    this.text,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 2, color: Colors.grey)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 2, color: Colors.red)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 2, color: Colors.red)),
          hintText: widget.hintTxt,
          hintStyle: const TextStyle(fontWeight: FontWeight.w900),
          suffixIcon: widget.widget,
        ),
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
        validator: (value) {
          if (value!.isEmpty) {
            return widget.textValidation;
          }
          return null;
        },
        // onChanged: widget.text != null
        //     ? (value) {
        //         setState(() {
        //           widget.text = value;
        //           print(widget.text);
        //         });
        //       }
        //     : (value) {
        //         print(widget.text);
        //       },
      ),
    );
  }
}
