import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../const/common_lib.dart';

class MyRatings extends StatelessWidget {
  const MyRatings(
      {super.key,
      required this.rating,
      this.fontSize,
      this.padding,
      this.onPressed,
      this.alignment,
      this.textColor,
      this.fontWeight,
      this.margin,
      this.itemSize,
      this.ignoreGestures,
      this.textAlign,
      this.letterSpacing,
      this.maxLines,
      this.onRatingUpdate,
      this.fontFamily,
      this.updateOnDrag,
      this.width});

  final double? rating;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;
  final AlignmentGeometry? alignment;
  final Color? textColor;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? margin;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final int? maxLines;
  final String? fontFamily;
  final double? width;
  final bool? ignoreGestures;
  final double? itemSize;
  final void Function(double)? onRatingUpdate;
  final bool? updateOnDrag;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: 20.h,
        alignment: alignment ?? Alignment.bottomCenter,
        padding: padding,
        margin: margin,
        child: RatingBar.builder(
          initialRating: rating ?? 1.0,
          minRating: 1,
          itemSize: itemSize ?? 15.h,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ignoreGestures: ignoreGestures ?? false,
          itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: onRatingUpdate ??
              (rating) {
              debugPrint(rating.toString());
              },
          updateOnDrag: updateOnDrag ?? false,
        ));
  }
}
