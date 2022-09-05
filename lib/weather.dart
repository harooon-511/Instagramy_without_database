import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForecastPage extends StatefulWidget{
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {

  Future getData() async {
    final url = Uri.parse('https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.json');
    var request = await http.get(url);

    if (request.statusCode == 200) {
      var json = const Utf8Decoder().convert(request.bodyBytes);
      var map = jsonDecode(json);
      var response = await Response.fromJson(map);
    
    return response;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('東京都の今日の天気'),
      ),
      body:FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("LOADING"),
            );
          }
          // 通信が失敗した場合
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          // 通信が成功した場合
           if (snapshot.hasData) {
            return Center(child: Column(
              children: [
                Text("データ配信元: ${snapshot.data.publishingOffice}"),
                Text('報告日時: ${snapshot.data.reportDatetime}',
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),),
                Text("対象の地域: ${snapshot.data.targetArea}"),
                Text("ヘッドライン: ${snapshot.data.headlineText}"),
                Text("詳細: ${snapshot.data.text}"),
              ],
            ),
            );
          }
          return Text('APIからデータが取れませんでした。');
        }
      ),
    );
  }

}
     


class Response {
  Response({
    required this.publishingOffice,
    required this.reportDatetime,
    required this.targetArea,
    required this.headlineText,
    required this.text,
  });

  String publishingOffice;
  String reportDatetime;
  String targetArea;
  String headlineText;
  String text;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        publishingOffice: json['publishingOffice'] as String,
        reportDatetime: json['reportDatetime'] as String,
        targetArea: json['targetArea'] as String,
        headlineText: json['headlineText'] as String,
        text: json['text'] as String,
      );
}