import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/model/post.dart';
import '../widgets/post_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts = [];
  bool isLoading = false;
  int start = 0;
  int limit = 10;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchPosts();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchPosts();
      }
    });
  }

  void fetchPosts() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List<dynamic>;
        setState(() {
          posts.addAll(data.map((json) => Post.fromJson(json)).toList());
          start += limit;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: 24),
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: posts.length + 1, // Add 1 for progress indicator
        itemBuilder: (context, index) {
          if (index < posts.length) {
            var post = posts[index];
            return PostCardWidget(post: post);
          } else if (isLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
