import 'package:elbahreen/presentation/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FToast fToast = FToast();
showToast(String? text){
  Fluttertoast.showToast(msg: text!,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppColor.red,
    textColor: AppColor.white,
  );
}