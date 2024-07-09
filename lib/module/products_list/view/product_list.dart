import 'dart:developer';

import 'package:laroch/const/common_lib.dart';
import 'package:laroch/module/products_list/bloc/product_bloc.dart';
import 'package:laroch/utils/widgets/appbar.dart';
import 'package:laroch/utils/widgets/network_image.dart';
import '../../../di/di.dart';
import '../../details/view/details.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
    required this.title,
    required this.url,
    this.id,
    this.generalProducts = false,
  });
  final String title;
  final String url;
  final String? id;
  final bool generalProducts;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();

    if (widget.generalProducts) {
      productController.generalProducts = true;
      productController.id = widget.id;
    }

    Future.delayed(Duration.zero, () {
      productController.getProductListItems(
        context,
        callBack: () => setState(() {}),
        url: widget.url,
      );
      productController.scrollControllerInit(
        context,
        () => setState(() {}),
        widget.url,
      );
    });
    log("garima+${productController.productListItem.length.toString()}");
  }

  ProductController productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white.withOpacity(0.98),
      appBar: buildCustomAppBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: productController.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: appColors.red,
                  strokeWidth: 2,
                ),
              )

          : productController.productListItem.length.toString()=='0'
            ?
        Container(color: Colors.white,
          child: Center(child: Text("Product not available",style: TextStyle(color: appColors.red,fontWeight: FontWeight.bold),)),)
            :Column(
                children: [
                  Expanded(
                    child:
                    GridView.builder(
                      shrinkWrap: true,
                      controller: productController.scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: productController.productListItem.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 350.h,
                        childAspectRatio: .75,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Details(
                                          productId:
                                              '${productController.productListItem[index].id}',
                                        )));
                          },
                          child: buildItem(
                              title:
                                  productController.productListItem[index].name,
                              isFavourite:
                                 ( productController.productListItem[index].view==null||productController.productListItem[index].view==0)?0: productController.productListItem[index].view,
                              oldPrice: productController
                                  .productListItem[index].oldprice,
                              price: productController
                                  .productListItem[index].price,
                              imagePath: productController
                                  .productListItem[index].imagePath,
                              pDID: productController.productListItem[index].id,
                              index: index),
                        );
                      },
                    ),
                  ),
                  if (productController.paginationLoader)
                    Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 20,
                          width: MediaQuery.of(context).size.width / 20,
                          child: CircularProgressIndicator(
                            color: appColors.red,
                            strokeWidth: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Loading...',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.sp,
                                color: appColors.red,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                ],
              ),
      ),
    );
  }

  buildItem(
      {imagePath,
      title,
      price,
      oldPrice,
      index,
      void Function()? onTap,
      isFavourite,
      pDID}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: appColors.white,
        margin: EdgeInsets.all(4.w),
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
                  imageBuilder(imagePath, height: 175.h, width: 175.h),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        isFavourite = isFavourite == "0" ? "0" : "1";
                        homeController.clickedIndex = index;
                        setState(() {
                          isFavourite = isFavourite == "0" ? "0" : "1";
                        });
                        homeController.deleteWishlistItem(
                          context,
                          productId: "$pDID",
                          view: isFavourite,
                          url:widget.url,

                         id: widget.id,
                          clickedIndex: index,
                          callBack: () => setState(
                            () {

                            },
                          ),
                        );
                        Future.delayed(Duration.zero, () {
                          productController.getProductListItems(
                            context,
                            callBack: () => setState(() {}),
                            url: widget.url,
                          );

                        });
                      },
                      child: index == homeController.clickedIndex &&
                              homeController.isAddingToWishlist
                          ? CircularProgressIndicator(
                              strokeWidth: 0.8,
                              color: appColors.red,
                            )
                          : (isFavourite == "0"
                              ? Icon(
                                  Icons.favorite_border_outlined,
                                  color: appColors.greyBackGround,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: appColors.red,
                                )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 175.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Image.asset(
                      //       "assets/icons/currency.png",
                      //       height: 8.w,
                      //       width: 8.w,
                      //       color: Colors.grey,
                      //     ),
                      //     Text(
                      //       oldPrice,
                      //       style: theme.textTheme.bodySmall?.copyWith(
                      //         color: Colors.grey,
                      //         fontWeight: FontWeight.normal,
                      //         fontSize: 10.w,
                      //         decoration: TextDecoration.lineThrough,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(width: 10.w),
                    ],
                  ),
                  SizedBox(width: 12.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
