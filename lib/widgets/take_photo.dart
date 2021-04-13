import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/screen_size.dart';
import 'package:flutter_app/widgets/my_progress_indicator.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {

  CameraController _controller;
  Widget _progress = MyProgressIndicator();

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
      future: availableCameras(),
      builder: (context, snapshot) {
        print(snapshot.data);
        return Column(
          children: [
            Container(
              width: size.width,
              height : size.width,
              color : Colors.black,
              child: (snapshot.data.length > 0) ? _getPreview(snapshot.data) : _progress,
            ),
            Expanded(
                child: OutlinedButton(
                  child: Text(''),
                  onPressed: () {
                    print('hello');
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(size.width / 3, 0),
                      shape: CircleBorder(),
                      side: BorderSide(color : Colors.black12, width: 20)
                  ),
                )
            )
          ],
        );
      }
    );
  }

  Widget _getPreview (List<CameraDescription> cameras) {
    _controller = CameraController(cameras[0], ResolutionPreset.medium);

    return FutureBuilder(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return OverflowBox(
            alignment: Alignment.center,
            child: Container(
                width: size.width,
                height: size.width / _controller.value.aspectRatio,
                child: CameraPreview(_controller)),
          );
        } else {
          return _progress;
        }
      }
    );
  }
}