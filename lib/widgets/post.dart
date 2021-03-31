import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/common_size.dart';
import 'package:flutter_app/constants/screen_size.dart';
import 'package:flutter_app/widgets/my_progress_indicator.dart';
import 'package:flutter_app/widgets/rounded_avatar.dart';

import 'comment.dart';

class Post extends StatelessWidget {
  final int num;

  Post(this.num,{
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCation()
      ],
    );
  }

  Widget _postCation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        showImage: false,
        username: 'nolec',
        text: 'my name is nolec',
        dateTime: DateTime.now(),
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
          padding: const EdgeInsets.only(left: common_gap),
          child: Text(
              '12000 Likes',
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
      );
  }

  Row _postActions() {
    return Row(
        children: [
          IconButton(
              icon: ImageIcon(
              AssetImage('assets/images/bookmark.png'),
              color: Colors.black87),
              onPressed: null
          ),
          IconButton(
              icon: ImageIcon(
                  AssetImage('assets/images/comment.png'),
                  color: Colors.black87),
              onPressed: null
          ),
          IconButton(
              icon: ImageIcon(
                  AssetImage('assets/images/direct_message.png'),
                  color: Colors.black87),
              onPressed: null
          ),
          Spacer(),
          IconButton(
              icon: ImageIcon(
                  AssetImage('assets/images/heart_selected.png'),
                  color: Colors.black87),
              onPressed: null
          )
        ],
      );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
          imageUrl: 'https://picsum.photos/id/$num/200/300',
          placeholder: (BuildContext context, String url) {
            return MyProgressIndicator(containerSize: size.width);
          },
          imageBuilder: (BuildContext context, ImageProvider imageProvider ){
            return AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image : imageProvider, fit : BoxFit.cover)
                ),
              ),
            );
          },
      );
  }

  Widget _postHeader() {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.all(common_xxs_gap),
            child: RoundedAvatar()
        ),
        Expanded(child: Text('username')),
        IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black87,
            ) ,
            onPressed: null)
      ],
    );
  }
}
