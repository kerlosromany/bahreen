import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("assets/images/NotFoundImg.png"),
          ),
          const Text("Somthing went wrong!!"),
          const Text("No data found"),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                onPrimary: Colors.red, padding: EdgeInsets.all(5.w)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("back"),
          )
        ],
      ),
    );
  }
}
