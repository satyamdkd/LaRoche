import 'package:laroch/const/common_lib.dart';
import 'package:laroch/di/di.dart';
import 'package:laroch/module/address/view/address.dart';
import 'package:laroch/module/home/views/contactUs.dart';
import 'package:laroch/module/home/views/privacyPolicy.dart';
import 'package:laroch/module/my_account/view/my_account.dart';
import 'package:laroch/module/my_orders/view/my_orders.dart';
import 'package:laroch/module/track_order/view/track_order.dart';
import 'package:laroch/utils/helper/sharedpref.dart';
import 'package:laroch/utils/widgets/dialogs/dailog.dart';

import '../../checkout/view/termCondition.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List yourInfoItemTitleOne = [
    "My Account",

    "Address Book"
  ];
  List yourInfoItemImagePath = [
    "assets/icons/profile.png",
    // "assets/icons/orders.png",
    // "assets/icons/track_order.png",
    "assets/icons/add_book.png",
  ];

  List contactAndTcImagePath = [
    "assets/icons/phone.png",
    "assets/icons/privacy.png",
    "assets/icons/tc.png",
  ];

  List contactAndTcTile = [
    "Contact Us",
    "Privacy Policy ",
    "Terms & Conditions"
  ];

  List yourInfoItemTitleTWo = [
    "Manage your profile",
    "All past orders",
    "Manage your profile",
    "Edit & add new addresses"
  ];

  onTapInfoItem(index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyAccount()));
    }
    // if (index == 1) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const MyOrders()));
    // }
    // if (index == 2) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const TrackOrder()));
    // }
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  Address(setStateCallbackFromAddressPage: () => setState(() {}))));
    } else {
      debugPrint("");
    }
  }
  onTapcontactAndTcTile(index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ContactUs()));
    }


    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  PrivacyPolicy()));
    }
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  TermCondition()));
    }
    else {
      debugPrint("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        buildAccDetails(),
        SizedBox(
          height: 20.h,
        ),
        Divider(
          thickness: 3,
          color: Colors.grey.withOpacity(0.07),
        ),
        SizedBox(
          height: 20.h,
        ),
        buildOrderAndWishlist(),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "YOUR INFORMATION",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              fontFamily: "Inter",
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        ...List.generate(
            yourInfoItemTitleOne.length,
            (index) => buildYourInfoItems(
                imagePath: yourInfoItemImagePath[index],
                titleOne: yourInfoItemTitleOne[index],
                titleTwo: yourInfoItemTitleTWo[index],
                onTap: () => onTapInfoItem(index),
                showDivider:
                    index == yourInfoItemTitleOne.length - 1 ? false : true)),
        SizedBox(
          height: 30.h,
        ),
        Divider(
          thickness: 30,
          color: Colors.grey.withOpacity(0.04),
        ),
        SizedBox(
          height: 20.h,
        ),
        ...List.generate(
            contactAndTcTile.length,
            (index) => buildYourInfoItems(
                imagePath: contactAndTcImagePath[index],
                titleOne: contactAndTcTile[index],
                onTap: () => onTapcontactAndTcTile(index),
                showDivider:
                    index == contactAndTcTile.length - 1 ? false : true)),
        SizedBox(
          height: 30.h,
        ),
        Divider(
          thickness: 30,
          color: Colors.grey.withOpacity(0.04),
        ),
        SizedBox(
          height: 30.h,
        ),
        buildYourInfoItems(
            imagePath: "assets/icons/signout.png",
            titleOne: "Sign Out",
            showDivider: false,
            onTap: () => logoutDialogNew("", context: context))
      ],
    ));
  }

  Widget buildYourInfoItems(
      {imagePath,
      titleOne,
      titleTwo,
      void Function()? onTap,
      showDivider = true}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  height: 28.w,
                  width: 28.w,
                  color: Colors.grey.withOpacity(0.7),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleOne,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500),
                      ),
                      if (titleTwo != null)
                        Text(
                          titleTwo,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black.withOpacity(
                                0.5,
                              ),
                              fontFamily: "Inter",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          SizedBox(
            height: 20.h,
          ),
        if (showDivider)
          Divider(
            thickness: 1.5,
            color: Colors.grey.withOpacity(0.07),
          ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Container buildOrderAndWishlist() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
          color: appColors.greyBackGround.withOpacity(0.6),
          border: Border.all(
            width: 1.0,
            color: appColors.red,
          ),
          borderRadius: BorderRadius.circular(15.h)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const MyOrders()));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/orders.png",
                    height: 18.w,
                    width: 18.w,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Orders",
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black.withOpacity(
                          0.7,
                        ),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 40.h,
            width: 1.5.w,
            color: Colors.grey.withOpacity(0.3),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                homeController.wishListPageCalledFromProfile();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/wishlist.png",
                    height: 18.w,
                    width: 18.w,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Wishlist",
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildAccDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            SharedPref.getUserDetails()!['data']['name'],
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 20.sp,
              fontFamily: "Inter",
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            SharedPref.getUserDetails()!['data']['email'],
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              fontFamily: "Inter",
              color: Colors.grey,
            ),
          ),
          Text(
            SharedPref.getUserDetails()!['data']['phone'],
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              fontFamily: "Inter",
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
