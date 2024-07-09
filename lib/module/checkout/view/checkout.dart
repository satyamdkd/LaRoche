import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/models/checkoutmodel.dart';
import 'package:laroch/module/address/view/address.dart';
import 'package:laroch/module/checkout/bloc/checkout_bloc.dart';
import 'package:laroch/module/checkout/view/termCondition.dart';
import 'package:laroch/utils/widgets/network_image.dart';
import '../../../utils/widgets/appbar.dart';
import '../../../utils/widgets/bottom_sheet.dart';
import '../../address/bloc/address_bloc.dart';
import '../../address/view/add_address.dart';


class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}
bool termCondition =false;
class _CheckOutState extends State<CheckOut> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Checkout",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }
String _amountString="300";
  AddressController addressController = AddressController();
  CheckOutController checkOutController = CheckOutController();
  List<Map<String, dynamic>> productDataList = [];
  List<Map<String, dynamic>> addressData = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      checkOutController.checkOut(
        context: context,
        callBack: () => setState(() {}),
      );

    });

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: checkOutController.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: appColors.red,
                strokeWidth: 2,
              ),
            )
          : checkOutController.checkOutModel == null
              ? Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      "No data found!\nplease try after some time.",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Order Summary",
                        //       textAlign: TextAlign.start,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: theme.textTheme.bodyLarge?.copyWith(
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 16.w,
                        //       ),
                        //     ),
                        //     const Spacer(),
                        //     Text(
                        //       "Total:  ",
                        //       textAlign: TextAlign.start,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: theme.textTheme.bodyLarge?.copyWith(
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 16.w,
                        //       ),
                        //     ),
                        //     Image.asset(
                        //       "assets/icons/currency.png",
                        //       height: 13.w,
                        //       width: 13.w,
                        //       color: Colors.red,
                        //     ),
                        //     Text(
                        //       " ${checkOutController.checkOutModel!.data!.total}",
                        //       textAlign: TextAlign.start,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: theme.textTheme.bodyLarge?.copyWith(
                        //         color: Colors.red,
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 16.w,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Divider(
                        //   height: 30,
                        //   thickness: 3,
                        //   color: Colors.grey.withOpacity(0.1),
                        // ),
                        ...List.generate(
                          checkOutController.checkOutModel!.data!.data!.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        imageBuilder(
                                            checkOutController.checkOutModel!
                                                .data!.data![index].imageUrl,
                                            width: 100.w,
                                            height: 100.w),
                                        SizedBox(width: 12.h),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "${checkOutController.checkOutModel!.data!.data![index].proname}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4.h),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/currency.png",
                                                    height: 13.w,
                                                    width: 13.w,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    " ${checkOutController.checkOutModel!.data!.data![index].total}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color: appColors
                                                                .greenColor
                                                                .withOpacity(
                                                                    0.8),
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 12.h),
                                              Text(
                                                "Quantity: ${checkOutController.checkOutModel!.data!.data![index].qty}",
                                                textAlign: TextAlign.start,
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 12.sp),
                                              ),
                                             checkOutController.checkOutModel!.data!.data![index].picupstore=="1"? Text(
                                                " * This item are to be collected by buyer Only",
                                                maxLines: 2,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                    color: appColors
                                                        .red
                                                        ,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                              ):Text(""),
                                              SizedBox(height: 8.w),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 3,
                                    color: Colors.grey.withOpacity(0.07),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Text(
                          "Billing Details:",
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp),
                        ),
                        SizedBox(height: 10.h),
                        _buildDetailRow(
                            title: "Total",
                            subTitle:
                                checkOutController.checkOutModel!.data!.total!),
                        SizedBox(height: 5.h),
                        if (checkOutController.deliveryType == 2)
                          _buildDetailRow(
                            title: "Delivery Fees",
                            subTitle:
                                "${checkOutController.checkOutModel!.outofdelevery!.shippingcost}",
                          ),
                      if ( checkOutController.checkOutModel!.data!.savings!="null" )  SizedBox(height: 5.h),
                        if ( checkOutController.checkOutModel!.data!.savings!="null" )   _buildDetailRow(
                          title: "Savings",
                          color: Colors.green,
                          subTitle:
                              "${checkOutController.checkOutModel!.data!.savings}",
                        ),
                        SizedBox(height: 15.h),
                        Divider(
                          thickness: 3,
                          color: Colors.grey.withOpacity(0.07),
                        ),
                        SizedBox(height: 10.h),
                        _buildDetailRow(
                          title: "Total Amount",
                          subTitle:( checkOutController.deliveryType == 1)
                              ? "${checkOutController.checkOutModel!.data!.total!}"
                              : checkOutController.checkOutModel!.outofdelevery!.shippingcost!='-'?"${int.parse(checkOutController.checkOutModel!.data!.total!) + int.parse(checkOutController.checkOutModel!.outofdelevery!.shippingcost!)}":"${checkOutController.checkOutModel!.data!.total!}",
                          size: 16.0,
                          color: Colors.green,
                          textColor: Colors.black,
                        ),
                        SizedBox(height: 30.h),
                        ProductShipmentType<int>(
                          title: "Buy and collect from amuwo branch",
                          value: 1,
                          groupValue: checkOutController.deliveryType,
                          onChange: (value) {
                            checkOutController.deliveryType = value;
                            setState(() {
                              log(checkOutController.checkOutModel!.outofdelevery!.shippingcost.toString()+"date");
                            });
                          },
                        ),
                        SizedBox(height: 15.h),
                        if (   checkOutController.addressData != null &&
                            checkOutController.addressData != false)
                          ProductShipmentType<int>(
                          title: "Door delivery",
                          value: 2,
                          groupValue: checkOutController.deliveryType,
                          onChange: (value) {
                            checkOutController.deliveryType = value;
                            setState(() {
                              log(checkOutController.checkOutModel!.outofdelevery!.shippingcost.toString()+"date");
                            });
                          },
                        ),
                        if (checkOutController.deliveryType == 2)
                          SizedBox(height: 10.h),
                        if (checkOutController.deliveryType == 2 &&
                            checkOutController.checkOutModel!.weekdays !=
                                null &&
                            checkOutController.checkOutModel!.weekdays != false)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Delivery Expected Date : [${checkOutController.checkOutModel!.weekdays!.weekdays} ${checkOutController.checkOutModel!.weekdays!.monthsdays}]",
                              textAlign: TextAlign.start,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Contact Information :",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: appColors.black900,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Inter",
                                fontSize: 14.w,
                              ),
                            ),



                            InkWell(
                              onTap: () {
                                checkOutController.addressData != null &&
                                        checkOutController.addressData != false
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>  Address(
                                            fromCheckOutPage: true,
                                            setStateCallbackFromAddressPage:
                                                () => setState(() {}),
                                          ),
                                        ),
                                      ).then(
                                        (value) => checkOutController.checkOut(
                                          context: context,
                                          callBack: () => setState(() {}),
                                        ),
                                      )
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddUpdateAddress(
                                                  addressController:
                                                      addressController,
                                                  buildContextFromAddressPage:
                                                      context,
                                                  setStateCallbackFromAddressPage:
                                                      () => setState(() {}),
                                                )));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 2.w),
                                decoration: BoxDecoration(
                                  color: appColors.red,
                                  border: Border.all(
                                      width: 0.6, color: appColors.red),
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 2.h),
                                  child: Text(
                                    checkOutController.addressData != null &&
                                            checkOutController.addressData !=
                                                false
                                        ? "Change"
                                        : " Add ",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: appColors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: 25.h),
                        if (checkOutController.addressData != null &&
                            checkOutController.addressData  != false)
                          AddressTile(
                              addressData: //checkOutController.addressData!=null||checkOutController.addressData!=false
                                  checkOutController.addressData!),
                        SizedBox(height: 25.h),
                        Row(
                          children: [
                           GestureDetector(
                               onTap: (){
                                 setState(() {
                                   termCondition=!termCondition;
                                 });

                               },
                               child: Icon( termCondition==true?Icons.check_box_outlined:Icons.check_box_outline_blank,color: appColors
                                 .red,)),

                            Text(
                              "I have read and agree to the",
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: appColors.black900,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Inter",
                                fontSize: 14.w,
                              ),
                            ), GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context
                                )=>TermCondition()));
                              },
                              child: Text(
                                "Terms and Conditions",
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: appColors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                  fontSize: 14.w,
                                ),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 25.h),
                        checkOutController.ispaymentLoading?  ElevatedButton(

    onPressed: () //=>pay(ctx ),
      {},
    child: SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Center(
    child: CircularProgressIndicator(color: Colors.white,),
    ),
    ),
    ):
                        SizedBox(
                          child: Builder(
                            builder: (ctx) =>
                                ElevatedButton(

                              onPressed: () //=>pay(ctx ),
                              {


                                if(checkOutController.addressData==null){


                                  showSnackBar(
                                      context: context!, message: "Please Add your address");
                                }
                                for (int i = 0;
                                    i <=
                                        checkOutController.checkOutModel!.data!
                                                .data!.length -
                                            1;
                                    i++) {
                                  setState(() {
                                    productDataList.add({
                                      "qty": checkOutController
                                          .checkOutModel!.data!.data![i].qty,
                                      "price": checkOutController
                                          .checkOutModel!.data!.data![i].price,
                                      "pro_id": checkOutController
                                          .checkOutModel!.data!.data![i].proId,
                                      "total": checkOutController
                                          .checkOutModel!.data!.data![i].total
                                    });
                                  });
                                }
                                for (int i = 0;
                                    i <=
                                        checkOutController.checkOutModel!
                                                .addressData!.length -
                                            1;
                                    i++) {
                                  setState(() {
                                    if (checkOutController.checkOutModel!
                                            .addressData![i].defaultView ==
                                        "1")
                                      addressData.add({
                                        "id": checkOutController
                                            .checkOutModel!.addressData![i].id,
                                        "user_id": checkOutController
                                            .checkOutModel!
                                            .addressData![i]
                                            .userId,
                                        "name": checkOutController
                                            .checkOutModel!.addressData![i].name,
                                        "last_name": checkOutController
                                            .checkOutModel!
                                            .addressData![i]
                                            .lastName,
                                        "pincode": checkOutController
                                            .checkOutModel!
                                            .addressData![i]
                                            .pincode,
                                        "address": checkOutController
                                            .checkOutModel!
                                            .addressData![i]
                                            .address,
                                        "apartment": checkOutController
                                            .checkOutModel!
                                            .addressData![i]
                                            .apartment,
                                        "city": checkOutController
                                            .checkOutModel!.addressData![i].city,
                                        "state": checkOutController
                                            .checkOutModel!.addressData![i].state,
                                        "mobile_no": checkOutController
                                            .checkOutModel!
                                            .addressData![i]
                                            .mobileNo,
                                        "email": checkOutController
                                            .checkOutModel!.addressData![i].email
                                      });
                                  });
                                }


                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                //    // PaymentScreen()));
                                //     Payment(user_id: '', order_id: '',)));
                                if(termCondition==false){
return
                                  showSnackBar(
                                      context: context!, message:"Please agree with term and condition ");
                                }else
                                checkOutController.placeOrder(
                                    callBack: () {},
                                    productList: productDataList,
                                    addressData: addressData,
                                    context: context);
                                log(checkOutController.checkOutModel!.outofdelevery!.shippingcost.toString());
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "PROCEED TO PAYMENT",
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

Widget _buildDetailRow(
    {required String title, required String subTitle, color, size, textColor}) {
  return Row(
    children: [
      Expanded(
          child: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: size,
            color: textColor,
            fontWeight: textColor != null ? FontWeight.w500 : FontWeight.w400),
      )),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/currency.png",
            height: 11.w,
            width: 11.w,
            color: color,
          ),
          Text(
            "  $subTitle",
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: color ?? Colors.black,
              fontWeight: textColor != null ? FontWeight.w500 : FontWeight.w400,
              fontSize: textColor != null ? 16.h : 13.w,
            ),
          ),
        ],
      ),
    ],
  );
}

class ProductShipmentType<T> extends StatelessWidget {
  const ProductShipmentType({
    super.key,
    required this.value,
    this.groupValue,
    required this.onChange,
    required this.title,
  });

  final String title;
  final T value;
  final T? groupValue;
  final ValueChanged<T> onChange;

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChange(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.6, color: appColors.blueGray700),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                size: 24.h,
                color: isSelected ? appColors.blue500 : appColors.gray500,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: appColors.gray500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.addressData});

  final AddressData addressData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.6, color: appColors.blueGray700),
          borderRadius: BorderRadius.circular(5.r),
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
                  SizedBox(
                    height: 5.h,
                  ),
                  buildRowTextWidget(
                    title: "Email",
                    subTitle: "${addressData.email}",
                  ),
                  buildRowTextWidget(
                    title: "Phone",
                    subTitle: "${addressData.mobileNo}",
                  ),
                  buildRowTextWidget(
                    title: "Address",
                    subTitle: "${addressData.address}",
                  ),
                  buildRowTextWidget(
                    title: "City",
                    subTitle: "${addressData.city}",
                  ),
                  buildRowTextWidget(
                    title: "Country",
                    subTitle: "${addressData.country}",
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.h),
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
