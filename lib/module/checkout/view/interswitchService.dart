 import 'dart:convert';
// import 'dart:developer';
 import 'package:http/http.dart' as http;
//
// class InterswitchService {
//   final String clientId = "MX53449";
//   final String clientSecret = 'D3D1D05AFE42AD50818167EAC73C109168A0F108F32645C8B59E897FA930DA44F9230910DAC9E20641823799A107A02068F7BC0F4CC41D2952E249552255710F';
//   final String authUrl ='https://qa.interswitchng.com/passport/oauth/token'; //'https://qa.interswitchng.com/kmw/requesttoken/perform-process';
//   final String paymentUrl = 'https://qa.interswitchng.com/collections/api/v1/payments';//'https://newwebpay.interswitchng.com/collections/w/pay';
//
//   Future<String> getAuthToken() async {
//     final String auth = base64Encode(utf8.encode('$clientId:$clientSecret'));
//     final response = await http.post(
//       Uri.parse(authUrl),
//       headers: {
//         'Authorization': 'Basic $auth',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: 'grant_type=client_credentials',
//     );
// log(response.body.toString());
//     if (response.statusCode == 200) {
//       log("200");
//       final responseData = json.decode(response.body);
//       log(responseData['access_token']+"dart");
//       return responseData['access_token'];
//     } else {
//       log(response.body.toString()+"dart");
//       throw Exception('Failed to authenticate: ${response.body}');
//     }
//   }
//
//   Future<void> makePayment(String authToken, double amount, String customerId) async {
//     final response = await http.post(
//       Uri.parse(paymentUrl),
//       headers: {
//         'Authorization': 'Bearer $authToken',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'amount': (amount * 100).toInt(),  // Convert to kobo
//         'customerId': customerId,
//         'currency': 'NGN',
//         'paymentItem': 'book',
//         'redirectUrl': 'https://newwebpay.interswitchng.com/collections/w/pay',
//         'reference': '121'
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       // Handle payment success
//       print('Payment successful: ${response.body}');
//     } else {
//       // Handle payment error
//       print('Payment failed: ${response.body}');
//     }
//   }
// }


 class InterswitchService {
   final String clientId = 'MX53449';
   final String clientSecret = 'D3D1D05AFE42AD50818167EAC73C109168A0F108F32645C8B59E897FA930DA44F9230910DAC9E20641823799A107A02068F7BC0F4CC41D2952E249552255710F';
   final String authUrl = 'https://qa.interswitchng.com/passport/oauth/token';
   final String merchantDetailsUrl = 'https://qa.interswitchng.com/collections/api/v1/sdk/merchant-details';

   Future<String> getAuthToken() async {
     final String auth = base64Encode(utf8.encode('$clientId:$clientSecret'));
     final response = await http.post(
       Uri.parse(authUrl),
       headers: {
         'Authorization': 'Basic $auth',
         'Content-Type': 'application/x-www-form-urlencoded',
       },
       body: 'grant_type=client_credentials',
     );

     print('Auth Status code: ${response.statusCode}');
     print('Auth Response body: ${response.body}');

     if (response.statusCode == 200) {
       final responseData = json.decode(response.body);
       return responseData['access_token'];
     } else {
       throw Exception('Failed to authenticate: ${response.body}');
     }
   }

   Future<void> getMerchantDetails(String authToken) async {
     final response = await http.get(
       Uri.parse(merchantDetailsUrl),
       headers: {
         'Authorization': 'Bearer $authToken',
         'Content-Type': 'application/json',
       },
     );

     print('Merchant Status code: ${response.statusCode}');
     print('Merchant Response body: ${response.body}');

     if (response.statusCode == 200) {
       // Handle success
       print('Merchant details: ${response.body}');
     } else {
       // Handle error
       print('Error: ${response.statusCode} ${response.body}');
     }
   }
 }

 void main() async {
   final InterswitchService interswitchService = InterswitchService();
   try {
     final authToken = await interswitchService.getAuthToken();
     await interswitchService.getMerchantDetails(authToken);
   } catch (e) {
     print('Error: $e');
   }
 }

