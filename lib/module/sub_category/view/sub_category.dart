import 'package:laroch/const/common_lib.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/models/ProductListItems.dart';
import 'package:laroch/module/details/view/details.dart';
import 'package:laroch/module/sub_category/bloc/sub_cat_bloc.dart';
import 'package:laroch/utils/widgets/network_image.dart';
import '../../../utils/widgets/appbar.dart';
import '../../home/views/widget/sub_sub_cat.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({super.key, required this.url});
  final String url;

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  SubCategoryController subCategoryController = SubCategoryController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      subCategoryController.getSubCategoryListItems(
        context,
        callBack: () => setState(() {}),
        url: widget.url,
      );
      subCategoryController.scrollControllerInit(
        context,
        () => setState(() {}),
        widget.url,
      );
    });
  }

  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Category",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: subCategoryController.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: appColors.red,
                strokeWidth: 2,
              ),
            )
          : Column(
              children: [
                if (widget.url != URLs.viewAllCategories)
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
                    child: Text(
                      "ACCESSORIES",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20.w,
                ),
                Expanded(
                  child: GridView.builder(
                    controller: subCategoryController.scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount:
                        subCategoryController.viewAllCategoryItems.length,
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
                                  builder: (context) => SubSubCategory(
                                      title: "",
                                      parameters: {
                                        "id":
                                        subCategoryController
                                            .viewAllCategoryItems[index].categorycode,
                                        "code":  subCategoryController
                                            .viewAllCategoryItems[index].code,
                                        "name": subCategoryController
                                            .viewAllCategoryItems[index].name
                                      })));

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SubSubCategory(
                          //           title: "",
                          //           parameters: {
                          //             "id": subCategoryController
                          //                             .viewAllCategoryItems[index].id,
                          //             "code": subCategoryController
                          //                               .viewAllCategoryItems[index].code
                          //           },
                          //         )));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Details(
                          //               productId: subCategoryController
                          //                   .viewAllCategoryItems[index].id,
                          //             )));
                        },
                        child: catItem(
                            subCategoryController.viewAllCategoryItems, index),
                      );
                    },
                  ),
                ),
                if (subCategoryController.paginationLoader)
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
    );
  }

  /// Widget serviceGridList(List<CategoryListItem> catList,
  //     {required String title}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       GridView.builder(
  //         shrinkWrap: true,
  //         scrollDirection: Axis.vertical,
  //         itemCount: catList.length,
  //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //           maxCrossAxisExtent: 300.w,
  //           childAspectRatio: 1.1,
  //         ),
  //         itemBuilder: (context, index) {
  //           return Padding(
  //             padding: EdgeInsets.only(
  //               left: 15.w,
  //             ),
  //             child: GestureDetector(
  //               onTap: () {},
  //               child: catItem(catList, index),
  //             ),
  //           );
  //         },
  //       ),
  //     ],
  //   );
  /// }

  Column catItem(List<Newrangeproductallview> catList, int index) {
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
