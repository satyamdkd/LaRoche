import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/models/stateModel.dart';
import 'package:laroch/module/address/view/address.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/bottom_sheet.dart';
import 'package:laroch/utils/widgets/dialogs/dailog.dart';

import '../../../models/address_response.dart';
import '../../../services/network/network.dart';
part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<AddressEvent>((event, emit) {});
  }
}

class AddressController {
  bool isLoading = false;

  AddressResponse? address;
  getAllAddress({BuildContext? context, callBack}) async {
    address = null;
    isLoading = true;

    callBack();
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(context: context!, URLs.addressList);
      log(response.toString());
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          address = AddressResponse.fromJson(response.data);
          log(address!.data!.data!.length.toString());
        }
      } else {
        Future.delayed(Duration.zero, () {
          showSnackBar(context: context, message: "Please try after some time");
        });
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context: context!, message: "Something went wrong!");
      });
      debugPrint("$e");
    }
    isLoading = false;
    callBack();
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();

  var formKeyRegister = GlobalKey<FormState>();

  validateForm(
      {edit = false,
      BuildContext? context,
      BuildContext? buildContextFromAddressPage,
      id,
      callBack,
      callbackFromAddressPage}) async {
    final isValid = formKeyRegister.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (edit) {
      await addUpdateAddress(
          edit: true,
          context: context,
          id: id,
          callBack: callBack,
          buildContextFromAddressPage: buildContextFromAddressPage,
          callbackFromAddressPage: callbackFromAddressPage);
    } else {
      await addUpdateAddress(
          context: context,
          callBack: callBack,
          buildContextFromAddressPage: buildContextFromAddressPage,
          callbackFromAddressPage: callbackFromAddressPage);
    }
    formKeyRegister.currentState!.save();
  }

  bool loadingAddUpdateForm = false;

  addUpdateAddress(
      {BuildContext? context,
      bool edit = false,
      BuildContext? buildContextFromAddressPage,
      id,
      callBack,
      callbackFromAddressPage}) async {
    loadingAddUpdateForm = true;
    callBack();
    Map<String, String> dataModel = {};
    if (edit) {
      dataModel.addEntries({"address_id": "$id"}.entries);
    }
    dataModel.addEntries({"fname": "${firstName.text}"}.entries);
    dataModel.addEntries({"lname": "${lastName.text}"}.entries);
    dataModel.addEntries({"email": "${email.text}"}.entries);
    dataModel.addEntries({"address1": "${addressLine1.text}"}.entries);
    dataModel.addEntries({"address2": "${addressLine2.text}"}.entries);
    dataModel.addEntries({"city": "${city.text}"}.entries);
    dataModel.addEntries({"state": "${dropDownId}"}.entries);
    dataModel.addEntries({"phone": "${mobileNumber.text}"}.entries);

    try {
      Response response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .post(
                  context: context,
                  edit ? URLs.updateAddress : URLs.addAddress,
                  data: dataModel);

      if (response.data['responseCode'] == 1) {
        Future.delayed(Duration.zero, () async {
          showSnackBar(
              context: context!, message: response.data['responseMessage']);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Address( setStateCallbackFromAddressPage:
                (){},)),
          ).then((value) => Navigator.pop(context));
        });
      } else {
        Future.delayed(Duration.zero, () {
          errorDialog(
              message: response.data['responseMessage'], context: context);
        });
      }
    } catch (e) {
      log(e.toString());
      Future.delayed(Duration.zero, () {
        errorDialog(message: "Something went wrong!", context: context);
      });
    }

    loadingAddUpdateForm = false;
  }

  deleteAddress({callBack, id, context}) async {
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(URLs.deleteAddress, queryParameters: {'id': "$id"});
      log(response.toString());
      if (response != null) {
        showSnackBar(
            context: context, message: response.data['responseMessage']);
        getAllAddress(context: context, callBack: callBack);
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  List<String> stateList = ["Select state"];
  String? dropDownValue = "Select state";
  String? dropDownId;

  setAllValuesToTextFields({AddressData? addressData, callBack}) {
    if (addressData != null) {
      firstName.text = addressData.name!;
      lastName.text = addressData.lastName!;
      addressLine1.text = addressData.address!;
      addressLine2.text = addressData.address!;
      city.text = addressData.city!;
      email.text = addressData.email!;
      mobileNumber.text = addressData.mobileNo!;
      settingStateId(stateId: addressData.state!.toString());
    }
    callBack();
  }

  settingStateId({stateName, stateId}) {
    if (stateName == null) {
      dropDownId = stateId;
      var data = stateModel!.data!.state!
          .firstWhere((element) => element.id == stateId);
      dropDownValue = data.name;
    } else {
      if (stateName != "Select state") {
        var data = stateModel!.data!.state!
            .firstWhere((element) => element.name == stateName);
        dropDownId = data.id;
      }
    }

    debugPrint(dropDownId.toString());
  }

  makeEveryVariableNullAgain() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    addressLine1 = TextEditingController();
    addressLine2 = TextEditingController();
    city = TextEditingController();
    email = TextEditingController();
    mobileNumber = TextEditingController();
    dropDownValue = "Select state";
    stateList.clear();
  }

  StateModel? stateModel;
  fetchState({callBack}) async {
    stateList.clear();
    stateList.add("Select state");

    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .get(URLs.stateList);
      log(response.toString());
      if (response != null) {
        if (response.data['responseCode'] == 1) {
          stateModel = StateModel.fromJson(response.data);
          for (var element in stateModel!.data!.state!) {
            stateList.add(element.name!);
          }
          log(stateModel!.data!.state!.length.toString());
        }
      }
    } catch (e) {
      debugPrint("$e");
    }
    callBack();
  }

  setDefaultAddress({
    callBack,
    addressId,
    addressView,
    stateId,
    context,
  }) async {
    try {
      Response? response =
          await API(token: "${SharedPref.getUserDetails()?['data']['token']}")
              .post(URLs.defaultAddress, data: {
        'address_id': "$addressId",
        "address_view": "$addressView",
        "state_id": "$stateId",
      });
      log(response.toString());
      if (response != null) {
        showSnackBar(
            context: context, message: response.data['responseMessage']);

        if (response.data['responseCode'] == 1) {
          getAllAddress(
            context: context,
            callBack: callBack,
          );
        }
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}
