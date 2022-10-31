class PhotosModel {
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  String avgColor;
  SrcModel src;
  String alt;

  PhotosModel({
    required this.url,
    required this.photographer,
    required this.photographerId,
    required this.photographerUrl,
    required this.avgColor,
    required this.src,
    required this.alt,
  });

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotosModel(
      url: parsedJson["url"],
      photographer: parsedJson["photographer"],
      photographerId: parsedJson["photographer_id"],
      photographerUrl: parsedJson["photographer_url"],
      avgColor: parsedJson["avg_color"],
      src: SrcModel.fromMap(parsedJson["src"]),
      alt: parsedJson["alt"],
    );
  }
}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel({
    required this.portrait,
    required this.landscape,
    required this.large,
    required this.medium,
  });

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
      portrait: srcJson["portrait"],
      large: srcJson["large"],
      landscape: srcJson["landscape"],
      medium: srcJson["medium"],
    );
  }
}
