import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/models/product_details.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import '../../../services/network/network.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsEvent>((event, emit) {
      emit(DetailsInitial());
    });
  }
}

class DetailController {
  bool isLoading = false;
  ProductDetails? productDetails;
  String? productId;
  int quantity = 1;
  TextEditingController quantityControlar = TextEditingController();

  removeItemQuantity({callBack}) {
    quantity > 1 ? quantity-- : quantity;
    quantityControlar.text = quantity.toString();
    callBack();
  }

  Map<String, dynamic>? deleteWishList;

  bool isAddingToWishlist = false;

  int clickedIndex = 0;
  deleteWishlistItem(
    BuildContext context, {
    required void Function() callBack,
    String? productId,
    String? view,
    int? clickedIndex,
  }) async {
    isLoading = true;
    isAddingToWishlist = true;

    callBack();
    try {
      log("$productId" + "$view" + "garima");
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .post(
                  context: context,
                  URLs.addOrDeleteFromWishlist,
                  data: {"proid": productId, "view": view});

      if (response != null) {
        if (response.data['responseCode'] == 1) {
          getProductDetails(
            context,
            productId!,
            callBack: callBack,
          );
          deleteWishList = response.data;

          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context, message: response.data['responseMessage']);
          });
        } else {
          getProductDetails(
            context,
            productId!,
            callBack: callBack,
          );
          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context, message: response.data['responseMessage']);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(context: context, message: "Please try after some time");
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context, message: "Something went wrong!");
      });
      debugPrint(e.toString());
    }
    isAddingToWishlist = false;
    isLoading = false;
    callBack();
  }

  quantityIncrement({callBack, context}) {
    if (quantity < int.parse(productDetails?.data?.newproduct![0].qty ?? "0")) {
      quantity++;
      quantityControlar.text = quantity.toString();
    } else {
      showSnackBar(
          context: context,
          message:
              "Please select a quantity less than ${productDetails?.data?.newproduct![0].qty} as we currently have limited stock available.");
    }
    callBack();
  }

  bool isAddingToCart = false;

  addToCart({context, callBack}) async {
    isAddingToCart = true;
    callBack();
    try {
      Response response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .post(URLs.addToCart,
                  data: {
                    "user_id":
                        "${SharedPref.getUserDetails()?['data']['user_id']}",
                    "qty": "$quantity",
                    "price": "${productDetails?.data!.newproduct![0].price}",
                    "pro_id": "${productDetails?.data!.newproduct![0].id}",
                    "prices_off":
                        "${productDetails?.data!.newproduct![0].percentoff}",
                    "price_old_price":
                        "${productDetails?.data!.newproduct![0].oldprice}"
                  },
                  context: context);

      if (response.data['responseCode'] == 1) {
        Future.delayed(Duration.zero, () async {
          showSnackBar(
              context: context!, message: response.data['responseMessage']);
        });
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(
              context: context!, message: response.data['responseMessage']);
        });
      }
    } catch (e) {
      log(e.toString());
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context!, message: "Something went wrong!");
      });
    }
    isAddingToCart = false;
    callBack();
  }

  getProductDetails(
    BuildContext context,
    String productId, {
    required void Function() callBack,
  }) async {
    isLoading = true;
    Map<String, dynamic>? parameters = {'id': productId};
    callBack();
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(
                  context: context,
                  URLs.productDetail,
                  queryParameters: parameters);
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          productDetails = ProductDetails.fromJson(response.data);
        } else {
          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context, message: response.data['responseMessage']);
          });
        }
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(context: context, message: "Please try after some time");
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context, message: "Something went wrong!");
      });
      debugPrint(e.toString());
    }
    isLoading = false;
    callBack();
  }
}
