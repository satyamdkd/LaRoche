import 'dart:developer';

import 'package:laroch/const/common_lib.dart';
import 'package:laroch/module/cart/bloc/cart_bloc.dart';
import 'package:laroch/utils/widgets/network_image.dart';
import '../../../utils/widgets/appbar.dart';

class OrderDetails extends StatefulWidget {
  List<dynamic> productList=[];
  String finalpayment;
  String shipping_charges;
   OrderDetails({super.key,required this.productList,required this.finalpayment,required this.shipping_charges});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Order Details",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  CartController cartController = CartController();
double subTotal=0.0;
String total="";
  @override
  void initState() {
    super.initState();
    log(widget.productList![0]['product'][0]['name']);

    for(int i=0; i <= widget.productList!.length; i++){
      subTotal=(subTotal+double.parse(widget.productList![0]['product'][0]['price']))!;

    }
    log(subTotal.toString());
    log(  widget.productList!.length.toString(),);
    Future.delayed(Duration.zero, () {

     // cartController.getCartItems(callBack: () => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),

      body:
      cartListView(),
    );
  }

  SingleChildScrollView cartListView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              cartList(
                widget.productList!.length,
                title: "Compatible with",
              ),
            ]),
      ),
    );
  }



  Widget cartList(int itemslenngth, {required String title}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.04),
          borderRadius: BorderRadius.circular(3.h)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  itemslenngth,
                      (index) {
                    return GestureDetector(
                      onTap: () {},
                      child: catItem(index),
                    );
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Order Details:",
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _buildInfoRow(
                    title: "Delivery Charges",
                    subTitle:
                    widget.shipping_charges),
                SizedBox(
                  height: 5.h,
                ),
               _buildInfoRow(
                    title: "Sub-Totals",
                    subTitle:
                    subTotal.toStringAsFixed(0),
                    color: Colors.green),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Divider(
                  thickness: 3,
                  color: Colors.grey.withOpacity(0.07),
                ),
                SizedBox(
                  height: 15.h,
                ),
                _buildInfoRow(
                    title: "Total Amount",
                    subTitle: (subTotal+ double.parse(widget.shipping_charges)).toStringAsFixed(0),
                    size: 16.0,
                    textColor: Colors.black),
                SizedBox(
                  height: 15.h,
                ),
                // Container(
                //   margin: EdgeInsets.all(4.h),
                //   padding: EdgeInsets.all(4.h),
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //     color: Colors.grey.withOpacity(0.1),
                //   ),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         "assets/icons/truck.png",
                //         height: 30.w,
                //         width: 30.w,
                //       ),
                //       SizedBox(
                //         width: 8.w,
                //       ),
                //       Text(
                //         " Actual taxes and shipping will be calculated at checkout",
                //         style: theme.textTheme.bodySmall?.copyWith(
                //           color: Colors.grey,
                //           fontWeight: FontWeight.normal,
                //           fontSize: 8.w,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ]),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  catItem( int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.h),
                child: imageBuilder(
                  "${widget.productList![index]['image_path']}",
                  height: 130.w,
                  width: 130.w,
                ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.productList![index]['product'][0]['name']}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "${widget.productList![index]['product'][0]['ItemDescription']}",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    priceWidget(
                      iconSize: 8.w,
                      textSize: 10.w,
                      spacing: 4.w,
                      isShowDiscount: true,
                      price: "${ widget.productList![index]['product'][0]['price']}",
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Quantity  :  ${widget.productList![index]['product'][0]['qty']}",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),

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
    );
  }

  Row priceWidget({iconSize, textSize, spacing, isShowDiscount, price}) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/currency.png",
              height: iconSize ?? 11.w,
              width: iconSize ?? 11.w,
            ),
            Text(
              "  $price",
              maxLines: 2,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: textSize ?? 13.w,
              ),
            ),
          ],
        ),
        SizedBox(
          width: spacing ?? 10.w,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Image.asset(
        //       "assets/icons/currency.png",
        //       height: iconSize ?? 11.w,
        //       width: iconSize ?? 11.w,
        //       color: Colors.grey,
        //     ),
        //     Text(
        //       " 1550",
        //       style: theme.textTheme.bodySmall?.copyWith(
        //         color: Colors.grey,
        //         fontWeight: FontWeight.normal,
        //         fontSize: textSize ?? 13.w,
        //         decoration: TextDecoration.lineThrough,
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   width: 10.w,
        // ),
        // if (isShowDiscount)
        //   Text(
        //     "(20% off)",
        //     textAlign: TextAlign.start,
        //     style: theme.textTheme.bodyLarge?.copyWith(
        //         color: Colors.redAccent,
        //         fontWeight: FontWeight.normal,
        //         fontSize: textSize ?? 13.sp),
        //   ),
      ],
    );
  }

  Widget _buildInfoRow(
      {required String title,
        required String subTitle,
        color,
        size,
        textColor}) {
    return Row(
      children: [
        Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: size,
                  color: textColor,
                  fontWeight:
                  textColor != null ? FontWeight.w500 : FontWeight.w400),
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
              " $subTitle",
              maxLines: 2,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: color ?? Colors.black,
                fontWeight:
                textColor != null ? FontWeight.w500 : FontWeight.w400,
                fontSize: textColor != null ? 16.h : 13.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}



