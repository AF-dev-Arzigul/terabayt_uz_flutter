import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../data/source/remote/response/post_response.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.categoryName.name),

      ),
      body:SingleChildScrollView(child: Html(data: widget.post.content,)),
    );
  }
}
