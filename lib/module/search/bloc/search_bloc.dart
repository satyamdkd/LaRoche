import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:laroch/models/search_model.dart';

import '../../../const/common_lib.dart';
import '../../../const/urls.dart';

import '../../../services/network/network.dart';
import '../../../utils/widgets/bottom_sheet.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});
  }
}

class SearchListController {
  bool isLoading = false;

  SearchModel? searchModel;

  search(
    BuildContext context, {
    required void Function() callBack,
    parameters,
  }) async {
    searchModel = null;
    isLoading = true;
    callBack();
    try {
      Response? response = await API()
          .get(context: context, URLs.search, queryParameters: parameters);
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          searchModel = SearchModel.fromJson(response.data);
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
