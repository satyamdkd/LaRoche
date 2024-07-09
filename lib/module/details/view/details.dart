import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/models/product_details.dart';
import 'package:laroch/module/cart/view/cart.dart';
import 'package:laroch/module/details/bloc/details_bloc.dart';
import 'package:laroch/module/details/view/material.dart';
import 'package:laroch/module/details/widget/view_image.dart';
import 'package:laroch/utils/helper/keyboard_utli.dart';
import 'package:laroch/utils/widgets/network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/widgets/appbar.dart';
import 'dimentions.dart';

class Details extends StatefulWidget {
  final String? productId;
  const Details({super.key, this.productId});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    detailController.productId=widget.productId;
    detailController.quantityControlar.text=detailController.quantity.toString();
    Future.delayed(Duration.zero, () {
      detailController.getProductDetails(
        context,
        widget.productId!,
        callBack: () => setState(() {}),
      );
    });
  }

  DetailController detailController = DetailController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(title: ""),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        },
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
              color: appColors.red, borderRadius: BorderRadius.circular(25.h)),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: appColors.white,
          ),
        ),
      ),
      bottomNavigationBar: detailController.isLoading
          ? const SizedBox():
      detailController.productDetails == null?null : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  thickness: 2,
                  color: Colors.grey.withOpacity(0.07),
                ),
                Container(
                  height: 70.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            detailController.deleteWishlistItem(
                              context,
                              productId: detailController.productDetails?.data?.newproduct![0].id??"",
                              view: detailController.productDetails?.data!
                                  .newproduct![0].view=="0"?"0":"1" ,
                              clickedIndex: 0,
                              callBack: () => setState(
                                    () {},
                              ),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Icon(
                                 /// change on tap
                                detailController.productDetails?.data!
                                    .newproduct![0].view=="0"?Icons.favorite_border_outlined:Icons.favorite,
                                color: detailController.productDetails?.data!
                                    .newproduct![0].view=="0"?Colors.grey:appColors.red,
                              ),
                              Text(
                                "  WISHLIST",
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: detailController.productDetails?.data!
                                        .newproduct![0].view=="1"?Colors.red:Colors.black.withOpacity(
                                      0.7,
                                    ),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 25.h,
                        width: 2.w,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      (detailController.productDetails?.data?.newproduct![0].qty=="0")?
                      Expanded(
                        child:
                             Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              "  Out of stock ",
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(
                                  color: Colors.redAccent,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ):
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            detailController.addToCart(
                                context: context,
                                callBack: () => setState(() {}));
                          },
                          child: detailController.isAddingToCart
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: appColors.red,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.redAccent,
                                    ),
                                    Text(
                                      "  ADD TO Cart",
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              color: Colors.redAccent,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      body: detailController.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: appColors.red,
                strokeWidth: 2,
              ),
            )
          : detailController.productDetails == null
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
              : SafeArea(
                  child: GestureDetector(
                    onTap: (){
                      KeyboardUtil.hideKeyboard(context);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          viewPager(context),
                          SizedBox(
                            height: 10.h,
                          ),

                          ///-----------------------------
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  detailController.productDetails?.data!
                                          .newproduct![0].name ??
                                      "",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 80.w),
                                  child: Text(
                                    detailController.productDetails?.data!
                                            .newproduct![0].itemDescription ??
                                        "",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.sp),
                                  ),
                                ),

                                /// SizedBox(
                                ///   height: 5.h,
                                /// ),
                                /// Row(
                                ///   children: [
                                ///     const MyRatings(
                                ///       rating: 3,
                                ///       alignment: Alignment.centerLeft,
                                ///       ignoreGestures: true,
                                ///     ),
                                ///     SizedBox(
                                ///       width: 5.w,
                                ///     ),
                                ///     Text(
                                ///       "(20 ratings)",
                                ///       maxLines: 2,
                                ///       textAlign: TextAlign.start,
                                ///       overflow: TextOverflow.ellipsis,
                                ///       style: theme.textTheme.bodyLarge?.copyWith(
                                ///           color: Colors.grey,
                                ///           fontWeight: FontWeight.normal,
                                ///           fontSize: 10.sp),
                                ///     ),
                                ///   ],
                                /// ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                priceWidget(
                                    detailController.productDetails?.data!
                                            .newproduct![0].price ??
                                        "",
                                    detailController.productDetails?.data!
                                            .newproduct![0].oldprice ??
                                        "",
                                    detailController.productDetails?.data!
                                            .newproduct![0].percentoff ??
                                        ""),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "inclusive of all taxes",
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Quantity:",
                                  textAlign: TextAlign.start,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          detailController.removeItemQuantity(
                                              callBack: () => setState(() {}));
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.asset(
                                            "assets/icons/minus.png",
                                            height: 20.w,
                                            width: 20.w,
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Container(width: 30,child: TextFormField(
                                          onChanged: (value){
                    setState(() {

                      if( detailController.quantityControlar.text.isEmpty){
                        detailController.quantityControlar.text="1";
                      }else
                      if (double.parse(value)< double.parse(detailController.productDetails?.data?.newproduct![0].qty ?? "0"))
                      {
                        detailController.quantity=int.parse(value);

                      }
                      else{
                        detailController.quantityControlar.text=detailController.productDetails?.data?.newproduct![0].qty??"";

                      }


                    });


                                          },
                                          keyboardType: TextInputType.number,
                                          controller: detailController.quantityControlar,
                                          decoration: InputDecoration(border: InputBorder.none,
                                            focusedBorder: InputBorder.none,),
                                        )),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 16.0),
                                      //   child: Text(
                                      //     detailController.quantity.toString(),
                                      //     textAlign: TextAlign.start,
                                      //     style: theme.textTheme.bodyLarge
                                      //         ?.copyWith(
                                      //             color: Colors.black,
                                      //             fontWeight: FontWeight.normal,
                                      //             fontSize: 16.sp),
                                      //   ),
                                      // ),
                                      GestureDetector(
                                        onTap: () {

                                          detailController.quantityIncrement(
                                              callBack: () => setState(() {}),
                                              context: context);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.asset(
                                            "assets/icons/plus.png",
                                            height: 20.w,
                                            width: 20.w,
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 14.h,
                          ),
                          Divider(
                            thickness: 6.h,
                          ),

                          ///-----------------------------
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product Details",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  detailController.productDetails?.data!
                                          .newproduct![0].name ??
                                      "",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black.withOpacity(0.6),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13.sp),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    log(detailController.productDetails!.data!
                                        .newproduct![0]!.docsPath.toString());
                                  if  (detailController.productDetails?.data!
                                        .newproduct![0].docsPath!=null )Navigator.push(context, MaterialPageRoute(builder: (context)=>Dimentions(url:  detailController.productDetails?.data!
                                        .newproduct![0].docsPath,)));
                                  },
                                  child: Text(
                                    "Dimensions",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                        color: (detailController.productDetails?.data!
                                            .newproduct![0].docsPath==null )?Colors.black:appColors.red,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "--",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black.withOpacity(0.6),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13.sp),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    log(detailController.productDetails!.data!
                                        .newproduct![0]!.docsPathtwo.toString());
                                    if  (detailController.productDetails?.data!
                                        .newproduct![0].docsPathtwo!=null )
                                      {
                                        if(detailController.productDetails!.data!
                                            .newproduct![0].docsPathtwo!.contains('.pdf')){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dimentions(url:  detailController.productDetails?.data!
                                              .newproduct![0].docsPath,)));
                                        }

                                        else  Navigator.push(context, MaterialPageRoute(builder: (context)=>MaterialView(image_url:  detailController.productDetails?.data!
                                            .newproduct![0].docsPathtwo,)));
                                      }

                                  },
                                  child: Text(
                                    "Material",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                        color: (detailController.productDetails?.data!
                                            .newproduct![0].docsPathtwo==null )?Colors.black:appColors.red,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "--",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black.withOpacity(0.6),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Divider(
                            thickness: 6.h,
                          ),

                          serviceList(
                            detailController.productDetails?.data?.relatedproduct,
                            title: "Compatible with",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Row priceWidget(String price, String oldprice, String percentOff,
      {iconSize, textSize, spacing}) {
    return Row(
      children: [
        detailController.productDetails?.data!
            .newproduct![0].promotionPro=="1"?  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/currency.png",
              height: iconSize ?? 11.w,
              width: iconSize ?? 11.w,
              color: Colors.grey,
            ),
            Text(
              oldprice,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: textSize ?? 13.w,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ):Text(""),
        SizedBox(
          width: 10.w,
        ),
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
              price,
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
        // detailController.productDetails?.data!
        //     .newproduct![0].promotionPro=="1"?  Row(
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
        //       oldprice,
        //       style: theme.textTheme.bodySmall?.copyWith(
        //         color: Colors.grey,
        //         fontWeight: FontWeight.normal,
        //         fontSize: textSize ?? 13.w,
        //         decoration: TextDecoration.lineThrough,
        //       ),
        //     ),
        //   ],
        // ):Text(""),
        // SizedBox(
        //   width: 10.w,
        // ),
        // Text(
        //   "(${percentOff.toString().split('.').first}% off)",
        //   textAlign: TextAlign.start,
        //   style: theme.textTheme.bodyLarge?.copyWith(
        //       color: Colors.redAccent,
        //       fontWeight: FontWeight.normal,
        //       fontSize: textSize ?? 13.sp),
        // ),
      ],
    );
  }

  int viewPagerCount = 0;
  int itemCount = 3;
  final pageController = PageController();

  List imageList = [
    "assets/images/one.jpeg",
    "assets/images/two.jpeg",
    "assets/images/three.jpeg"
  ];

  onViewPagerChanged(int index) {
    viewPagerCount = index;
    setState(() {});
  }

  viewPager(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 250.h,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  onViewPagerChanged(index);
                },
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewImage(
                                imageUrl: detailController.productDetails!.data!
                                    .newproduct![0].imagePath!),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3.w),
                        child: imageBuilder(
                          detailController
                                  .productDetails?.data?.newproduct![0].imagePath ??
                              "",
                          height: 250.h,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: AnimatedSmoothIndicator(
                activeIndex: viewPagerCount,
                count: itemCount,
                effect: ExpandingDotsEffect(
                    dotColor: Colors.grey.withOpacity(0.3),
                    activeDotColor: Colors.grey.withOpacity(0.6),
                    dotWidth: 10.h,
                    dotHeight: 8.h),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
        Positioned( top: 0, child: Padding(
    padding: EdgeInsets.symmetric(
    horizontal: 12.w,
    vertical: 8.h,),
          child:  detailController.productDetails?.data!
              .newproduct![0].promotionPro=="1" ? Container(height: 25,width: 120,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))

          ),
            child: Center(child: Text("Promotional",style: TextStyle(color: Colors.white),)),
          ):Container(),
        )),
      ],
    );
  }

  Widget serviceList(List<Newproduct>? newRanges, {required String title}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(3.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          if (newRanges != null && newRanges.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  newRanges.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 15.w,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      productId: newRanges[index].id,
                                    )),
                          ).then((value) => Navigator.pop(context));
                        },
                        child: catItem(newRanges, index),
                      ),
                    );
                  },
                ),
              ),
            ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Column catItem(List<Newproduct>? catList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3.w),
          child:imageBuilder(catList![index].imagePath,
              height: 110.w, width: 120.w)
          // CachedNetworkImage(
          //   imageUrl: catList![index].imagePath!,
          //   height: 150.w,
          //   width: 150.w,
          //   fit: BoxFit.cover,
          // ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: 150.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// const MyRatings(
              ///   rating: 3,
              ///   alignment: Alignment.centerLeft,
              ///   ignoreGestures: true,
              /// ),
              Text(
                catList[index].name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.black.withOpacity(0.8)),
              ),
              priceWidget(
                  catList[index].price.toString(),
                  catList[index].oldprice.toString(),
                  catList[index].percentoff.toString(),
                  iconSize: 6.w,
                  textSize: 8.w,
                  spacing: 4.w)
            ],
          ),
        )
      ],
    );
  }
}
