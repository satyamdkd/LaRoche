import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:laroch/models/ProductListItems.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import '../../../const/common_lib.dart';
import '../../../services/network/network.dart';
part 'sub_cat_event.dart';
part 'sub_cat_state.dart';

class SubCategoryController {
  bool isLoading = false;
  bool paginationLoader = false;
  List<Newrangeproductallview> viewAllCategoryItems = [];
  ScrollController scrollController = ScrollController();

  scrollControllerInit(BuildContext context, void Function()? callBack, url) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        paginationLoader = true;
        callBack!();
        Future.delayed(Duration.zero, () {
          page++;
          parameters = {'page': page};
          getSubCategoryListItems(
            context,
            callBack: callBack,
            url: url,
          );
        });
      }
    });
  }

  int page = 1;

  Map<String, dynamic>? parameters = {'page': 1};
  getSubCategoryListItems(BuildContext context,
      {void Function()? callBack, url}) async {
    if (paginationLoader == false) {
      isLoading = true;
      callBack!();
    }

    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(url, context: context, queryParameters: parameters);

      if (response != null) {
        ProductListItem item = ProductListItem.fromJson(response.data);
        if (response.data['responseCode'] == 1 &&
            (item.data?.viewAllCategoryItems != null &&
                item.data?.viewAllCategoryItems != [])) {
          viewAllCategoryItems.addAll(item.data!.viewAllCategoryItems!);

          /// if (url == URLs.viewAllCategories) {
          /// } else {}
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
    paginationLoader = false;
    callBack!();
  }
}

class SubCatBloc extends Bloc<SubCatEvent, SubCatState> {
  SubCatBloc() : super(SubCatInitial()) {
    on<SubCatEvent>((event, emit) {});
  }
}
