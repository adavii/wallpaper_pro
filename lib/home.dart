import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaper_pro/catagories.dart';
import 'package:wallpaper_pro/components/text_input.dart';
import 'package:wallpaper_pro/photos_model.dart';
import 'package:wallpaper_pro/popular.dart';
import 'package:wallpaper_pro/views/search_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int noOfImageToLoad = imagesperpage;
  List<CategorieModel> categories = [];
  List<PhotosModel> photos = [];

  getTrendingWallpaper() async {
    await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1"),
      headers: {"Authorization": apiKEY},
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });

      setState(() {});
    });
  }

  TextEditingController searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    categories = getCategories();
    getTrendingWallpaper();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + imagesperpage;
        getTrendingWallpaper();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Wallpapers Pro"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextInput(
                callback: (val) {},
                onsubmit: (val) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchView(
                        searchQuery: val,
                      ),
                    ),
                  );
                },
                icon: Icons.search,
                title: "Search",
                hindText: "Search Wallpaper",
                suffixWidget: const Icon(Icons.chevron_right_rounded),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    /// Create List Item tile
                    return CategoriesTile(
                      imgUrls: categories[index].imgUrl,
                      categorie: categories[index].categorieName,
                    );
                  }),
            ),
            const Text(
              "Today's Collection",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Overpass',
              ),
            ),
            const SizedBox(height: 10),
            wallPaper(photos, context),
            const SizedBox(height: 50),
            const Center(
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
