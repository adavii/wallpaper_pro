import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_pro/views/image_view.dart';
import 'photos_model.dart';
// import 'image_view.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Widget wallPaper(List<PhotosModel> listPhotos, BuildContext context) {
  return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: listPhotos.map((PhotosModel photoModel) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewImage(
                  image: photoModel,
                ),
              ),
            );
          },
          child: Hero(
            tag: photoModel.src.portrait,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: kIsWeb
                  ? Image.network(
                      photoModel.src.portrait,
                      height: 50,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: photoModel.src.portrait,
                      placeholder: (context, url) => Container(
                        color: HexColor(photoModel.avgColor),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ));
      }).toList());
}

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
      ),
      Text(
        "Pro",
        style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
      )
    ],
  );
}
