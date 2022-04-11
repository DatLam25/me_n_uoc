library menuoc;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'globals.dart' as globals;

part 'homepage.dart';
part 'login.dart';
part 'register.dart';
part 'chat.dart';
part 'detailedPost.dart';
part 'profile.dart';

final storage = new FlutterSecureStorage();
Session session = Session();

void main() {
  runApp(const MyApp());
}


Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};
const String logoAsset = 'assets/logo.svg';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Me&UofC',
      theme: ThemeData(
        primarySwatch: MaterialColor(0XFFFCE4EC, color),
      ),
      home: const HomePage(),
    );
  }
}

class Post {
  String title;
  String content;
  String creator;
  int postId;

  Post(this.title, this.content, this.postId, this.creator);
}

class Comment{
  String text;
  String user;
  int totalLike;

  Comment(this.text, this.user, this.totalLike);
}

class PostWithComment extends Post{
  List<Comment> comments = [];
  int totalLike;

  PostWithComment(title, content, postId, creator, this.comments, this.totalLike) : super(title, content, postId, creator);
}

class Session {
  Map<String, String> headers = {};

  Future<Map> get(String url) async {
    http.Response response = await http.get(Uri.parse(url) , headers: headers);
    updateCookie(response);
    return jsonDecode(response.body);
  }

  Future<Map> post(String url, dynamic data) async {
    http.Response response = await http.post(Uri.parse(url) , body: data, headers: headers);
    updateCookie(response);
    return jsonDecode(response.body);
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}


