import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laroch/utils/theme_helper.dart';
import 'package:laroch/utils/widgets/appbar.dart';

class ViewImage extends StatefulWidget {
  const ViewImage({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black900,
      appBar: buildCustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [body(widget.imageUrl)],
      ),
    );
  }

  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      leadingWidth: 130,
      centerTitle: true,
      elevation: 0,
      backgroundColor: appColors.black900,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              color: appColors.white,
            ),
          ],
        ),
      ),
    );
  }

  body(imageUrl) {
    return CachedNetworkImage(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
      placeholder: (context, url) => Container(
        color: Colors.white,
        child: Image.asset(
          'assets/images/no_internet.png',
          fit: BoxFit.fitWidth,
        ),
      ),
      errorWidget: (context, value, error) {
        return Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                  "https://t3.ftcdn.net/jpg/00/36/94/26/360_F_36942622_9SUXpSuE5JlfxLFKB1jHu5Z07eVIWQ2W.jpg"),
              fit: BoxFit.contain,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}
