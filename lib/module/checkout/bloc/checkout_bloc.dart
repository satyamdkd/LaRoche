import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:laroch/models/checkoutmodel.dart';
import 'package:pinput/pinput.dart';
import '../../../const/common_lib.dart';
import '../../../const/urls.dart';
import '../../../models/PlaceOrder.dart';
import '../../../models/paymentModel.dart';
import '../../../utils/helper/sharedpref.dart';
import '../../../utils/widgets/bottom_sheet.dart';
import 'package:laroch/services/network/network.dart';

import '../view/payment.dart';
import '../view/viewScreen.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) {});
  }
}

Map<String, dynamic>? cheakListDats;
List<Map<String, dynamic>>? cheakData;
List<Map<String, dynamic>>? productData;
Map<String, dynamic>? cartList;
List<Map<String, dynamic>>? addressDatalist;

class CheckOutController {
  bool isLoading = false;
  bool ispaymentLoading = false;
  CheckOutModel? checkOutModel;

  int deliveryType = 1;

  AddressData? addressData;

  checkOut({
    BuildContext? context,
    required void Function() callBack,
  }) async {
    isLoading = true;
    callBack();

    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(
        context: context,
        URLs.checkoutList,
      );
      log(response.toString());

      if (response != null) {
        if (response.data['responseCode'] == 1) {
          checkOutModel = CheckOutModel.fromJson(response.data);

          if (checkOutModel!.addressData != false &&
              checkOutModel!.addressData != null) {
            checkOutModel!.addressData?.forEach((element) {
              if (element.defaultView == "1") {
                addressData = element;
              }
            });
          }

          if (checkOutModel!.data!.data != false &&
              checkOutModel!.data!.data != null) {
            checkOutModel!.data!.data!.forEach((element) {
              productData!.add({
                "qty": element.qty,
                "price": element.price,
                "pro_id": element.proId,
                "total": element.total
              });
            });
          }
        } else {
          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context!, message: response.data['responseMessage']);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context!, message: "Please try after some time");
        });
      }
    } catch (e) {
      debugPrint("$e");
    }
    isLoading = false;
    callBack();
  }

  PlaceOrder? placeOrderModel;

  placeOrder({
    BuildContext? context,
    required void Function() callBack,
    required List<Map<String, dynamic>> productList,
    required List<Map<String, dynamic>>? addressData,
  }) async {
    ispaymentLoading = true;
    callBack();

    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .postRaw(
        queryParameters: {
          "data": productList,
          "totalpro": checkOutModel!.data!.total,
          "totalweight": checkOutModel!.data!.weight,
          "address_data": addressData,
          "weekdays": {
            "weekdays": checkOutModel!.weekdays!.weekdays,
            "monthsdays": checkOutModel!.weekdays!.monthsdays,
          },
          "outofdelevery": {
            "shippingcost": checkOutModel!.outofdelevery!.shippingcost=="-"?"0":checkOutModel!.outofdelevery!.shippingcost
          }
        },
        context: context,
        URLs.placeOrder,
      );
      log(response.toString() + "garima");

      if (response != null) {
        if (response.data['responseCode'] == 1) {
          placeOrderModel = PlaceOrder.fromJson(response.data);
          payment(context: context,
              callBack: callBack,
              userId: placeOrderModel!.userId,
              orderId: placeOrderModel!.orderId.toString(),
              order_ids: placeOrderModel!.order_ids.toString());
          // Navigator.push(context!, MaterialPageRoute(builder: (context)=>Payment()));
        } else {
          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context!, message: response.data['responseMessage']);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context!, message: "Please try after some time");
        });
      }
    } catch (e) {
      log("catch");
      debugPrint("$e");
    }
    ispaymentLoading = false;
    callBack();
  }

  Map<String, dynamic>? paymentData;
  PaymentModel? paymentModel;
  payment({
    String? userId,
    String? orderId,
    String? order_ids,
    BuildContext? context,
    required void Function() callBack,
  }) async {
    ispaymentLoading = true;
    callBack();

    try {
      Response? responsse = await API(
              token: "${SharedPref.getUserDetails()?['data']['token']}",
              base2: "yes")
          .post(
        data: {
          "order_id": orderId,
          " user_id": userId,
          "order_ids": order_ids,
          "type": "3"
        },
        context: context,
        URLs.payment,
      );

      if (responsse == null) {
        log("null data");
      } else if (responsse != null) {
        log("not null ===");

        log(json.decode(responsse.data)['redirect_url'].toString());
       // log(responsse.data['responseCode'].toString());
        if (json.decode(responsse.data)['responseCode'] == 1) {
          paymentModel = PaymentModel.fromJson(json.decode(responsse.data));
          log("not null ===#####");

            Navigator.push(context!, MaterialPageRoute(builder: (context)=>ViewPayment(urlRedirect: paymentModel!.redirectUrl.toString(),)));
        } else {
          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context!, message: responsse.data['responseMessage']);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context!, message: "Please try after some time");
        });
      }
    } catch (e) {
      log("catch");

      debugPrint("$e");
    }
    ispaymentLoading = false;
    callBack();
  }
}
