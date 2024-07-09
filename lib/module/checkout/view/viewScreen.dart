import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:laroch/module/checkout/view/faildPayment.dart';
import 'package:laroch/module/checkout/view/paymentSuccess.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../home/views/home.dart';
class ViewPayment extends StatefulWidget {
  String urlRedirect;
   ViewPayment({super.key,required this.urlRedirect});

  @override
  State<ViewPayment> createState() => _ViewPaymentState();
}

class _ViewPaymentState extends State<ViewPayment> {
  late WebViewController controller;
  List<String> dataCookie = [];
  //String url='https://www.larochenigeria.com/shop/failure.php?msg=2';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.urlRedirect),
      );
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    getCoookie();
    controller.setNavigationDelegate(
     NavigationDelegate (onPageStarted: (String url) {
       if(url=="https://www.larochenigeria.com/shop/failure.php?orderid="){
         Navigator.pop(context);
         Navigator.pop(context);
         Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentFail()));
         debugPrint('Page started loading: $url');
       }
       else if(url.contains('https://larochenigeria.com/shop/success.php')){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentSuccess()));


       }
      debugPrint('Page started loading: $url');
    }),);
  }

  void getCoookie() async {
    final String cookies = await controller
        .runJavaScriptReturningResult('document.cookie') as String;
    log("Cookie Data  $cookies");
    dataCookie = cookies.split(";");
    var newCookie = dataCookie[0].split('=');
    log("new cookies+$newCookie");
  }
    Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Container(
      child: WebViewWidget(
        controller: controller,



      ),
    ),);
  }
}
