import 'dart:async';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/models/cartitems.dart';
import 'package:laroch/services/network/network.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import '../../../const/common_lib.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {});
  }
}

class CartController {
  bool isLoading = false;

  deleteFromCart({required String id, callBack, BuildContext? context}) async {
    isLoading = true;
    cartItems = null;

    callBack();
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(
                  context: context,
                  URLs.deleteFromCart,
                  queryParameters: {"id": id.toString()});
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          Future.delayed(Duration.zero, () {
            getCartItems(context: context, callBack: callBack);
          });
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
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context!, message: "Something went wrong!");
      });
      debugPrint(e.toString());
    }
    isLoading = false;
    callBack();
  }

  moveToWishlist({required String id, callBack, BuildContext? context}) async {
    isLoading = true;
    callBack();
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .post(
                  context: context,
                  URLs.addOrDeleteFromWishlist,
                  data: {"proid": id, "view": "0"});

      if (response != null) {
        if (response.data['responseCode'] == 1) {
          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context!, message: response.data['responseMessage']);
          });
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
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context!, message: "Something went wrong!");
      });
      debugPrint(e.toString());
    }
    isLoading = false;
    callBack();
  }

  CartItems? cartItems;

  getCartItems({
    BuildContext? context,
    required void Function() callBack,
  }) async {
    isLoading = true;
    callBack();
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(context: context, URLs.viewCart);
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          cartItems = CartItems.fromJson(response.data);
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
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context!, message: "Something went wrong!");
      });
      debugPrint(e.toString());
    }
    isLoading = false;
    callBack();
  }
}
