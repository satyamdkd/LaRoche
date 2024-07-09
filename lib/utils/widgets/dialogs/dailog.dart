import 'package:laroch/module/auth/view/login.dart';
import 'package:laroch/module/home/views/home.dart';
import 'package:laroch/module/home/views/profile.dart';
import 'package:laroch/routes.dart';
import 'package:laroch/utils/helper/sharedpref.dart';

import '../../../const/common_lib.dart';
import '../../../module/home/bloc/home_bloc.dart';

///*********************************************************///
///*************** Logout dialog ***************************///
///*********************************************************///
Controller controller=Controller();
logoutDialogNew(String message,
    {String? title,
    VoidCallback? onTap,
    String? buttonTitle,
    required BuildContext context}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      title: Column(
        children: [
          Image.asset(
            "assets/icons/logout_icon.png",
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 20),
          Text(
            "Sign out?",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: appColors.red),
            textAlign: TextAlign.center,
          )
        ],
      ),
      content: Text(
        "Are you sure you want to\nsign out?",
        style: theme.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                await SharedPref.removeUserDetails();
                Future.delayed(
                  Duration.zero,
                  () {
                  // con bottomNavIndex = 1;

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                         ModalRoute.withName("/login"));

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const Login()));

                    /// GoRouter.of(context).go(Routes.login);

                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: appColors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  'Sign out',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: appColors.greenColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    ),
  );
}

///*********************************************************///
///*************** Deletion dialog ***************************///
///*********************************************************///

deletionDialogNew(String message,
    {String? title,
    onTap,
    String? buttonTitle,
    item,
    callBack,
    required BuildContext context}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      title: const Column(
        children: [
          Icon(
            Icons.delete,
            color: Colors.red,
            size: 50,
          ),
          SizedBox(height: 20),
          Text(
            "Delete?",
            style:
                TextStyle(fontWeight: FontWeight.w500, fontFamily: "Poppins"),
            textAlign: TextAlign.center,
          )
        ],
      ),
      content: const Text(
        "Are you sure you want to\ndelete this item?",
        style: TextStyle(fontWeight: FontWeight.w500, fontFamily: "Poppins"),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  'Delete',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: appColors.greenColor,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    ),
  );
}

///*********************************************************///
///*************** Error dialog ****************************///
///*********************************************************///

errorDialog({
  VoidCallback? onTap,
  String? buttonTitle,
  BuildContext? context,
  message,
}) {
  showDialog(
    context: context!,
    builder: (context) => AlertDialog(
      title: Text(
        "Error occurred!",
        style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500),
      ),
      content: Text(
        message,
        style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400),
      ),
      actions: [
        TextButton(
          onPressed: onTap ??
              () {
                Navigator.of(context).pop();
              },
          child: Text(
            buttonTitle ?? "Okay",
            style: theme.textTheme.bodyLarge?.copyWith(color: appColors.red),
          ),
        ),
      ],
    ),
  );
}
