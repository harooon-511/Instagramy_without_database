import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagramy/feed.dart';
import 'package:instagramy/addPost.dart';
import 'package:instagramy/weather.dart';
void main() {
  runApp(const ProviderScope(
    child: MyApp())
 );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Feedpage(),
      routes: <String, WidgetBuilder> {
        'add': (context) => const addPostPage(),
        'weather': (context) => const ForecastPage(),
      },
    );
  }
}



