import 'dart:async';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

class ViewImage extends StatefulWidget {
  final String imageUrl;
  const ViewImage({super.key, required this.imageUrl});

  @override
  createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";

  late Stream<String> progressString;
  late String res;
  bool downloading = false;
  var result = "Waiting to set wallpaper";
  bool _isDisable = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("Wallpapers Pro"),
      //   backgroundColor: Colors.red,
      // ),
      body: Stack(
        children: [
          Hero(
            tag: widget.imageUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: kIsWeb
                  ? Image.network(
                      widget.imageUrl,
                      height: 00,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      height: MediaQuery.of(context).size.height,
                      // width: MediaQuery.of(context).size.width,
                      placeholder: (context, url) => Container(
                        color: Color(
                          (math.Random().nextDouble() * 0xFFFFFF).toInt(),
                        ).withOpacity(1.0),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(19, 0, 0, 0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24, width: 1),
                            borderRadius: BorderRadius.circular(40),
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(0, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Set Wallpaper",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                          ],
                        )),
                  ],
                )),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )
          // ElevatedButton(
          //   onPressed: () async {
          //     return await dowloadImage(context);
          //   },
          //   child: const Text("Set as Wallapaper"),
          // ),
          // ElevatedButton(
          //   onPressed: _isDisable
          //       ? null
          //       : () async {
          //           var width = MediaQuery.of(context).size.width;
          //           var height = MediaQuery.of(context).size.height;
          //           home = await Wallpaper.homeScreen(
          //               options: RequestSizeOptions.RESIZE_FIT,
          //               width: width,
          //               height: height);
          //           setState(() {
          //             downloading = false;
          //             home = home;
          //           });
          //         },
          //   child: Text(home),
          // ),
          // ElevatedButton(
          //   onPressed: _isDisable
          //       ? null
          //       : () async {
          //           lock = await Wallpaper.lockScreen();
          //           setState(() {
          //             downloading = false;
          //             lock = lock;
          //           });
          //         },
          //   child: Text(lock),
          // ),
          // ElevatedButton(
          //   onPressed: _isDisable
          //       ? null
          //       : () async {
          //           both = await Wallpaper.bothScreen();
          //           setState(() {
          //             downloading = false;
          //             both = both;
          //           });
          //         },
          //   child: Text(both),
          // ),
          // ElevatedButton(
          //   onPressed: _isDisable
          //       ? null
          //       : () async {
          //           system = await Wallpaper.systemScreen();
          //           setState(() {
          //             downloading = false;
          //             system = system;
          //           });
          //         },
          //   child: Text(system),
          // ),
        ],
      ),
    );
  }

  Future<void> dowloadImage(BuildContext context) async {
    progressString = Wallpaper.imageDownloadProgress(widget.imageUrl);
    progressString.listen((data) {
      setState(() {
        res = data;
        downloading = true;
      });
    }, onDone: () async {
      setState(() {
        downloading = false;

        _isDisable = false;
      });
    }, onError: (error) {
      setState(() {
        downloading = false;
        _isDisable = true;
      });
    });
  }

  Widget imageDownloadDialog() {
    return SizedBox(
      height: 120.0,
      width: 200.0,
      child: Card(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: 20.0),
            Text(
              "Downloading File : $res",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
