import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:terabayt_uz/data/source/remote/api/app_api.dart';
import 'package:terabayt_uz/data/source/remote/response/post_response.dart';
import 'package:terabayt_uz/di/di.dart';
import 'package:terabayt_uz/screens/drawer_list.dart';
import 'package:terabayt_uz/screens/web_view_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

enum _Status { Success, Loading, Error }

class _MainScreenState extends State<MainScreen> {
  final AppApi api = di.get<AppApi>();
  List<Post> posts = <Post>[];
  int categoryId = 14;
  _Status state = _Status.Loading;

  void load() async {
    state = _Status.Loading;
    setState(() {});
    try {
      final response = await api.getPosts(categoryId);
      posts = response;
      state = _Status.Success;
      setState(() {});
    } catch (e) {
      state = _Status.Error;
      setState(() {});
      print(posts[0].publishedAt);
    }
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terabayt"),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (state == _Status.Success) {
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return (index % 5 == 0) ? bigItem(posts[index], index) : longItem(posts[index], index);
                });
          }
          if (state == _Status.Loading) {
            return const Center(child: Text("Loading ..."));
          } else {
            Random random = Random();
            int randomNumber = random.nextInt(2);
            if (randomNumber == 0) {
              return Center(child: Image.asset("assets/error1.gif"));
            } else {
              return Center(child: Image.asset("assets/error2.gif"));
            }
          }
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      "assets/tera_full_logo.png",
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            )),
            DrawerList(onDataReceived: (int id) {
              if (id == 2 || id == 0) {
                categoryId = 482;
              } else {
                categoryId = id;
              }
              print(id);
              load();
            })
          ],
        ),
      ),
    );
  }

  bigItem(Post post, int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(post: posts[index])));
        },
        child: Stack(
          children: [
            Container(
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(post.image),
                    fit: BoxFit.fitWidth,
                  ),
                )),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0x2F000000),
                      Color(0x1A383838),
                      Color(0x5E8E7E7),
                    ], begin: Alignment(1, 0), end: Alignment(1, 1)),
                    color: Colors.black,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        post.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            shadows: [Shadow(color: Colors.black, offset: Offset(2, 1), blurRadius: 6)]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  longItem(Post post, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(post: posts[index])));
      },
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black)]),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: 120,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(
                      post.image,
                    ),
                    fit: BoxFit.fitHeight),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Text(
                      post.title,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            post.categoryName.name,
                            style: const TextStyle(
                              fontSize: 8,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            longToDate(post.publishedAt),
                            style: const TextStyle(fontSize: 8),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String longToDate(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    var newDate = dateTime.toString();
    return newDate.substring(0, newDate.length - 4);
  }
}
