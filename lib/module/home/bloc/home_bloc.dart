import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/models/categoies.dart';
import 'package:laroch/models/wishlist_model.dart';
import 'package:laroch/module/products_list/bloc/product_bloc.dart';
import 'package:laroch/module/products_list/view/product_list.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import '../../../services/network/network.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
  }
}

class Controller {

  bool isLoading = false;
  var bottomNavIndex = 0;

  String appBarTitle = "";

  onBackButton(callBack) async {
    if (bottomNavIndex != 0) {
      appBarTitle = "";
      bottomNavIndex = 0;
    } else {
      exit(0);
    }
    callBack();
  }

  final iconList = [
    const BottomNavigationBarItem(
      label: "Home",
      icon: Icon(
        Icons.home_rounded,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Category",
      icon: Icon(
        Icons.dashboard,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Wishlist",
      icon: Icon(
        Icons.favorite_border_outlined,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Profile",
      icon: Icon(
        Icons.person,
      ),
    ),
  ];

  onBottomTap(int index,
      {required context, required void Function() callBack}) {
    bottomNavIndex = index;

    if (index == 0) {
      appBarTitle = "";
      getDashBoardData(context, callBack: callBack);
    }
    if (index == 1) {
      appBarTitle = "Categories";
      getCategories(
        context,
        callBack: callBack,
      );
    }
    if (index == 2) {
      appBarTitle = "Wishlist";
    }
    if (index == 3) {
      appBarTitle = "Profile";
    }
    callBack();
  }

  /// **************************************************************
  /// ******************** DASHBOARD DATA **************************
  /// **************************************************************

  Map<String, dynamic>? dashboardData;

  var temp;

  getDashBoardData(BuildContext context,
      {required void Function() callBack}) async {
    temp = callBack;

    isLoading = true;
    callBack();
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(context: context, URLs.home);
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          dashboardData = response.data;
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

  /// **************************************************************
  /// ******************** CATEGORIES ITEMS ************************
  /// **************************************************************

  categoryPageCalledFromHome({context, callBack, id}) {
    bottomNavIndex = 1;
    appBarTitle = "Categories";
    parameters = {'id': '$id'};
    getCategories(
      context,
      callBack: callBack,
    );
  }

  Map<String, dynamic>? parameters = {'id': '003'};

  Categories? categories;

  getCategories(BuildContext context,
      {required void Function() callBack}) async {
    isLoading = true;
    callBack();
    try {
      Response? response = await API()
          .get(context: context, URLs.categories, queryParameters: parameters);

      if (response != null) {
        if (response.data['responseCode'] == 1) {
          categories = Categories.fromJson(response.data);
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

  Map<String, dynamic>? subSubParameters = {'page': 1};
  List<SubSubcategoryModel> subSubItems = [];

  bool subSubCatLoader = false;
  getSubSubCategoryListItems(BuildContext context,
      {void Function()? callBack, subSubParameters}) async {
    subSubItems.clear();
    subSubCatLoader = true;
    callBack!();

    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(URLs.subSubCategories, context: context, queryParameters: {
        "id": "${subSubParameters["id"]

        }",
          "subcatcode":"${subSubParameters["code"]}",
      });

      if (response != null) {
        if (response.data['data']['subsubcategory'] == false || response.data['data']['subsubcategory'] == null) {
          Future.delayed(Duration.zero, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductList(
                  title: "${subSubParameters["name"]}",
                  url: "product.php",
                  id: "${subSubParameters["code"]}",
                  generalProducts: true,
                ),
              ),
            ).then((value) => Navigator.pop(context));
          });
        } else {
          Categories item = Categories.fromJson(response.data);
          if (item.data!.subSubcategory != null &&
              item.data!.subSubcategory!.isNotEmpty) {
            subSubItems.addAll(item.data!.subSubcategory!);
          }
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
    subSubCatLoader = false;

    callBack();
  }

  /// **************************************************************
  /// ********************* WISHLIST *******************************
  /// **************************************************************

  WishListModel? wishListModel;

  getWishlist(
    BuildContext context, {
    required void Function() callBack,
  }) async {
    wishListModel = null;
    isLoading = true;
    callBack();
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(
        context: context,
        URLs.wishlist,
      );
      log(response.toString());
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          wishListModel = WishListModel.fromJson(response.data);
          log("+++++++++++++wishlist++++++++++++++++");
          log(wishListModel!.data!.length.toString());
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
      debugPrint("$e");
    }
    isLoading = false;
    callBack();
  }

  Map<String, dynamic>? deleteWishList;

  bool isAddingToWishlist = false;

  int clickedIndex = 0;

  deleteWishlistItem(
    BuildContext context, {
    required void Function() callBack,
        String? url,
        String? id,
    String? productId,
    String? view,
    int? clickedIndex,
  }) async {
    ProductController productController=ProductController();
    productController.isLoading=true;
   // isLoading = true;
    isAddingToWishlist = true;

    callBack();
    try {
      log(url.toString());
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .post(
                  context: context,
                  URLs.addOrDeleteFromWishlist,
                  data: {"proid": productId, "view": view});

      if (response != null) {
        if (response.data['responseCode'] == 1) {
// productController.isLoading=true;
// productController.id=id.toString();
// productController.generalProducts = true;
//           productController.getProductListItems(
//             context,
//             callBack:  callBack,
//             url: url,
//           );
          deleteWishList = response.data;
          Future.delayed(Duration.zero, () {
            showSnackBar(
                context: context, message: response.data['responseMessage']);
          });
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
    isAddingToWishlist = false;
    //isLoading = false;
  //  productController.isLoading=false;
    callBack();
  }

  wishListPageCalledFromProfile() {
    bottomNavIndex = 2;
    appBarTitle = "Wishlist";
    temp();
  }
}
