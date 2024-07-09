import '../../const/common_lib.dart';

CustomAppBar buildCustomAppBar({required title}) {
  return CustomAppBar(
    title: Text(
      title,
      style: theme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20.sp,
        color: Colors.black,
        fontFamily: "Inter",
      ),
    ),
  );
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  final double? height;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: elevation ?? 4,
        backgroundColor: backgroundColor ?? Colors.white,
        shadowColor: Colors.grey.withOpacity(0.06),
        title: title,
        leading: leading,
        actions: actions);
  }

  MediaQueryData mediaQueryData = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single);

  @override
  Size get preferredSize => Size(mediaQueryData.size.width, height ?? 50.h);
}
