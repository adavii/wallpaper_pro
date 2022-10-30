import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_pro/views/image_view.dart';
import 'photos_model.dart';
// import 'image_view.dart';

Widget wallPaper(List<PhotosModel> listPhotos, BuildContext context) {
  return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
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
                  imageUrl: photoModel.src.portrait,
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
                        color: Color(
                          (math.Random().nextDouble() * 0xFFFFFF).toInt(),
                        ).withOpacity(1.0),
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
