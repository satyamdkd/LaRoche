import 'package:flutter/cupertino.dart';
import 'package:laroch/const/common_lib.dart';

/// ****************************************************************************
/// ------------------------------ BottomSheet ---------------------------------
/// ****************************************************************************

myBottomSheet(context, {list, void Function(int)? onSelectedItemChanged}) {
  return showCupertinoModalPopup(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return PopScope(
        canPop: false,
        onPopInvoked: (bool canItBePopped) async {},
        child: CupertinoActionSheet(
          cancelButton: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 45.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: appColors.red),
                  child: Text("Done",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: appColors.white)))),
          actions: [
            Container(
                height: 200.h,
                color: appColors.cardBgColor,
                child: CupertinoPicker(
                  itemExtent: 35.h,
                  magnification: 1.1,
                  onSelectedItemChanged: (val) {
                    onSelectedItemChanged!(val);
                  },
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                      background: appColors.greyBackGround.withOpacity(0.2),
                      capEndEdge: false,
                      capStartEdge: false),
                  children: [
                    ...List.generate(
                        list.length,
                        (index) => Text(list[index],
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.black900)))
                  ],
                ))
          ],
        ),
      );
    },
  );
}

/// ****************************************************************************
/// ------------------------------- SnackBar -----------------------------------
/// ****************************************************************************

showSnackBar({required BuildContext context, String? message}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: appColors.red,
    content: Text(
      message ?? "Something went wrong",
      style: TextStyle(color: appColors.white),
    ),
    duration: const Duration(seconds: 1),
  ));
}
