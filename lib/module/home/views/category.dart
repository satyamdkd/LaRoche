import 'package:laroch/const/common_lib.dart';
import 'package:laroch/models/categoies.dart';
import 'package:laroch/module/home/bloc/home_bloc.dart';
import 'package:laroch/module/home/views/widget/sub_sub_cat.dart';
import 'package:laroch/utils/widgets/network_image.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Category extends StatefulWidget {
  const Category({
    super.key,
    required this.controller,
  });
  final Controller controller;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.isLoading
        ? Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: appColors.red,
            ),
          )
        :    ( widget.controller.categories==null)?Container(): Container(
            alignment: Alignment.centerLeft,
            color: Colors.grey.withOpacity(0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                categoryList(
                  context,
                  widget.controller.categories!.data!,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: serviceGridList(
                    widget.controller.categories!.data!.subcategory!,
                    title: "",
                  ),
                ),
              ],
            ),
          );
  }

  ///===========================================================================

  categoryList(BuildContext context, Data item) {
    return Container(
      height: MediaQuery.of(context).size.height - 165.h,
      width: 100,
      margin: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(2.h),
          bottomRight: Radius.circular(2.h),
        ),
      ),
      child: ScrollablePositionedList.builder(
        itemCount: item.maincategory!.length,
        itemBuilder: (context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                widget.controller.parameters = {
                  'id': '${item.maincategory![index].code}'
                };

                await widget.controller.getCategories(
                  context,
                  callBack: () => setState(() {}),
                );

                Future.delayed(const Duration(seconds: 1), () {
                  itemScrollController.scrollTo(
                      index: index,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOutCubic);
                });
              },
              child: servicesListViewItem(
                path: "${item.maincategory![index].imagePath}",
                title: item.maincategory![index].name!,
                isSelected: item.maincategory![index].code ==
                        item.subcategory![0].categoryCode
                    ? true
                    : false,
              ),
            ),
          ],
        ),
        itemScrollController: itemScrollController,
      ),
    );
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  Widget servicesListViewItem(
      {required String path, required String title, required bool isSelected}) {
    return Container(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? appColors.red.withOpacity(0.6) : Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.h),
            bottomRight: Radius.circular(15.h),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            CircleAvatar(
              radius: 30.w,
              backgroundColor: appColors.greyBackGround,
              backgroundImage: NetworkImage(path),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: 75.w,
              child: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 8.sp,
                  fontFamily: "Inter",
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Column catItem(List<Subcategory> catList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(6.w),
            child: imageBuilder(catList[index].imagePath,
                height: 110.w, width: 120.w)),
        SizedBox(height: 6.h),
        SizedBox(
          width: 120.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                catList[index].name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontFamily: "Inter",
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget serviceGridList(List<Subcategory> catList, {required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.h),
              bottomLeft: Radius.circular(6.h),
            ),
          ),
          width: MediaQuery.of(context).size.width - 100.w,
          height: MediaQuery.of(context).size.height - 189.h,
          padding: EdgeInsets.all(10.h),
          margin: EdgeInsets.only(top: 10.h),
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: catList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250.h,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubSubCategory(
                              title: catList[index].name!,
                                  parameters: {
                                    "id": "${catList[index].categoryCode}",
                                    "code": "${catList[index].code}",
                                    "name" : "${catList[index].name}",
                                  },
                                )));
                  },
                  child: catItem(catList, index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
