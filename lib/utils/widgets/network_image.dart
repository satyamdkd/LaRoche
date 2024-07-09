import 'package:cached_network_image/cached_network_image.dart';
import '../../const/common_lib.dart';


imageBuilder(imageUrl, {height, width}) {
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
