import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  static rout() => MaterialPageRoute(builder: (context) => BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Blog Page")));
  }
}
