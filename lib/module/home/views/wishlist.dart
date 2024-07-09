import 'dart:developer';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/module/home/bloc/home_bloc.dart';
import 'package:laroch/utils/widgets/network_image.dart';

class WishList extends StatefulWidget {
  const WishList({
    super.key,
    required this.controller,
  });
  final Controller controller;
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await widget.controller.getWishlist(
        context,
        callBack: () => setState(() {}),
      );
      log("{========} ${widget.controller.wishListModel!.data} {========}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: appColors.red,
              strokeWidth: 2,
            ),
          )
        : widget.controller.wishListModel == null
            ? Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Text(
                    "No data found!\nplease add items to wishlist.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.controller.wishListModel!.data!.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 350.h,
                    childAspectRatio: .75,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: buildItem(
                        imagePath: widget
                            .controller.wishListModel!.data![index].imagename
                            .toString(),
                        id: widget.controller.wishListModel!.data![index].id
                            .toString(),
                        title: widget
                            .controller.wishListModel!.data![index].name
                            .toString(),
                        price: widget
                            .controller.wishListModel!.data![index].price
                            .toString(),
                        oldPrice: widget
                            .controller.wishListModel!.data![index].oldPrice
                            .toString(),
                      ),
                    );
                  },
                ),
              );
  }

  buildItem(
      {imagePath, id, title, price, oldPrice, index, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 175.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.w),
            ),
            child: Stack(
              children: [
                imageBuilder(
                  imagePath,
                  height: 175.w,
                  width: 175.w,
                ),
                Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () async {
                        await widget.controller.deleteWishlistItem(
                          context,
                          productId: id,
                          view: "1",
                          callBack: () => setState(() {}),
                        );

                        Future.delayed(Duration.zero, () {
                          widget.controller.getWishlist(
                            context,
                            callBack: () => setState(() {}),
                          );
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        color: appColors.red,
                      ),
                    )),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     width: 175.w,
          //     padding: EdgeInsets.all(4.w),
          //     decoration: const BoxDecoration(
          //       color: Color(0xffECECEC),
          //     ),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisSize: MainAxisSize.min,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(
          //           Icons.shopping_cart_outlined,
          //           color: appColors.red,
          //           size: 18.w,
          //         ),
          //         Text(
          //           "  Move to Cart",
          //           overflow: TextOverflow.ellipsis,
          //           style: theme.textTheme.bodyMedium?.copyWith(
          //               color: appColors.red,
          //               fontSize: 14.sp,
          //               fontFamily: "Inter",
          //               fontWeight: FontWeight.w400),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 175.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/currency.png",
                          height: 8.w,
                          width: 8.w,
                        ),
                        Text(
                          price,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.w),

                    /// Row(
                    ///   mainAxisAlignment: MainAxisAlignment.start,
                    ///   crossAxisAlignment: CrossAxisAlignment.center,
                    ///   children: [
                    ///     Image.asset(
                    ///       "assets/icons/currency.png",
                    ///       height: 8.w,
                    ///       width: 8.w,
                    ///       color: Colors.grey,
                    ///     ),
                    ///     Text(
                    ///       oldPrice,
                    ///       style: theme.textTheme.bodySmall?.copyWith(
                    ///         color: Colors.grey,
                    ///         fontWeight: FontWeight.normal,
                    ///         fontSize: 10.w,
                    ///         decoration: TextDecoration.lineThrough,
                    ///       ),
                    ///     ),
                    ///   ],
                    /// ),
                    /// SizedBox(
                    ///   width: 10.w,
                    /// ),
                  ],
                ),
                SizedBox(width: 12.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
