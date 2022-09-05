import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagramy/postitem.dart';
import 'package:english_words/english_words.dart';


final instaProvider = ChangeNotifierProvider((ref)=> InstaFeedNotifier());

class InstaFeedNotifier extends ChangeNotifier{
  // ボトムバー関連
  int bottomIndex = 0;

  // void changeBottomBarIndex(int index) {
  //   bottomIndex = index;
  //   Navigator.of(context).pushNamed('weather');
  //   notifyListeners(); 
  // }

  // サンプル画像
  List postImages = ['images/tokyo.jpeg','images/image1.jpeg','images/image2.jpeg','images/image3.jpeg','images/image4.jpeg','images/image5.jpeg'];

  // サンプル投稿
  final Posts = [
    PostItem(
      id: 0, 
      username: 'harooon', 
      place: '江ノ島',
      pic: 'images/tokyo.jpeg', 
      content: '映えてきたよ！　#江ノ島 #ootd',
    ),
    PostItem(
      id: 1, 
      username: 'balooon', 
      place: '嵐山~Arashiyama~',
      pic: 'images/image1.jpeg', 
      content: '京都にこんな場所があるって知らなかった...今日はありがとう💌',
    ),
  ];

   List<PostItem> get posts => Posts;

  void addPostItem(Map<String, String> formValue){
    Posts.add(
      PostItem(
      id: Posts.length + 1, 
      username: WordPair.random().asString, 
      place: formValue['place']!, 
      pic: formValue['pic']!, 
      content: formValue['content']!
      ),
    );
    notifyListeners();          
  }
}