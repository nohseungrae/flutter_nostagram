import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/constants/firestore_keys.dart';

class UserModel {

  final String userKey;
  final String profileImg;
  final String email;
  final List<dynamic> myPosts;
  final int followers;
  final List<dynamic> likedPosts;
  final String username;
  final List<dynamic> followings;

  //데이터를 가지고 왔을 때 해당 Document가 어디 위치해 있는지 저장하는 공간
  final DocumentReference reference;

  UserModel.fromMap(Map<String, dynamic> map, this.userKey, {this.reference})
      : profileImg = map[KEY_PROFILEIMG],
        username = map[KEY_USERNAME],
        email = map[KEY_EMAIL],
        likedPosts = map[KEY_LIKEDPOSTS],
        followers = map[KEY_FOLLOWERS],
        followings = map[KEY_FOLLOWINGS],
        myPosts = map[KEY_MYPOSTS]

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
      snapshot.data,
      snapshot.documentID,
      reference: snapshot.reference
  );
}