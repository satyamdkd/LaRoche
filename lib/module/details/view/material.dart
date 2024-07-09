import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laroch/const/common_lib.dart';

import '../../../utils/widgets/appbar.dart';
class MaterialView extends StatefulWidget {
  String? image_url;
   MaterialView({super.key, this.image_url});

  @override
  State<MaterialView> createState() => _MaterialViewState();
}

class _MaterialViewState extends State<MaterialView> {
  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      title: Text(
        "Material",
        style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.black),
      ),
    );
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: Container(color: Colors.white,
        child: CachedNetworkImage(
          imageUrl:widget.image_url!,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter:
                  ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
            ),
          ),
          placeholder: (context, url) => Center(child: CircularProgressIndicator(backgroundColor: Colors.white,color: appColors.red,)),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
