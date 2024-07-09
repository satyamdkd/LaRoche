import 'package:laroch/const/common_lib.dart';
import 'package:laroch/models/cartitems.dart';
import 'package:laroch/module/cart/bloc/cart_bloc.dart';
import 'package:laroch/module/checkout/view/checkout.dart';
import 'package:laroch/utils/widgets/network_image.dart';
import '../../../utils/widgets/appbar.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Cart",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  CartController cartController = CartController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      cartController.getCartItems(context: context, callBack: () => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      bottomNavigationBar: cartController.isLoading ||
              cartController.cartItems == null ||
              cartController.cartItems!.data!.cartItem!.isEmpty
          ? const SizedBox()
          : buildBottomNav(),
      body: cartController.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: appColors.red,
                strokeWidth: 2,
              ),
            )
          : cartController.cartItems == null ||
                  cartController.cartItems!.data!.cartItem!.isEmpty
              ? Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      "No data found!",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              : cartListView(),
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
                cartController.cartItems!.data!.cartItem!,
                title: "Compatible with",
              ),
            ]),
      ),
    );
  }

  Column buildBottomNav() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          thickness: 2,
          color: Colors.grey.withOpacity(0.07),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child:

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Image.asset(
                    //       "assets/icons/currency.png",
                    //       height: 14.w,
                    //       width: 14.w,
                    //     ),
                    //     Text(
                    //       " ${cartController.cartItems!.data!.total!}",
                    //       maxLines: 2,
                    //       textAlign: TextAlign.start,
                    //       overflow: TextOverflow.ellipsis,
                    //       style: theme.textTheme.bodyLarge?.copyWith(
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 14.w,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Text(
                    //   "View Details",
                    //   maxLines: 2,
                    //   textAlign: TextAlign.start,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: theme.textTheme.bodyLarge?.copyWith(
                    //     color: Colors.redAccent,
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 12.w,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckOut(),
                      ),
                    );
                  },
                  child: Text(
                    "PLACE ORDER",
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cartList(List<CartItem> items, {required String title}) {
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
                  items.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {},
                      child: catItem(items, index),
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
                    title: "Total",
                    subTitle:
                        cartController.cartItems!.data!.total!.toString()),
                SizedBox(
                  height: 5.h,
                ),
                if(cartController.cartItems!.data?.savings!=null) _buildInfoRow(
                    title: "Savings",
                    subTitle:
                        cartController.cartItems!.data!.savings!.toString(),
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
                    subTitle: cartController.cartItems!.data!.total!.toString(),
                    size: 16.0,
                    textColor: Colors.black),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  margin: EdgeInsets.all(4.h),
                  padding: EdgeInsets.all(4.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/truck.png",
                        height: 30.w,
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        " Actual taxes and shipping will be calculated at checkout",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 8.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  catItem(List<CartItem> catList, int index) {
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
                  "${catList[index].image}",
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
                      "${catList[index].proname}",
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
                      "${catList[index].proname}",
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
                      price: "${catList[index].price}",
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Quantity  :  ${catList[index].qty}",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            await cartController.moveToWishlist(
                                id: cartController
                                    .cartItems!.data!.cartItem![index].proId
                                    .toString(),
                                callBack: () => setState(() {}),
                                context: context);

                            await Future.delayed(Duration.zero, () async {
                              await cartController.deleteFromCart(
                                  id: cartController
                                      .cartItems!.data!.cartItem![index].id
                                      .toString(),
                                  callBack: () => setState(() {}),
                                  context: context);
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Text(
                                "  Move to wishlist",
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.black.withOpacity(
                                      0.7,
                                    ),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          height: 25.h,
                          width: 2.w,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: () async {
                            await cartController.deleteFromCart(
                              id: cartController
                                  .cartItems!.data!.cartItem![index].id
                                  .toString(),
                              callBack: () => setState(() {}),
                              context: context,
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Text(
                                "  Remove",
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
