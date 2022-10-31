import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:wallpaper_pro/views/search_view.dart';

class CategorieModel {
  late String categorieName;
  late String imgUrl;
}

String apiKEY = "563492ad6f917000010000017c1283d9fbb649e386b164a574c5eebb";
int imagesperpage = 30;

List<CategorieModel> getCategories() {
  List<CategorieModel> categories = [];
  CategorieModel categorieModel = CategorieModel();

  //
  categorieModel.imgUrl = "assets/images/street_art.jpg";
  categorieModel.categorieName = "Street Art";
  categories.add(categorieModel);
  categorieModel = CategorieModel();

  //
  categorieModel.imgUrl = "assets/images/wild_life.jpg";
  categorieModel.categorieName = "Wild Life";
  categories.add(categorieModel);
  categorieModel = CategorieModel();

  //
  categorieModel.imgUrl = "assets/images/nature.png";
  categorieModel.categorieName = "Nature";
  categories.add(categorieModel);
  categorieModel = CategorieModel();

  //
  categorieModel.imgUrl = "assets/images/city.jpeg";
  categorieModel.categorieName = "City";
  categories.add(categorieModel);
  categorieModel = CategorieModel();

  //
  categorieModel.imgUrl = "assets/images/motivation.jpg";
  categorieModel.categorieName = "Motivation";

  categories.add(categorieModel);
  categorieModel = CategorieModel();

  //
  categorieModel.imgUrl = "assets/images/bike.jpg";
  categorieModel.categorieName = "Bikes";
  categories.add(categorieModel);
  categorieModel = CategorieModel();

  //
  categorieModel.imgUrl = "assets/images/car.jpg";
  categorieModel.categorieName = "Cars";
  categories.add(categorieModel);
  categorieModel = CategorieModel();

  //
  categorieModel.imgUrl = "assets/images/space.jpg";
  categorieModel.categorieName = "Space";
  categories.add(categorieModel);
  categorieModel = CategorieModel();

  return categories;
}

class CategoriesTile extends StatelessWidget {
  final String imgUrls, categorie;

  const CategoriesTile(
      {super.key, required this.imgUrls, required this.categorie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchView(
                      searchQuery: categorie,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8, top: 20, bottom: 20),
        child: kIsWeb
            ? Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(imgUrls),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      categorie,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Overpass',
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(imgUrls),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      categorie,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Overpass',
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
