import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaper_pro/catagories.dart';
import 'package:wallpaper_pro/components/text_input.dart';
import 'package:wallpaper_pro/photos_model.dart';
import 'package:wallpaper_pro/popular.dart';

class SearchView extends StatefulWidget {
  final String searchQuery;
  const SearchView({super.key, required this.searchQuery});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late String searchQUery = widget.searchQuery;
  int noOfImageToLoad = imagesperpage;
  List<PhotosModel> photos = [];
  bool noResults = false;

  getSearchResults(String searchQuery) async {
    photos = [];
    searchQUery = searchQuery;
    await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=$searchQuery&per_page=$noOfImageToLoad&page=1",
        ),
        headers: {"Authorization": apiKEY}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      if (jsonData["photos"] == null || jsonData["total_results"] == 0) {
        noResults = true;
      } else {
        jsonData["photos"].forEach((element) {
          PhotosModel photosModel = PhotosModel.fromMap(element);
          photos.add(photosModel);
        });
      }

      setState(() {});
    });
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getSearchResults(searchQUery);
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + imagesperpage;
        getSearchResults(searchQUery);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextInput(
                onsubmit: getSearchResults,
                callback: (val) {},
                icon: Icons.search,
                value: searchQUery,
                title: "Search",
                hindText: "Search anything",
              ),
            ),
            Text(
              noResults ? "No results found for" : "Search Results for",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Overpass',
              ),
            ),
            Text(
              '"$searchQUery"',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 24,
                fontFamily: 'Overpass',
              ),
            ),
            const SizedBox(height: 10),
            wallPaper(photos, context),
            const SizedBox(height: 50),
            if (!noResults) ...[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
