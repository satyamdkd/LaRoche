import 'package:flutter/cupertino.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/module/address/bloc/address_bloc.dart';
import 'package:laroch/module/address/view/add_address.dart';
import '../../../models/address_response.dart';
import '../../../utils/widgets/appbar.dart';

class Address extends StatefulWidget {
  const Address({super.key, this.fromCheckOutPage = false,  required this.setStateCallbackFromAddressPage,});

  final bool fromCheckOutPage;
  final void Function() setStateCallbackFromAddressPage;

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  AddressController addressController = AddressController();

  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Address",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      addressController.getAllAddress(
          context: context, callBack: () => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      floatingActionButton: addressController.isLoading
          ? null
          : FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddUpdateAddress(
                              addressController: addressController,
                              buildContextFromAddressPage: context,
                              setStateCallbackFromAddressPage: () =>
                                  setState(() {}),
                            )));
              },
              child: Icon(
                Icons.add_rounded,
                color: appColors.white,
                size: 35.h,
              ),
            ),
      body: SafeArea(
        child: addressController.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: appColors.red,
                  strokeWidth: 2,
                ),
              )
            : addressController.address == null
                ? Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Text(
                        "No data found!\nplease add address.",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          SizedBox(height: 15.h),
                          ...List.generate(
                            addressController.address!.data!.data!.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {},
                                child: _AddressTile(
                                  addressData: addressController
                                      .address!.data!.data![index],
                                  addressController: addressController,
                                  fromCheckOutPage: widget.fromCheckOutPage,
                                  callback: () => setState(() {}),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  const _AddressTile({
    required this.addressData,
    this.onTap,
    this.deleteTap,
    this.defaultValue = false,
    required this.addressController,
    this.fromCheckOutPage = false,
    required this.callback,
  });
  final VoidCallback? onTap;
  final VoidCallback? deleteTap;
  final AddressData addressData;
  final bool defaultValue;
  final bool fromCheckOutPage;
  final AddressController addressController;
  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (fromCheckOutPage) {
          await addressController
              .setDefaultAddress(
                  context: context,
                  callBack: callback,
                  addressId: addressData.id,
                  addressView: "1",
                  stateId: addressData.state)
              .then((value) => Navigator.pop(context));
        } else {
          await addressController.setDefaultAddress(
              context: context,
              callBack: callback,
              addressId: addressData.id,
              addressView: "1",
              stateId: addressData.state);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: //defaultValue
              addressData.defaultView == "1"
                  ? appColors.greenColor.withOpacity(0.2)
                  : appColors.greyBackGround.withOpacity(0.8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${addressData.name} ${addressData.lastName}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: appColors.black900,
                    ),
                  ),
                  buildRowTextWidget(
                    title: "email",
                    subTitle: "${addressData.email}",
                  ),
                  buildRowTextWidget(
                    title: "phone",
                    subTitle: "${addressData.mobileNo}",
                  ),
                  buildRowTextWidget(
                    title: "address",
                    subTitle: "${addressData.address}",
                  ),
                  buildRowTextWidget(
                    title: "city",
                    subTitle: "${addressData.city}",
                  ),
                  buildRowTextWidget(
                    title: "country",
                    subTitle: "${addressData.country}",
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.h),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: appColors.white,
                      borderRadius: BorderRadius.circular(50.r)),
                  padding: EdgeInsets.all(2.h),
                  child: InkWell(
                    onTap: onTap ??
                        () {
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddUpdateAddress(
                                      addressController: addressController,
                                      buildContextFromAddressPage: context,
                                      addressData: addressData,
                                      setStateCallbackFromAddressPage: () =>
                                          callback,
                                      edit: true)),
                            ).then((_) =>
                                addressController.makeEveryVariableNullAgain());
                          });
                        },
                    child: Icon(
                      CupertinoIcons.pencil,
                      color: appColors.green600,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: deleteTap ??
                      () {
                        addressController.deleteAddress(
                            context: context,
                            callBack: callback,
                            id: addressData.id);
                      },
                  child: Icon(
                    CupertinoIcons.delete,
                    color: appColors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildRowTextWidget({title, subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
              color: appColors.blueGray700,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            subTitle == "" ? ":  --" : ":  $subTitle",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
              color: appColors.blueGray700,
            ),
          ),
        ),
      ],
    );
  }
}
