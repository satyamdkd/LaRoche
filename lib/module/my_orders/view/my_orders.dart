import 'package:laroch/const/common_lib.dart';
import '../../../models/category_list_item.dart';
import '../../../utils/widgets/appbar.dart';
import '../bloc/orders_bloc.dart';
import 'orderDetail.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}
OrderHistoryController orderHistoryController=OrderHistoryController();

class _MyOrdersState extends State<MyOrders> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "My Orders",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  @override
  void initState() {
    orderHistoryController.getCartHistory(context, callBack: () => setState(() {}));
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body:  orderHistoryController.isLoading
          ? Center(child: CircularProgressIndicator(color: appColors.red,))
        :( orderHistoryController.historyList==null)?Container(height: MediaQuery.of(context).size.height,



        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.list_alt_sharp,color:appColors.red ,),
              Text("No order available",style: TextStyle(color: appColors.red),),
            ],
          ),
        )
      ):   SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.02),
              borderRadius: BorderRadius.circular(3.h)),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ...List.generate(
                orderHistoryController.historyList!['data']['orderlist'].length,
                (index) {
                  return GestureDetector(
                    onTap: () {},
                    child: catItem( index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<CategoryListItem> range = [
    CategoryListItem(
        imagePath: "assets/images/new_ranges/one.png", title: "Towel bar "),
    CategoryListItem(
        imagePath: "assets/images/new_ranges/two.png", title: "Soap holder"),
  ];

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
                // child: Image.asset(
                //   catList[0].imagePath!,
                //   height: 110.w,
                //   width: 110.w,
                //   fit: BoxFit.cover,
                // ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderHistoryController.historyList!['data']['orderlist'][index]['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    // Text(
                    //   "Qty:  1",
                    //   textAlign: TextAlign.start,
                    //   style: theme.textTheme.bodyLarge?.copyWith(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.normal,
                    //       fontSize: 10.sp),
                    // ),
                    SizedBox(
                      height: 6.h,
                    ),
                    // priceWidget(
                    //   iconSize: 8.w,
                    //   textSize: 10.w,
                    //   spacing: 4.w,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _buildInfoRow(
            title: orderHistoryController.historyList!['data']['orderlist'][index]['orderid']==null?"":"Order ${ orderHistoryController.historyList!['data']['orderlist'][index]['orderid']}",
            subTitle: orderHistoryController.historyList!['data']['orderlist'][index]['finalpayment'],
            showIcon: true,
            textColorOne: appColors.black900,
            size: 14.0),
        SizedBox(
          height: 5.h,
        ),
        _buildInfoRow(
            title:    orderHistoryController.historyList!['data']['orderlist'][index]['orderdate'],
            subTitle:   orderHistoryController.historyList!['data']['orderlist'][index]['transaction_status']==null? "Pending":"Transaction Complete",
            color: appColors.red,
            showIcon: false,
            size: 12.0),
        const SizedBox(
          height: 10.0,
        ),

        buildBottoms(index),
        const SizedBox(
          height: 15.0,
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

  Row priceWidget({iconSize, textSize, spacing, isShowDiscount}) {
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
              "  1,350",
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
      ],
    );
  }

  Column buildBottoms( int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          thickness: 0.5,
          color: Colors.grey.withOpacity(0.07),
        ),
        SizedBox(
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(
              //   child: OutlinedButton(
              //     onPressed: () {},
              //     child: Text(
              //       "ORDER FEEDBACK",
              //       style: theme.textTheme.bodyMedium
              //           ?.copyWith(color: appColors.red),
              //     ),
              //   ),
              // ),
              SizedBox(width: 10.w,),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if( orderHistoryController.historyList!['data']['orderlist'][index]['details'].length>0)
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails(productList: orderHistoryController.historyList!['data']['orderlist'][index]['details'] ,
                    finalpayment: orderHistoryController.historyList!['data']['orderlist'][index]['finalpayment'],shipping_charges: orderHistoryController.historyList!['data']['orderlist'][index]['shipping_charges'].toString(),)));
                  },
                  child: Text(
                    "ORDER DETAILS",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
      {required String title,
      required String subTitle,
      color,
      size,
      showIcon,
      textColorOne,
      textColorTwo}) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: size,
              color: textColorOne,
              fontFamily: 'Inter',
              fontWeight:
                  textColorOne != null ? FontWeight.w500 : FontWeight.w400),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showIcon)
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
                fontFamily: 'Inter',
                fontWeight:
                    textColorTwo != null ? FontWeight.w500 : FontWeight.w400,
                fontSize: textColorTwo != null ? 13.h : 11.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
