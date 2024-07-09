import 'package:laroch/const/common_lib.dart';
import '../../../models/category_list_item.dart';
import '../../../utils/widgets/appbar.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Notifications",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(3.h)),
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                ...List.generate(
                  range.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {},
                      child: catItem(range, index),
                    );
                  },
                ),
              ]))),
    );
  }

  List<CategoryListItem> range = [
    CategoryListItem(
        imagePath: "assets/images/new_ranges/one.png",
        title: "Robe Hook ",
        subtitle: "Your Robe Hook has been processed from our store"),
    CategoryListItem(
        imagePath: "assets/images/new_ranges/two.png",
        title: "Shelfs",
        subtitle: "Your Shelfs has been processed from our store"),
    CategoryListItem(
        imagePath: "assets/images/new_ranges/one.png",
        title: "Robe Hook ",
        subtitle: "Your Robe Hook has been processed from our store"),
  ];

  catItem(List<CategoryListItem> catList, int index) {
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
                borderRadius: BorderRadius.circular(5.h),
                child: Image.asset(
                  catList[index].imagePath!,
                  height: 110.w,
                  width: 110.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      catList[index].title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      catList[index].subtitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.07),
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
