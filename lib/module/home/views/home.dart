import 'package:cached_network_image/cached_network_image.dart';
import 'package:laroch/const/common_lib.dart';
import 'package:laroch/const/urls.dart';
import 'package:laroch/module/cart/view/cart.dart';
import 'package:laroch/module/details/view/details.dart';
import 'package:laroch/module/home/views/profile.dart';
import 'package:laroch/module/home/views/widget/sub_sub_cat.dart';
import 'package:laroch/module/home/views/wishlist.dart';
import 'package:laroch/module/notification/view/notification.dart';
import 'package:laroch/module/products_list/view/product_list.dart';
import 'package:laroch/module/search/view/search.dart';
import 'package:laroch/module/sub_category/view/sub_category.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../di/di.dart';
import '../../../utils/widgets/appbar.dart';
import 'category.dart';
import 'package:badges/badges.dart' as badges;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      controller.getDashBoardData(context, callBack: () => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        controller.onBackButton(() => setState(() {}));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildCustomAppBar(),
        body: buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() => BottomNavigationBar(
        elevation: 2,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.bottomNavIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.redAccent,
        onTap: (index) => controller.onBottomTap(index,
            context: context, callBack: () => setState(() {})),
        items: controller.iconList,
      );

  var controller = homeController;
  buildBody() => controller.bottomNavIndex == 0
      ? buildHomePage()
      : controller.bottomNavIndex == 1
          ? buildCategoryPage()
          : controller.bottomNavIndex == 2
              ? WishList(controller: controller)
              : controller.bottomNavIndex == 3
                  ? const Profile()
                  : const SizedBox();

  Category buildCategoryPage() => Category(controller: controller);

  viewAllTopSelling({title, url}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => ProductList(title: title, url: url)));
  }

  Widget buildHomePage() {
    return controller.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: appColors.red,
              strokeWidth: 2,
            ),
          )
        : controller.dashboardData == null
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
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5.w),
                    viewPager(context, controller.dashboardData!['data']),
                    categoryList(
                      context,
                      controller.dashboardData!['data'],
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    serviceList(
                        title: "NEW RANGE",
                        controller: controller.dashboardData!['data']
                            ['newproduct'],
                        onTapViewAll: () => viewAllTopSelling(
                            title: "New Range", url: URLs.newRange)),
                    SizedBox(
                      height: 20.w,
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    serviceGridList(
                      title: "CATEGORIES",
                      controller: controller.dashboardData!['data']
                          ['subcategory'],
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    serviceList(
                      title: "TOP SELLING",
                      controller: controller.dashboardData!['data']
                          ['topselling'],
                      onTapViewAll: () => viewAllTopSelling(
                        title: "Top Selling",
                        url: URLs.topSelling,
                      ),
                    ),
                  ],
                ),
              );
  }

  Drawer buildDrawer() {
    return const Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    );
  }

  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: controller.appBarTitle == ""
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                "assets/images/la_roch_logo.png",
                height: 45.w,
                width: 100.w,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                controller.appBarTitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black),
              ),
            ),
      actions: controller.appBarTitle == ""
          ? [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Search()),
                  );
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),

              /// notification
         GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Notifications()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w, left: 12.w),
                    child:  const   badges.Badge(
                      badgeContent:Text("3"),

                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Cart()));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w, left: 12.w),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  onViewPagerChanged(int index) {
    viewPagerCount = index;
    setState(() {});
  }

  /// ==========================================================

  int viewPagerCount = 0;
  int itemCount = 3;

  final pageController = PageController();

  List imageList = [
    "assets/images/one.jpeg",
    "assets/images/two.jpeg",
    "assets/images/three.jpeg",
  ];

  viewPager(BuildContext context, controller) {
    var data = controller['banner'].reversed.toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 210.w,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              onViewPagerChanged(index);
            },
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 8.w,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.w),
                    child: pagerImage(
                      data[index],
                    )),
              );
            },
          ),
        ),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: viewPagerCount,
            count: data.length,
            effect: ExpandingDotsEffect(
                activeDotColor: appColors.red,
                dotWidth: 10.w,
                dotHeight: 8.w,
                dotColor: Colors.grey.withOpacity(0.3)),
          ),
        ),
        SizedBox(height: 20.w),
      ],
    );
  }

  /// ==========================================================

  int categoryLength = 5;

  categoryList(BuildContext context, passedData) {
    var data = passedData['maincategory'];

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            5,
            (index) {
              return GestureDetector(
                onTap: () {
                  controller.categoryPageCalledFromHome(
                      context: context,
                      callBack: () => setState(() {}),
                      id: '${data[index]['code']}');
                },
                  child: servicesListViewItem(
                  path: "${data[index]['image_path']}",
                  title: data[index]['name'],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Services list view item ==================================
  Widget servicesListViewItem({required String path, required String title}) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28.w,
            backgroundColor: appColors.white,
            backgroundImage: NetworkImage(path),
          ),
          SizedBox(height: 8.w),
          SizedBox(
            child: Text(
              title.split(' ').first.toString(),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 9.sp,
                  fontFamily: "Inter",
                  color: Colors.black.withOpacity(0.8)),
            ),
          )
        ],
      ),
    );
  }

  Widget serviceGridList({required String title, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter",
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubCategory(
                          url: URLs.viewAllCategories,
                        ),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15.w)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                    child: Text(
                      "VIEW ALL",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontFamily: "Inter"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.w),
        Container(
          padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 15.h),
          width: MediaQuery.of(context).size.width,
          height: 490.h,
          color: Colors.grey.withOpacity(0.06),

          /// color: color ?? appColors.white,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubSubCategory(
                                    title: controller[index]['name'],
                                    parameters: {
                                      "id":
                                          "${controller[index]['category_code']}",
                                      "code": "${controller[index]['code']}",
                                      "name": "${controller[index]['name']}",
                                    })));
                  },
                  child: catItem(
                    index,
                    controller: controller,
                    color: Colors.grey.withOpacity(0.06),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget catItem(int index, {controller, color}) {
    var data = controller;
    return Container(
      margin: EdgeInsets.only(right: 6.w, bottom: 6.w),
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(3.w),
              child: pagerImage(data[index]['image_path'],
                  height: 145.w, width: 145.w)),
          SizedBox(height: 6.w),
          SizedBox(
            width: 145.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[index]['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: appColors.black900.withOpacity(0.8),
                      fontSize: 12.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// =====================================================

  viewProduct(id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => Details(
                  productId: '$id',
                )));
  }

  Widget serviceList(
      {required String title,
      controller,
      void Function()? onTapViewAll,
      void Function()? onItemTap}) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.06)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15.w)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                    child: GestureDetector(
                      onTap: onTapViewAll,
                      child: Text(
                        "VIEW ALL",
                        style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontFamily: "Inter"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.w),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                controller.length,
                (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 15.w,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          viewProduct(controller[index]['id']);
                        },
                        child: catItem(index, controller: controller)),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20.w),
        ],
      ),
    );
  }

  pagerImage(imageUrl, {height, width}) {
    return CachedNetworkImage(
      imageUrl: imageUrl == null || imageUrl == ""
          ? "https://t3.ftcdn.net/jpg/00/36/94/26/360_F_36942622_9SUXpSuE5JlfxLFKB1jHu5Z07eVIWQ2W.jpg"
          : imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height ?? 190.w,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: const BoxDecoration(
          color: Color(0xffeeeeee),
        ),
      ),
      errorWidget: (context, value, error) {
        return Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                  "https://t3.ftcdn.net/jpg/00/36/94/26/360_F_36942622_9SUXpSuE5JlfxLFKB1jHu5Z07eVIWQ2W.jpg"),
              fit: BoxFit.cover,
            ),
            color: appColors.white,
          ),
        );
      },
    );
  }
}
