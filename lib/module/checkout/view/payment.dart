

import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';
import 'package:isw_mobile_sdk/models/isw_mobile_sdk_payment_info.dart';
import 'package:isw_mobile_sdk/models/isw_mobile_sdk_sdk_config.dart';

import '../../../utils/helper/sharedpref.dart';



class Payment extends StatefulWidget {
  String ?order_id;
  String ?user_id;
   Payment({super.key,required this.user_id,required this.order_id});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _amountString = '';

  @override
  void initState() {
    super.initState();
    initSdk();
  }

  Future<void> initSdk() async {

    // messages may fail, so we use a try/catch PlatformException.
    try {
      String  merchantId = "MX53449",

          merchantSecret = "D3D1D05AFE42AD50818167EAC73C109168A0F108F32645C8B59E897FA930DA44F9230910DAC9E20641823799A107A02068F7BC0F4CC41D2952E249552255710F",
          merchantCode = "Default_Payable_MX53449",
          currencyCode = "566"; // e.g  566 for NGN

      var config = new IswSdkConfig (
          merchantId,
          merchantSecret,
          merchantCode,
          currencyCode
      );
log(config.toMap().toString());
      // initialize the sdk
      await IswMobileSdk.initialize(config);
      // intialize with environment, default is Environment.TEST
      // IswMobileSdk.initialize(config, Environment.SANDBOX);

      log("integrate");
    } on PlatformException {

      log("garima");
    }
  }

  Future<void> pay(BuildContext context) async {
    // save form
    _formKey.currentState?.save();

    String customerId = "Default_Payable_MX53449",//"${SharedPref.getUserDetails()?['data']['userId']}",
        customerName = "satyam",//"${SharedPref.getUserDetails()?['data']['name']}",
        customerEmail = "satyam@gmail.com",//"${SharedPref.getUserDetails()?['data']["email"]}",
        customerMobile = "9987654345",//"${SharedPref.getUserDetails()?['data']['phone']}",
    // generate a unique random
    // reference for each transaction
       // reference = "<your-unique-ref>";
        reference = "56708";

    int amount;
    // initialize amount
    if (_amountString.isEmpty) {
      amount = 2500 * 100;
    } else {
      amount = int.parse(_amountString) * 100;
    }

    // create payment info
    IswPaymentInfo iswPaymentInfo = IswPaymentInfo(
        customerId,
        customerName,
        customerEmail,
        customerMobile,
        reference,
        amount
    );

    print(iswPaymentInfo);
    log(iswPaymentInfo.toString());

    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    var message;
    if (result.hasValue) {
      final paymentChannel = result.value?.channel.toString() ?? "Unknown";
      message = "You completed txn using: $paymentChannel";
    } else {
      message = "You cancelled the transaction pls try again";
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Charity Fortune'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    onSaved: (String? val) => _amountString = val ?? "0",
                  ),
                  Builder(
                    builder: (ctx) => Container(
                      width: MediaQuery.of(ctx).size.width,
                      child: ElevatedButton(
                        onPressed: () => pay(ctx),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40.0,
                                vertical: 20.0
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            backgroundColor: Colors.black
                        ),
                        child: const Text(
                          "Pay",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}