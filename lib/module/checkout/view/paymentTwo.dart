import 'dart:developer';

import 'package:flutter/material.dart';

import 'interswitchService.dart';
import 'package:webview_flutter/webview_flutter.dart';



class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}


class _PaymentScreenState extends State<PaymentScreen> {
  final InterswitchService interswitchService = InterswitchService();


  Future<void> _makePayment() async {
    try {
      final authToken = await interswitchService.getAuthToken();
      log(authToken.toString()+"token");
    //  await interswitchService.makePayment(authToken, 5000.0, 'Default_Payable_MX53449');
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>PageView()




            //PaymentWebView('https://your-payment-url.com'),
      ));
    } catch (e) {
      print('Error: $e');
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _makePayment();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interswitch Payment')),
      body: Center(
        child: ElevatedButton(
          onPressed: _makePayment,
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}
