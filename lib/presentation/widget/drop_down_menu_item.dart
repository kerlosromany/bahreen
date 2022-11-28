import 'package:flutter/material.dart';

import '../widget/default_text.dart';

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: DefaultText(text: item, fontWeight: FontWeight.bold),
    );
