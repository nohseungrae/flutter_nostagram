import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/garlley_state.dart';
import 'package:flutter_app/screens/share_post_screen.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(
      builder: (BuildContext context, GalleryState galleryState, Widget child) {
        return GridView.count(
            crossAxisCount: 3, children: getImages(context, galleryState));
      },
    );
  }

  List<Widget> getImages(BuildContext context, GalleryState galleryState) {
    print(galleryState.images);
    return galleryState.images
        .map((localImage) => InkWell(
            onTap: () async {
              Uint8List bytes = await localImage.getScaledImageBytes(
                  galleryState.localImageProvider, 0.3);

              final String timeInMilli =
                  DateTime.now().millisecondsSinceEpoch.toString();
              try {
                final path = join(
                    (await getTemporaryDirectory()).path, '$timeInMilli.png');
                File imageFile = File(path)..writeAsBytesSync(bytes);
                //..를 쓰면 생성된 파일의 메소드를 실행하고 그 파일을 그대로 리턴한 것
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SharePostScreen(imageFile)));
              } catch (e) {}
            },
            child: Image(
                fit: BoxFit.cover, image: DeviceImage(localImage, scale: 0.2))))
        .toList();
  }
}
