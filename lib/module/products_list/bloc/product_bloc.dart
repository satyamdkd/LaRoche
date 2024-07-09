import 'dart:developer';


import 'package:dio/dio.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/models/ProductListItems.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import '../../../const/common_lib.dart';
import '../../../services/network/api.dart';
import '../../../utils/helper/sharedpref.dart';

class ProductController {
  bool isLoading = false;
  bool paginationLoader = false;
  List<Newrangeproductallview> productListItem = [];
  ScrollController scrollController = ScrollController();

  scrollControllerInit(BuildContext context, void Function()? callBack, url,
      {int? a}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        paginationLoader = true;
        callBack!();
        Future.delayed(Duration.zero, () {
          pages++;
          initializeParameters(pages);
          getProductListItems(
            context,
            callBack: callBack,
            url: url,
          );
        });
      }
    });
  }



  int pages = 1;
  void initializeParameters(int page) {
    pages = page;
    parameters = {'page': page};
  }

  bool generalProducts = false;
  String? id;
  Map<String, dynamic>? parameters;
  getProductListItems(
    BuildContext context, {
    void Function()? callBack,
    url,
  }) async {
    if (paginationLoader == false) {
      isLoading = true;
      callBack!();
    }

    try {///new
      //productListItem.clear();
      Response? response = await API().get(context, url,
          queryParameters:
              generalProducts ? {'id': '$id', 'page': pages} : parameters);

      if (response != null) {
        if (response.data['data'].isNotEmpty) {
          ProductListItem item = ProductListItem.fromJson(response.data);

          if (response.data['responseCode'] == 1 &&
                  (item.data?.newrangeproductallview != null &&
                      item.data?.newrangeproductallview != []) ||
              (item.data?.topSelling != null && item.data?.topSelling != []) ||
              (item.data!.products != null && item.data!.products! != [] || item.responseMessage!="Empty New product.")) {
            if (url == URLs.newRange) {
              productListItem.addAll(item.data!.newrangeproductallview!);
            } else if (url == URLs.topSelling) {
              productListItem.addAll(item.data!.topSelling!);
            } else {
              if (generalProducts) {
                productListItem.addAll(item.data!.products!);
              }
            }
          } else {
            Future.delayed(Duration.zero, () {
              showSnackBar(
                  context: context, message: response.data['responseMessage']);
            });
          }
        } else {}
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
    paginationLoader = false;
    callBack!();
  }

  Map<String, dynamic>? deleteWishList;

  bool isAddingToWishlist = false;


}
