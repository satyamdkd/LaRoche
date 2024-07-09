import 'dart:async';

import 'package:flutter/material.dart';

import '../../home/views/home.dart';
import '../bloc/checkout_bloc.dart';
class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  CheckOutController checkOutController = CheckOutController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToPage();
  }
  @override

  navigateToPage() async {

    Timer(const Duration(seconds: 2), () {

      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>Home()), (route) => false);
    });
  }

  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: Center(

        child: Column(
          children: [
            Container(height: 100,width: 100,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                child: Icon(Icons.done_outlined,color: Colors.white,size: 80,)),
            Text("Payment cancelled",style: TextStyle(color: Colors.black),)
          ],
        ),
      ),
    );
  }
}
