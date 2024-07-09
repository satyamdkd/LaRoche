import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laroch/di/di.dart';
import 'package:laroch/models/categoies.dart';
import 'package:laroch/module/products_list/view/product_list.dart';
import 'package:laroch/utils/theme_helper.dart';
import 'package:laroch/utils/widgets/appbar.dart';
import 'package:laroch/utils/widgets/network_image.dart';

class SubSubCategory extends StatefulWidget {
  String title;
   SubSubCategory({super.key, required this.parameters,required this.title});
  final Map<String, dynamic> parameters;
  @override
  State<SubSubCategory> createState() => _SubSubCategoryState();
}

class _SubSubCategoryState extends State<SubSubCategory> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        homeController.getSubSubCategoryListItems(
          context,
          subSubParameters: widget.parameters,
          callBack: () => setState(() {}),
        );
      },
    );
  }

  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(widget.title,
        //"Sub Sub Categories",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: homeController.subSubCatLoader
          ? Center(
              child: CircularProgressIndicator(
                color: appColors.red,
                strokeWidth: 2,
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 20.w,
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: homeController.subSubItems.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 380.w,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductList(

                                        title: homeController.subSubItems[index].name!,//'Products',
                                        url: "product.php",
                                        id: homeController
                                            .subSubItems[index].code,
                                        generalProducts: true,
                                      )));
                        },
                        child: catItem(homeController.subSubItems, index),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Column catItem(List<SubSubcategoryModel> catList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        imageBuilder(catList[index].imagePath, height: 150.h, width: 150.h),
        SizedBox(height: 6.w),
        SizedBox(
          width: 150.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                catList[index].name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
