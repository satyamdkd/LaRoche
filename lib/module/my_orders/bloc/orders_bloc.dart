import 'dart:async';

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:laroch/models/orderHistory.dart';

import '../../../const/common_lib.dart';
import '../../../const/urls.dart';
import '../../../services/network/network.dart';
import '../../../utils/helper/sharedpref.dart';
import '../../../utils/widgets/bottom_sheet.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    on<OrdersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}



class OrderHistoryController {
  Map<String,dynamic>? historyList;
  bool isLoading = false;
  OrderHistoryModel? orderHistoryModel;

  getCartHistory(
    BuildContext context, {
    required void Function() callBack,
  }) async {
    isLoading = true;

    callBack();
    try {
      log( "${SharedPref.getUserDetails()?['data']['token']}");
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(context: context, URLs.orderHistory,);


      if (response != null) {

        if (response.data['responseCode'] == 1) {
          log("hhhhh");

          log(response.data.toString());
          historyList=response.data;
          // var one = jsonDecode(response.data);



          //orderHistoryModel = OrderHistoryModel.fromJson(response.data);
        } else {
          Future.delayed(Duration.zero, () {
            log("ggg");
            showSnackBar(
                context: context, message: response.data['responseMessage']);
          });
        }
      } else {
        isLoading = false;
        Future.delayed(Duration.zero, () {
          showSnackBar(context: context, message: "Please try after some time");
        });
      }
    } catch (e) {
 log("catch");
      Future.delayed(Duration.zero, () {

        showSnackBar(context: context, message: "Something went wrong!");
      });
      debugPrint(e.toString());
    }
    isLoading = false;
    callBack();
  }
}
