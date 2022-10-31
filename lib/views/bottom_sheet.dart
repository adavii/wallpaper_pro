import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

showBottomSHeet(context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.screenshot)),
              title: const Text('Home Screen'),
              onTap: () async {
                await Wallpaper.homeScreen().then(
                  (value) => Navigator.of(context).pop(),
                );
              },
            ),
            ListTile(
              leading:
                  const CircleAvatar(child: Icon(Icons.screen_lock_portrait)),
              title: const Text('Lock Screen'),
              onTap: () async {
                await Wallpaper.lockScreen().then(
                  (value) => Navigator.of(context).pop(),
                );
              },
            ),
            ListTile(
              leading:
                  const CircleAvatar(child: Icon(Icons.stay_current_portrait)),
              title: const Text('Home & Lock Screen'),
              onTap: () async {
                await Wallpaper.bothScreen().then(
                  (value) => Navigator.of(context).pop(),
                );
              },
            ),
          ],
        );
      });
}
