import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laroch/const/common_lib.dart';
class PaymentFail extends StatefulWidget {
  const PaymentFail({super.key});

  @override
  State<PaymentFail> createState() => _PaymentFailState();
}

class _PaymentFailState extends State<PaymentFail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToPage();
  }
  navigateToPage() async {

    Timer(const Duration(seconds: 2), () {

      Navigator.pop(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(onWillPop: ()async{

      return true;

    },
      child: Container(
      color: Colors.white,
        child: Center(
          child: Icon(Icons.error,color: appColors.red,size: 200,),
        ),
      ),
    );
  }
}
