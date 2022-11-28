import 'package:elbahreen/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../constants/app_strings.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(image: AssetImage(AssetsManager.notFoundImg)),
        Text(translate(AppStrings.sWrongMessage)),
        Text(translate(AppStrings.sNoDataMessage)),
      ],
    );
  }
}
