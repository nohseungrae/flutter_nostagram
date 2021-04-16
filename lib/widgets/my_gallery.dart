import 'package:flutter/material.dart';
import 'package:flutter_app/models/garlley_state.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context,GalleryState galleryState,Widget child) {
        return GridView.count(
          crossAxisCount: 3,
          children: getImages(galleryState)
        );
      },
    );
  }

  List<Widget> getImages(GalleryState galleryState) {
    print(galleryState.images);
   return galleryState.images
       .map((localImage) => Image(
        image: DeviceImage(localImage)
   )).toList();
  }
}
